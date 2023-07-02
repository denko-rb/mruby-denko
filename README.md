# mruby-denko

Denko is a Ruby library for microcontrollers and connected peripherals. This implementation runs on [mruby](https://github.com/mruby/mruby), self-contained on a microcontroller. It's an early work-in progress, but many basic features are usable. Right now it only runs on the ESP32 series of microcontrollers. See [other implementations](#other-implementations) if you need more.

This repo contains ESP-IDF projects required to build and flash different ESP32 boards with mruby and Denko.

## Installation

1.  Install ESP-IDF (version 5.1 or higher):
    - [Linux / Mac Instructions](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/linux-macos-setup.html)
    - [Windows Instructions](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/windows-setup.html)
    - [VS Code Extension](https://github.com/espressif/vscode-esp-idf-extension/blob/master/docs/tutorial/install.md)


2.  Recursively clone this repo:
    ```
    git clone --recursive https://github.com/denko-rb/mruby-denko.git
    ```
  
3.  Change directory to the project you want.

4.  Edit `main/spiffs/main.rb` as needed. See [examples](examples).

5.  Buld with: `idf.py build`

6.  Flash and monitor serial output with: `idf.py -p YOUR_SERIAL_DEVICE flash monitor`

    If there are problems, first try `idf.py fullclean`. If that doesn't work, delete the file and folder shown below, then try `idf.py fullclean` and `idf.py build` again.
    ```
    components/mruby_component/esp32_build_config.rb.lock
    components/mruby_component/mruby/build
    ```
    **Note:** All paths are relative to the chosen project's root.
    
7.  Each time you edit `main/spiffs/main.rb`, you must build and flash again. It's faster after the first build.

## Examples
Below is the "Hello World" of microcontrollers. More examples [here](examples).
```ruby
# Blink built-in LED every half second.
led = LED.new(pin: 2)
loop do
  led.on
  sleep 0.5
  led.off
  sleep 0.5
end
````
**Reminder:** mruby code goes in`main/spiffs/main.rb`.

## Dependencies

Dependencies are automatically handled by mruby's build system. These links are for refrence.

Direct dependencies:

- [mruby-denko-board-esp32](https://github.com/denko-rb/mruby-denko-board-esp32)
- [mruby-denko-core](https://github.com/denko-rb/mruby-denko-core)

Forks or inline modified versions of:

- [mruby-io](https://github.com/mruby-esp32/mruby-io)
- [mruby-esp32-system](https://github.com/mruby-esp32/mruby-esp32-system)
- [mruby-esp32-gpio](https://github.com/mruby-esp32/mruby-esp32-gpio)
- [mruby-esp32-ledc](https://github.com/mruby-esp32/mruby-esp32-ledc)


Plus many standard mrgbgems included with mruby.

## Other Implementations
- The original [CRuby gem](https://github.com/denko-rb/denko) runs on any computer and uses a connected (Serial or TCP) microcontroller.
- The [Raspberry Pi](https://github.com/denko-rb/denko-piboard) extension allows the CRuby gem to work with the Raspberry Pi GPIO header.
