RED_PIN = 4
GREEN_PIN = 5
BLUE_PIN = 6
board = Denko::Board.new

# Connect anodes of common-cathode RGB LED to 3 pins.
rgb_led = Denko::LED::RGB.new(board: board, pins: {red: RED_PIN, green: GREEN_PIN, blue: BLUE_PIN})

# Cycle through the colors.
[:blue, :green, :red].cycle do |color|
  rgb_led.color = color
  sleep 1
end
