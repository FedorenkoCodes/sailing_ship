# frozen_string_literal: true

require 'rspec'
require 'date'
require_relative '../modes/base_calculator'
require_relative '../data_provider'

RSpec.describe BaseCalculator do
  describe '.find_all_legs' do
    let(:origin_port) { 'CNSHA' }
    let(:destination_port) { 'NLRTM' }
    let(:sailings) do
      [
        {
          'origin_port' => 'CNSHA',
          'destination_port' => 'NLRTM',
          'departure_date' => '2022-02-01',
          'arrival_date' => '2022-03-01',
          'sailing_code' => 'ABCD'
        },
        {
          'origin_port' => 'CNSHA',
          'destination_port' => 'NLRTM',
          'departure_date' => '2022-02-02',
          'arrival_date' => '2022-03-02',
          'sailing_code' => 'EFGH'
        },
        {
          'origin_port' => 'CNSHA',
          'destination_port' => 'NLRTM',
          'departure_date' => '2022-01-31',
          'arrival_date' => '2022-02-28',
          'sailing_code' => 'IJKL'
        },
        {
          'origin_port' => 'CNSHA',
          'destination_port' => 'NLRTM',
          'departure_date' => '2022-01-30',
          'arrival_date' => '2022-03-05',
          'sailing_code' => 'MNOP'
        },
        {
          'origin_port' => 'ESBCN',
          'destination_port' => 'NLRTM',
          'departure_date' => '2022-01-29',
          'arrival_date' => '2022-02-15',
          'sailing_code' => 'QRST'
        },
        {
          'origin_port' => 'CNSHA',
          'destination_port' => 'ESBCN',
          'departure_date' => '2022-01-29',
          'arrival_date' => '2022-02-12',
          'sailing_code' => 'ERXQ'
        },
        {
          'origin_port' => 'ESBCN',
          'destination_port' => 'NLRTM',
          'departure_date' => '2022-02-15',
          'arrival_date' => '2022-03-29',
          'sailing_code' => 'ETRF'
        }
      ]
    end

    let(:incorrect_sailings) do
      [
        {
          'origin_port' => 'CNSHA',
          'destination_port' => 'ESBCN',
          'departure_date' => '2022-01-29',
          'arrival_date' => '2022-02-15',
          'sailing_code' => 'ERXQ'
        },
        {
          'origin_port' => 'ESBCN',
          'destination_port' => 'NLRTM',
          'departure_date' => '2022-02-12',
          'arrival_date' => '2022-03-29',
          'sailing_code' => 'ETRF'
        }
      ]
    end

    it 'returns all legs between the origin and destination ports' do
      result = described_class.find_all_legs(origin_port, destination_port, sailings)
      expect(result.size).to eq(5)
    end

    it 'returns legs with correct sailing codes' do
      result = described_class.find_all_legs(origin_port, destination_port, sailings)
      sailing_codes = result.flatten.map { |sailing| sailing['sailing_code'] }
      expect(sailing_codes).to contain_exactly('ABCD', 'EFGH', 'IJKL', 'MNOP', 'ERXQ', 'ETRF')
    end

    it 'does not return legs with sailings where departure date is before the arrival date' do
      result = described_class.find_all_legs(origin_port, destination_port, incorrect_sailings)
      expect(result.size).to eq(0)
    end
  end
end
