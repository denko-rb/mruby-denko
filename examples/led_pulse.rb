PIN = 6
board = Denko::Board.new

# Give built-in LED pin, or connect external LED to a pin.
# Will not work with built in WS2812 LEDs.
led = Denko::LED.new(board: board, pin: PIN)

RISING = (0..100).to_a
FALLING = (1..99).to_a.reverse

# Fade the LED up and down. PWM in 0-100% duty cycle.
loop do
  RISING.each do |duty|
    led.duty = duty
    sleep 0.01
  end

  FALLING.each do |duty|
    led.duty = duty
    sleep 0.01
  end
end
