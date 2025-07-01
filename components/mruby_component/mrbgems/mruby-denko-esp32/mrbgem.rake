# This sets Denko::Board::VERSION for the ESP32, independent of Denko::VERSION.
# Use it for this mrbgem's overall version.
require_relative "mrblib/denko/board/version"

# denko.rb from the CRuby gem requires most of it tree. Each module's .rb file defines
# an Array constant, with all files for that module, autoloaded by CRuby. With those
# Arrays defined here, all the same files can be added to the mruby build too.
require_relative "lib/denko/lib/denko"

MRuby::Gem::Specification.new('mruby-denko-esp32') do |spec|
  spec.license = 'MIT'
  spec.authors = 'vickash'
  spec.version = Denko::Board::VERSION

  # BCD conversion dependency for RTCs
  spec.add_dependency('ruby_bcd', github: "dafyddcrosby/ruby_bcd", branch: "main")

  # ESP32 system gem always included. Wi-Fi and MQTT are handled in build config.
  spec.add_dependency('mruby-esp32-system', github: "mruby-esp32/mruby-esp32-system")

  # Important to redefine spec.rbfiles so load order is explicit.
  spec.rbfiles = []

  # Define #sleep and other platform specific top level methods.
  spec.rbfiles << "#{dir}/mrblib/kernel.rb"

  # lib dir for Denko CRuby gem
  denko_lib_dir = "#{dir}/lib/denko/lib/denko"

  # Helpers & Behaviors needed early (from CRuby gem).
  spec.rbfiles << "#{denko_lib_dir}/version.rb"
  HELPER_FILES.each    { |f| spec.rbfiles << "#{denko_lib_dir}/helpers/#{f[1]}.rb" }
  BEHAVIORS_FILES.each { |f| spec.rbfiles << "#{denko_lib_dir}/behaviors/#{f[1]}.rb" }

  # Denko::Board implementation (from this mrbgem)
  spec.rbfiles += Dir.glob("#{dir}/mrblib/denko/board/*")

  #
  # Common peripheral implementation (from CRuby gem)
  #
  # Define parts of DigitalIO early. Some interfaces are bit-bang and depend on them.
  DIGITAL_IO_EARLY_FILES.each { |f| spec.rbfiles << "#{denko_lib_dir}/digital_io/#{f[1]}.rb" }

  # Interfaces
  I2C_FILES.each      { |f| spec.rbfiles << "#{denko_lib_dir}/i2c/#{f[1]}.rb" }
  SPI_FILES.each      { |f| spec.rbfiles << "#{denko_lib_dir}/spi/#{f[1]}.rb" }
  # ONE_WIRE_FILES.each { |f| spec.rbfiles << "#{denko_lib_dir}/one_wire/#{f[1]}.rb" }
  # UART_FILES.each     { |f| spec.rbfiles << "#{denko_lib_dir}/uart/#{f[1]}.rb" }

  # Basic peripherals first, since others may depend on them.
  ANALOG_IO_FILES.each  { |f| spec.rbfiles << "#{denko_lib_dir}/analog_io/#{f[1]}.rb" }
  DIGITAL_IO_FILES.each { |f| spec.rbfiles << "#{denko_lib_dir}/digital_io/#{f[1]}.rb" }
  PULSE_IO_FILES.each   { |f| spec.rbfiles << "#{denko_lib_dir}/pulse_io/#{f[1]}.rb" }

  # Include the two basic LED classes, not everything in LED_FILES
  spec.rbfiles << "#{denko_lib_dir}/led/base.rb"
  spec.rbfiles << "#{denko_lib_dir}/led/rgb.rb"

  # Just AHT sensor for testing I2C.
  spec.rbfiles << "#{denko_lib_dir}/sensor/helper.rb"
  spec.rbfiles << "#{denko_lib_dir}/sensor/aht.rb"

  # LED_FILES.each        { |f| spec.rbfiles << "#{denko_lib_dir}/led/#{f[1]}.rb" }
  # FONT_FILES.each       { |f| spec.rbfiles << "#{denko_lib_dir}/display/font/#{f[1]}.rb" }
  # DISPLAY_FILES.each    { |f| spec.rbfiles << "#{denko_lib_dir}/display/#{f[1]}.rb" }
  # EEPROM_FILES.each     { |f| spec.rbfiles << "#{denko_lib_dir}/eeprom/#{f[1]}.rb" }
  # MOTOR_FILES.each      { |f| spec.rbfiles << "#{denko_lib_dir}/motor/#{f[1]}.rb" }
  # RTC_FILES.each        { |f| spec.rbfiles << "#{denko_lib_dir}/rtc/#{f[1]}.rb" }
  # SENSOR_FILES.each     { |f| spec.rbfiles << "#{denko_lib_dir}/sensor/#{f[1]}.rb" }
end
