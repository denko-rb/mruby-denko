puts
ver = Denko::Board.sdk_version
puts "Built with ESP-IDF #{ver}"
puts "#{MRUBY_DESCRIPTION} #{MRUBY_COPYRIGHT[6..-1]}"
puts "Denko version: #{Denko::VERSION}"
mem = $board.free_memory / 1024
puts "Free heap: #{mem}kB"

# Use submodules without Denko:: prefix.
include Denko

# Blink built-in LED every half second.
led = LED.new(pin: 10)
loop do
  led.on
  sleep 0.5
  led.off
  sleep 0.5
end
