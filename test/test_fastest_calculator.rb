# frozen_string_literal: true

require 'minitest/autorun'
require 'dotenv'
require_relative '../modes/fastest_calculator'
require_relative '../data_provider'

class TestFastestCalculator < Minitest::Test
  def setup
    Dotenv.load

    @data_provider = DataProvider.instance
    @data_provider.sailings = [
      {
        'origin_port' => 'A',
        'destination_port' => 'B',
        'departure_date' => '2023-01-01',
        'arrival_date' => '2023-01-02',
        'sailing_code' => 'A1'
      },
      {
        'origin_port' => 'A',
        'destination_port' => 'B',
        'departure_date' => '2023-01-03',
        'arrival_date' => '2023-01-04',
        'sailing_code' => 'A2'
      },
      {
        'origin_port' => 'B',
        'destination_port' => 'C',
        'departure_date' => '2023-01-02',
        'arrival_date' => '2023-01-03',
        'sailing_code' => 'B1'
      },
      {
        'origin_port' => 'B',
        'destination_port' => 'D',
        'departure_date' => '2023-01-02',
        'arrival_date' => '2023-01-05',
        'sailing_code' => 'B2'
      }
    ]

    @data_provider.rates = [
      {
        'sailing_code' => 'A1',
        'rate_currency' => 'USD',
        'rate' => 100
      },
      {
        'sailing_code' => 'A2',
        'rate_currency' => 'USD',
        'rate' => 200
      },
      {
        'sailing_code' => 'B1',
        'rate_currency' => 'EUR',
        'rate' => 300
      },
      {
        'sailing_code' => 'B2',
        'rate_currency' => 'EUR',
        'rate' => 400
      }
    ]

    @data_provider.exchange_rates = {
      '2023-01-01' => {
        'usd' => 1,
        'eur' => 2
      },
      '2023-01-02' => {
        'usd' => 1,
        'eur' => 2
      },
      '2023-01-03' => {
        'usd' => 1,
        'eur' => 2
      }
    }
  end

  def test_calculate_fastest_leg
    result = FastestCalculator.calculate('A', 'B')
    assert_equal 1, result.size
    assert_equal '2023-01-01', result.first['departure_date']
    assert_equal '2023-01-02', result.first['arrival_date']
  end

  def test_calculate_no_sailings
    result = FastestCalculator.calculate('B', 'A')
    assert result.empty?
  end

  def test_calculate_leg_total_duration
    sailings = [
      {
        'departure_date' => '2023-01-01',
        'arrival_date' => '2023-01-02'
      },
      {
        'departure_date' => '2023-01-02',
        'arrival_date' => '2023-01-03'
      }
    ]
    duration = FastestCalculator.calculate_leg_total_duration(sailings)
    assert_equal 2, duration
  end
end
