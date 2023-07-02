puts
ver = Denko::Board.sdk_version
puts "Built with ESP-IDF #{ver}"
puts "#{MRUBY_DESCRIPTION} #{MRUBY_COPYRIGHT[6..-1]}"
puts "Denko version: #{Denko::VERSION}"
mem = $board.free_memory / 1024
puts "Free heap: #{mem}kB"

# Use submodules without Denko:: prefix.
include Denko

# Blink an LED connected to pin 8 every half second.
# No support for built in WS2812 yet.
led = LED.new(pin: 8)
loop do
  led.on
  sleep 0.5
  led.off
  sleep 0.5
end
