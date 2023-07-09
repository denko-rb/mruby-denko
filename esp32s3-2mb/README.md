# mruby-denko for ESP32-S3

#### Notes

- ESP-IDF version 5.1 or higher is required.
- IDF target is set to `esp32s3`.
- `partitions.csv` maps out only 2MB of flash, so should fit on any variant.
- App partition is 1792 kB.
- `/storage`` partition is 192 kB, and uses littlefs.
- CPU speed is set to 240 MHz.
- `mruby` is version 3.2.0, from a modified fork, so `mruby-io` and `mruby-socket` work on ESP32.
- RTOS task affinity set to Core 0.
- mruby `main.rb` runs pinned to Core 1.
- Watchdog timer is disabled for Core 1 only.
- Tested on: LOLIN S3 V1.0.0.
