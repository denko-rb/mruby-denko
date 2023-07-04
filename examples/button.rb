# Use submodules without Denko:: prefix.
include Denko

# Connect button between a GPIO pin and ground.
button = DigitalIO::Button.new(pin: 4, pullup: true)

# Add callbacks.
button.up do
  puts "Button released!"
end

button.down do
  puts "Button pressed!"
end

# Read initial state.
button.read

# Read the button approximately every 1ms in and endless loop.
loop do
  button.read
  $board.micro_sleep(1000)
end
