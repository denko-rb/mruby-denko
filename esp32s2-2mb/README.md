# mruby-denko for ESP32-S2

##### Notes

- ESP-IDF version 5.4 or higher is required.
- IDF target is set to `esp32s2`.
- `partitions.csv` maps out only 2MB of flash, so should fit on any variant.
- App partition is 1792 kB.
- `/storage`` partition is 192 kB, and uses littlefs.
- CPU speed is set to 240 MHz.
- `mruby` is version 3.4.0, from a modified fork, so `mruby-io` and `mruby-socket` work on ESP32.
- `main.rb` runs unpinned. S2 only has one core.
- `Kernel#sleep`, which uses an RTOS delay must be called periodically to avoid panic. At least 10ms or so.
- Tested on: LOLIN S2 Pico.
- sdkconfig needs default serial set to `USB-CDC` to get output over USB. This varies from the LOLIN S3 (also native USB), which uses `UART0`. Not sure if this is true for all S2, or specific to this board. You may need to change with `idf.py menuconfig`.

## Changes from default sdkconfig

You should run `idf.py menuconfig` after updating to a new IDF version. This will update `sdkconfig` to match it. For reference, these are the main changes (made in menuconfig) that are relevant to this project:

```console
Component Config -> ESP System Settings -> CPU frequency: 240 MHz
Component Config -> ESP System Settings -> Event loop task stack size: 16384
Partition Table -> Partition Table -> Custom Partition table CSV : Enabled
Partition Table -> Custom partition CSV file: partitions.csv

# Specific to esp32s2
Component Config -> ESP System Settings -> Channel for console output : USB CDC
```
