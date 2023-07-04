# Use submodules without Denko:: prefix.
include Denko

# Connect a jumper between an ADC pin and a DAC pin.
# Only original ESP32 and ESP32-S2 have DACs!
dac = AnalogIO::Output.new(pin: 25)
adc = AnalogIO::Input.new(pin: 32)

# DAC resolution is 8 bits by default. ADC resolution is 12 bits default.
# DAC output at 128 should read back at ~2048, but may be off by a few hundred.
# Try writing different values to test.
dac.write 128

# Read the ADC every second.
loop do
  puts "DAC output is: #{dac.state}. ADC reading is: #{adc.read}"
  sleep 1
end
