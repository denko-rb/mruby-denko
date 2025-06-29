puts
ver = ESP32::System.sdk_version
puts "Built with ESP-IDF #{ver}"
puts "#{MRUBY_DESCRIPTION} #{MRUBY_COPYRIGHT[6..-1]}"
puts "Denko version: #{Denko::VERSION}"
mem = ESP32::System.available_memory / 1000
puts "Free heap: #{mem}k"

PIN = 6
board = Denko::Board.new

# Blink an LED connected to pin 8 every half second.
# No support for built in WS2812 yet.
led = Denko::DigitalIO::Output.new(board: board, pin: PIN)
loop do
  led.on
  sleep 0.5
  led.off
  sleep 0.5
end
