PIN = 8
board = Denko::Board.new

# Give built-in LED pin, or connect external LED to a pin.
# Will not work with built in WS2812 LEDs.
led = Denko::DigitalIO::Output.new(board: board, pin: PIN)

# Blink every half second.
loop do
  led.on
  sleep 0.5
  led.off
  sleep 0.5
end
