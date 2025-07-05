BUTTON_PIN = 4
LED_PIN = 6
board = Denko::Board.new

button = Denko::DigitalIO::Button.new(board: board, pin: BUTTON_PIN, mode: :input_pullup)
led    = Denko::DigitalIO::Output.new(board: board, pin: LED_PIN)

# Read initial state.
button.read

# Add callbacks so LED is only lit when button is pressed.
button.up   { led.off }
button.down { led. on }

# Read the button approximately every 1ms in and endless loop.
loop do
  button.read
  board.micro_delay(1000)
end
