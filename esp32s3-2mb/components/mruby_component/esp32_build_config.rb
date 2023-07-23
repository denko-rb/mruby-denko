MRuby::Build.new do |conf|
  toolchain :gcc

  [conf.cc, conf.objc, conf.asm].each do |cc|
    cc.command = 'gcc'
    cc.flags = [%w(-g -std=gnu99 -O3 -Wall -Werror-implicit-function-declaration -Wdeclaration-after-statement -Wwrite-strings)]
  end

  [conf.cxx].each do |cxx|
    cxx.command = 'g++'
    cxx.flags = [%w(-g -O3 -Wall -Werror-implicit-function-declaration)]
  end

  conf.linker do |linker|
    linker.command = 'gcc'
    linker.flags = [%w()]
    linker.libraries = %w(m)
    linker.library_paths = []
  end

  conf.archiver do |archiver|
    archiver.command = "ar"
  end

  conf.gembox 'default'
end

MRuby::CrossBuild.new('esp32') do |conf|
  toolchain :gcc

  conf.cc do |cc|
    cc.include_paths << ENV["COMPONENT_INCLUDES"].split(';')

    cc.flags << '-Wno-maybe-uninitialized'
    cc.flags << '-mlongcalls'
    cc.flags << '-std=gnu17'
    cc.flags = cc.flags.flatten.collect { |x| x.gsub('-MP', '') }

    cc.defines << %w(MRB_HEAP_PAGE_SIZE=64)
    cc.defines << %w(MRB_USE_IV_SEGLIST)
    cc.defines << %w(KHASH_DEFAULT_SIZE=8)
    cc.defines << %w(MRB_STR_BUF_MIN_SIZE=20)
    cc.defines << %w(MRB_GC_STRESS)
    cc.defines << %w(MRB_USE_METHOD_T_STRUCT)
    cc.defines << %w(MRB_NO_BOXING)

    cc.defines << %w(ESP_PLATFORM)
  end

  conf.cxx do |cxx|
    cxx.include_paths = conf.cc.include_paths.dup

    cxx.flags = cxx.flags.flatten.collect { |x| x.gsub('-MP', '') }

    cxx.defines = conf.cc.defines.dup
  end

  conf.bins = []
  conf.build_mrbtest_lib_only
  conf.disable_cxx_exception
  
  # ESP32 hardware abstraction + core Denko functionality.
  conf.gem :github => "denko-rb/mruby-denko-board-esp32"
  conf.gem :github => "denko-rb/mruby-denko-core"

  # Additional component drivers.
  conf.gem :github => "denko-rb/mruby-denko-hd44780"

  # Platform-specific ESP32 WiFi and MQTT implementations.
  conf.gem :github => "denko-rb/mruby-denko-wifi-esp32"
  conf.gem :github => "denko-rb/mruby-denko-mqtt-esp32"
  
  # TCPSocket gem in mruby fork is modified to work on ESP32.
  # conf.gem :core => "mruby-socket"
end
