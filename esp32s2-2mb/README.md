# mruby-denko for ESP32-S2

#### Notes

- ESP-IDF version 5.1 or higher is required.
- IDF target is set to `esp32s2`.
- `partitions.csv` maps out only 2MB of flash, so should fit on any variant.
- App partition is 1792 kB.
- `/storage`` partition is 192 kB, and uses littlefs.
- CPU speed is set to 240 MHz.
- `mruby` is version 3.2.0, from a modified fork, so `mruby-io` and `mruby-socket` work on ESP32.
- `main.rb` runs unpinned. S2 only has one core.
- `Kernel#sleep`, which uses an RTOS delay must be called periodically to avoid panic. At least 10ms or so.
- Tested on: LOLIN S2 Pico.
- sdkconfig needs default serial set to `USB-CDC` to get output over USB. This varies from the LOLIN S3 (also native USB), which uses `UART0`. Not sure if this is true for all S2, or specific to this board. You may need to change with `idf.py menuconfig`.
