# Use submodules without Denko:: prefix.
include Denko

# Connect button between a GPIO pin and ground.
button = DigitalIO::Button.new(pin: 4, pullup: true)

# Give built-in LED pin, or connect external LED to a pin.
# Will not work with built in WS2812 LEDs.
led = LED.new(pin: 2)

# Add callbacks so LED is only lit when button is pressed.
button.up   { led.off }
button.down { led. on }

# Read initial state.
button.read

# Read the button approximately every 1ms in and endless loop.
loop do
  button.read
  $board.micro_sleep(1000)
end
