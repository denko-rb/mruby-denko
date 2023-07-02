# Use submodules without Denko:: prefix.
include Denko

# Connect a button to GPIO4.
button = DigitalIO::Button.new(pin: 4, pullup: true)

# Built-in LED or LED to GPIO2.
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
