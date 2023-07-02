# Use submodules without Denko:: prefix.
include Denko

rgb_led = LED::RGB.new(pins: {red: 4, green: 5, blue: 2})

# Cycle through the colors.
[:blue, :green, :red].cycle do |color|
  rgb_led.color = color
  sleep 1
end
