# Use submodules without Denko:: prefix.
include Denko

# Blink built-in LED every half second.
led = LED.new(pin: 2)

# Fade the LED up and down. 8-bit PWM.
loop do
  i = 0
  while (i < 256) do
    led.write i
    i += 1
    sleep 0.01
  end
  
  i=255
  while (i > -1) do
    led.write i
    i -= 1
    sleep 0.01
  end
end
