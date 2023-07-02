# mruby-denko for ESP32-S2

#### Notes
- ESP-IDF v5.1 is recommended for building.
- IDF target is set to `esp32s2`.
- `partitions.csv` maps out only 2MB of flash, so should fit on any variant.
- SPIFFS partitions is 448kB.
- CPU speed is set to 240 MHz.
- `mruby` submodule is set to the 3.2.0 release.
- `main.rb` runs unpinned. S2 only has one core.
- `Kernel#sleep`, which uses an RTOS delay must be called periodically to avoid panic. At least 10ms or so.
- Not tested in hardware yet. To be tested on: LOLIN S2 Pico.

