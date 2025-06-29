PIN = 6
board = Denko::Board.new

# Give built-in LED pin, or connect external LED to a pin.
# Will not work with built in WS2812 LEDs.
#
# Note:
#   Using DigitalIO::Output.new here (instead of LED.new) avoids
#   using PWM for the LED. This improves performance, and
#   leaves a PWM channel free for other components, but the
#   LED can only be fully on or off. See led_pulse.rb
led = Denko::DigitalIO::Output.new(board: board, pin: PIN)

# Blink every half second.
loop do
  led.on
  sleep 0.5
  led.off
  sleep 0.5
end
