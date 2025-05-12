# frozen_string_literal: true

require 'rspec'
require_relative '../modes/fastest_calculator'
require_relative '../data_provider'

RSpec.describe FastestCalculator do
  describe '.calculate' do
    let(:origin_port) { 'CNSHA' }
    let(:destination_port) { 'NLRTM' }
    let(:fastest_sailings) do
      [
        {
          'origin_port' => 'CNSHA',
          'destination_port' => 'NLRTM',
          'departure_date' => '2022-02-01',
          'arrival_date' => '2022-02-10',
          'sailing_code' => 'ABCD'
        },
        {
          'origin_port' => 'CNSHA',
          'destination_port' => 'NLRTM',
          'departure_date' => '2022-02-20',
          'arrival_date' => '2022-02-10',
          'sailing_code' => 'EFGH'
        }
      ]
    end
    let(:slowest_sailings) do
      [
        {
          'origin_port' => 'CNSHA',
          'destination_port' => 'NLRTM',
          'departure_date' => '2022-02-01',
          'arrival_date' => '2022-02-10',
          'sailing_code' => 'ABCD'
        },
        {
          'origin_port' => 'CNSHA',
          'destination_port' => 'NLRTM',
          'departure_date' => '2022-02-20',
          'arrival_date' => '2022-03-25',
          'sailing_code' => 'DFGG'
        }
      ]
    end
    let(:sailings) do
      [
        fastest_sailings,
        slowest_sailings
      ]
    end

    describe 'when there are fastest sailings' do
      before do
        allow(described_class).to receive_messages(find_all_legs: sailings, populate_rate: [])
      end

      it 'returns the correct fastest leg' do
        result = described_class.calculate(origin_port, destination_port)
        expect(result).to eq(fastest_sailings)
      end
    end

    describe 'when there are no sailings found' do
      before do
        allow(described_class).to receive(:find_all_legs).and_return([])
      end

      it 'returns an empty array if no sailings are found' do
        allow(described_class).to receive(:find_all_legs).and_return([])
        result = described_class.calculate(origin_port, destination_port)
        expect(result).to eq([])
      end

      it 'prints correct error message' do
        allow(described_class).to receive(:find_all_legs).and_return([])
        expect do
          described_class.calculate(origin_port,
                                    destination_port)
        end.to output("No sailings found between CNSHA and NLRTM\n").to_stdout
      end
    end
  end

  describe '.calculate_leg_total_duration' do
    let(:sailings) do
      [
        {
          'origin_port' => 'CNSHA',
          'destination_port' => 'NLRTM',
          'departure_date' => '2022-02-01',
          'arrival_date' => '2022-02-10',
          'sailing_code' => 'ABCD'
        },
        {
          'origin_port' => 'CNSHA',
          'destination_port' => 'NLRTM',
          'departure_date' => '2022-02-20',
          'arrival_date' => '2022-02-25',
          'sailing_code' => 'EFGH'
        }
      ]
    end

    it 'calculates the total duration of sailings' do
      total_duration = described_class.calculate_leg_total_duration(sailings)
      expect(total_duration).to eq(14)
    end
  end
end
