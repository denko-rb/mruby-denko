PIN = 8
board = Denko::Board.new
adc   = Denko::AnalogIO::Input.new(board: board, pin: PIN)

# Read the ADC every second.
loop do
  puts "ADC reading is: #{adc.read}"
  sleep 1
end
