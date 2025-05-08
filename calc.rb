require 'json'

def get_user_input
  origin_port = nil
  destination_port = nil
  criteria = nil

  while (line = gets)
    line = line.chomp

    if origin_port.nil?
      origin_port = line
    elsif destination_port.nil?
      destination_port = line
    elsif criteria.nil?
      criteria = line
    end
  end

  return [origin_port, destination_port, criteria]
end

def input_valid?(origin_port, destination_port, criteria)
  return false unless origin_port && destination_port && criteria
  return false if origin_port.length >= 100 || destination_port.length >= 100 || criteria.length >= 100

  true
end

origin_port, destination_port, criteria = get_user_input

if input_valid?(origin_port, destination_port, criteria)
  output_data = [
    {
      origin_port: origin_port,
      destination_port: destination_port,
      criteria: criteria,
    }
  ]
  output_json = JSON.pretty_generate(output_data)
  puts output_json
else
  puts "Invalid input"
end

exit
