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
- Tested on: LOLIN S2 Pico.
- sdkconfig needs default serial set to `USB-CDC` to get output over USB. This varies from the LOLIN S3 (also native USB), which uses `UART0`. Not sure if this is true for all S2, or specific to this board. You may need to change with `idf.py menuconfig`.
