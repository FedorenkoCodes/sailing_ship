# frozen_string_literal: true

require_relative '../lib/data_provider'
require_relative '../lib/currency_converter'

class BaseCalculator
  def self.find_all_legs(origin_port, destination_port, sailings, previous_arrival_date = nil)
    legs = []

    sailings.each do |sailing|
      next if should_skip_sailing?(sailing, previous_arrival_date)

      if sailing['origin_port'] == origin_port
        if sailing['destination_port'] == destination_port
          legs << [sailing]
        else
          legs += find_next_legs(sailing, destination_port, sailings)
        end
      end
    end

    legs.map { |leg| leg.map { |s| populate_rate(s) } }
  end

  def self.should_skip_sailing?(sailing, previous_arrival_date)
    previous_arrival_date && sailing['departure_date'] < previous_arrival_date
  end

  def self.find_next_legs(sailing, destination_port, sailings)
    remaining_sailings = sailings.reject { |s| s == sailing }
    next_legs = find_all_legs(sailing['destination_port'], destination_port, remaining_sailings,
                              sailing['arrival_date'])

    next_legs.map { |next_leg| [sailing] + next_leg }
  end

  def self.populate_rate(sailing)
    rate = find_rate_for_sailing(sailing)
    raise "No rate found for sailing #{sailing['sailing_code']}" if rate.nil?

    update_sailing_with_rate(sailing, rate)
    sailing
  end

  def self.find_rate_for_sailing(sailing)
    DataProvider.instance.rates.find { |r| r['sailing_code'] == sailing['sailing_code'] }
  end

  def self.update_sailing_with_rate(sailing, rate)
    sailing['rate'] = rate['rate'].to_f
    sailing['rate_currency'] = rate['rate_currency']
    sailing['converted_rate'] =
      CurrencyConverter.convert_to_eur(rate['rate'], rate['rate_currency'], sailing['departure_date'])
  end
end
