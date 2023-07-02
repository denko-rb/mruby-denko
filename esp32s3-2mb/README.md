# mruby-denko for ESP32-S3

#### Notes
- ESP-IDF v5.1 is recommended for building.
- IDF target is set to `esp32s3`.
- `partitions.csv` maps out only 2MB of flash, so should fit on any variant.
- SPIFFS partitions is 448kB.
- CPU speed is set to 240 MHz.
- `mruby` submodule is set to the 3.2.0 release.
- `main.rb` runs pinned to Core 1, with Core 0 left free for the OS.
- Watchdog timer is disabled for Core 1 only.
- Tested on: LOLIN S3 V1.0.0.
