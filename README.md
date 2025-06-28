# mruby-denko-esp32-build

Denko is a Ruby/mruby library for working with electronics. This repo contains ESP-IDF projects required to build and flash Xtensa-based ESP32 boards with firmware running mruby and Denko.

## Installation

1.  Install ESP-IDF (version 5.4 or higher):
    - [Linux / Mac Instructions](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/linux-macos-setup.html)
    - [Windows Instructions](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/windows-setup.html)
    - [VS Code Extension](https://github.com/espressif/vscode-esp-idf-extension/blob/master/docs/tutorial/install.md)

    **Note:** If you used `./install.sh all` when setting up the IDF, and are having issues compiling, try install again, but with your specific chip given. Eg. run `./install.sh esp32s3` inside the IDF install directory for the ESP32-S3.

2.  Recursively clone this repo:
    ```
    git clone --recursive https://github.com/denko-rb/mruby-denko.git
    ```

3.  Change directory to the project you want, eg. `esp32-2mb`.

4.  Edit `main/storage/main.rb` as needed. This is the mruby script that runs automatically, once the microcontroller starts up. See [examples](examples).

5.  Buld with: `idf.py build`

6.  Flash and monitor serial output with: `idf.py -p YOUR_SERIAL_DEVICE flash monitor`

7.  Each time you edit `main/storage/main.rb`, you must build and flash again. Subsequent builds are faster thanks to caching.

8.  Run `idf.py clean fullclean build` to rebuild from scratch.

    **Note:** Be sure to **do this when switching between project folders for different chips**. Git submodules are shared between them all (to avoid managing multiple clones), and some build files, which are incompatible between chips, get written there.

## Examples
Here is the "Hello World" equivalent for microcontrollers. More examples [here](examples).
```ruby
# Use submodules without Denko:: prefix.
include Denko

# Blink built-in LED every half second.
led = LED.new(pin: 2)
loop do
  led.on
  sleep 0.5
  led.off
  sleep 0.5
end
````
**Reminder:** mruby code goes in`main/storage/main.rb`.

## Supported Hardware

|    Chip        | Build Status    | Board Tested         | Notes |
| :--------      | :------:        | :---------------     |------ |
| ESP32          | :green_heart:   | DOIT ESP32 DevKit V1 |
| ESP32-S2       | :green_heart:   | LOLIN S2 Pico        | Native USB
| ESP32-S3       | :green_heart:   | LOLIN S3 V1.0.0      | Native USB
| ESP32-C3       | :question:      | LOLIN C3 Mini V2.1.0 | Native USB
| ESP32-C2       | :question:      | -                    |
| ESP32-C6       | :question:      | -                    |
| ESP32-H2       | :question:      | -                    |

## Dependencies

Dependencies are automatically handled by mruby's build system. These links are for refrence.

- [mruby-denko-core](https://github.com/denko-rb/mruby-denko-core)
- [mruby-denko-board-esp32](https://github.com/denko-rb/mruby-denko-board-esp32)
- [mruby-denko-wifi-esp32](https://github.com/denko-rb/mruby-denko-wifi-esp32)
- [mruby-denko-mqtt-esp32](https://github.com/denko-rb/mruby-denko-mqtt-esp32)

## Other Implementations
- The original [CRuby gem](https://github.com/denko-rb/denko) runs on a PC, "remote controlling" a microcontroller connected via serial or TCP
- The [Linux SBC](https://github.com/denko-rb/denko-piboard) extension allows the CRuby gem to work with the Raspberry Pi GPIO header
- The [Milk-V mruby](https://github.com/denko-rb/mruby-denko-milkv-duo) version runs on a tiny Linux SBC, with the same form-factor as a Raspberry Pi Pico
