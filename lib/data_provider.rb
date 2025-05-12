# frozen_string_literal: true

require 'json'

class DataProvider
  attr_reader :sailings, :rates, :exchange_rates

  def initialize
    data = JSON.parse(File.read(ENV.fetch('DATA_FILE', nil)))

    @sailings = data['sailings']
    @rates = data['rates']
    @exchange_rates = data['exchange_rates']
  end

  def self.instance
    @instance ||= new
  end
end
