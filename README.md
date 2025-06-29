# mruby-denko-esp32-build

Denko is a Ruby/mruby library for working with electronics. This repo contains the ESP-IDF project for building and flashing Xtensa-based ESP32 chips with firmware that runs mruby and Denko.

## Installation

1.  Install ESP-IDF (version 5.4.2 or higher):
    - [Linux / Mac Instructions](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/linux-macos-setup.html)
    - [Windows Instructions](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/windows-setup.html)
    - [VS Code Extension](https://github.com/espressif/vscode-esp-idf-extension/blob/master/docs/tutorial/install.md)

    **Note:** If you used `./install.sh all` when setting up the IDF, and are having issues compiling, try install again, but with your specific chip given. Eg. run `./install.sh esp32s3` inside the IDF install directory for the ESP32-S3.

2.  Recursively clone this repo:
    ```
    git clone --recursive https://github.com/denko-rb/mruby-denko.git
    ```

3.  Set the target to your chip with `idf.py set-target <YOUR_CHIP>`, where `<YOUR_CHIP>` is one of: `esp32`, `esp32s2` or `esp32s3`.

4.  Edit `main/storage/main.rb` as needed. This is the mruby script that runs automatically, once the microcontroller starts up.

5.  Buld with: `idf.py build`

6.  Flash and monitor serial output with: `idf.py flash monitor`. Add `-p <YOUR_SERIAL_DEVICE>` if you need to specify.

7.  Each time you edit `main/storage/main.rb`, you must build and flash again. Subsequent builds are faster thanks to caching.

8.  Run `idf.py clean fullclean` in the event you want to remove all build files and build from scratch again.

## Examples
Here is the "Hello World" equivalent for microcontrollers. More examples [here](examples).
```ruby
board = Denko::Board.new

# Blink built-in LED every half second.
led = LED.new(board: board, pin: 2)
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

## Build Environment
- ESP-IDF version 5.4.2
- mruby version 3.4.0, from [this fork](https://github.com/denko-rb/mruby), where `mruby-io` and `mruby-socket` have been modified
- `partitions.csv` definees 4MB of flash, so it should fit any variant
  - Uses [esp_littlefs](https://github.com/joltwallet/esp_littlefs) version 1.20.0
  - App partition is 2816 kB
  - `/storage` is 1216 kB
- CPU speed set to 240 MHz for all Xtensa chips

### Chip-Specific Notes

- For `esp32` and `esp32s3`, the mruby task (`main.rb`) is pinned to Core 1, with its watchdog timer disabled. This means mruby code can stay in a tight loop indefinitely, without starving the RTOS of resources, as other tasks can run on Core 0.
- This is not the case for the `esp32s2`, which only has a single core. `Kernel#sleep` must be called periodically to avoid crashing.
- For the S2, `Component Config -> ESP System Settings -> Channel for console output` must be set to `USB CDC` in menuconfig for console output to appear on its native USB port. This is unlike the S3, which is also native USB, but works with the default `UART0` setting.

## Dependencies

Dependencies are automatically handled by mruby's build system. These links are for refrence:

- [mruby-esp32-system](https://github.com/mruby-esp32/mruby-esp32-system)
- [mruby-denko-wifi-esp32](https://github.com/denko-rb/mruby-denko-wifi-esp32)
- [mruby-denko-mqtt-esp32](https://github.com/denko-rb/mruby-denko-mqtt-esp32)
- [picoruby](https://github.com/picoruby/picoruby)
- [mruby-denko-esp32](https://github.com/denko-rb/mruby-denko-esp32)
- [denko](https://github.com/denko-rb/denko)

## Other Implementations
- The original [CRuby gem](https://github.com/denko-rb/denko) runs on a PC, "remote controlling" a microcontroller connected via serial or TCP
- The [Linux SBC](https://github.com/denko-rb/denko-piboard) extension allows the CRuby gem to use SBC GPIO headers
- The [Milk-V mruby](https://github.com/denko-rb/mruby-denko-milkv-duo) version runs on a tiny Linux SBC, with the same form-factor as a Raspberry Pi Pico
