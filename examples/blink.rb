# Use submodules without Denko:: prefix.
include Denko

# Blink built-in LED every half second.
led = LED.new(pin: 2)
loop do
  led.on
  sleep 0.5
  led.off
  sleep 0.5
end
