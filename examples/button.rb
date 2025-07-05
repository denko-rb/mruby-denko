PIN = 4
board = Denko::Board.new

# Connect button between a GPIO pin and ground.
button = Denko::DigitalIO::Button.new(board: board, pin: PIN, mode: :input_pullup)

# Read initial state.
button.read

# Add callbacks.
button.up do
  puts "Button released!" unless button.high?
end

button.down do
  puts "Button pressed!" unless button.low?
end

# Read the button approximately every 1ms in and endless loop.
loop do
  button.read
  board.micro_delay(1000)
end
