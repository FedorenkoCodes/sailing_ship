# frozen_string_literal: true

require_relative 'data_provider'

class CurrencyConverter
  def self.convert_to_eur(amount, currency, date)
    return amount.to_f if currency == ENV['DEFAULT_CURRENCY']

    exchange_rate_for_a_date = DataProvider.instance.exchange_rates[date]
    raise "Exchange rate not found for date #{date}" if exchange_rate_for_a_date.nil?

    exchange_rate = exchange_rate_for_a_date[currency.downcase]
    raise "Exchange rate not found for #{currency} on #{date}" if exchange_rate.nil?

    (amount.to_f / exchange_rate).round(2)
  end
end
