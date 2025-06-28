# mruby-denko for ESP32-S3

#### Notes

- ESP-IDF version 5.4 or higher is required.
- IDF target is set to `esp32s3`.
- `partitions.csv` maps out only 2MB of flash, so should fit on any variant.
- App partition is 1792 kB.
- `/storage`` partition is 192 kB, and uses littlefs.
- CPU speed is set to 240 MHz.
- `mruby` is version 3.4.0, from a modified fork, so `mruby-io` and `mruby-socket` work on ESP32.
- mruby `main.rb` runs pinned to Core 1.
- Watchdog timer is disabled for Core 1 only.
- Tested on: LOLIN S3 V1.0.0.

## Changes from default sdkconfig

You should run `idf.py menuconfig` after updating to a new IDF version. This will update `sdkconfig` to match it. For reference, these are the main changes (made in menuconfig) that are relevant to this project:

```console
Component Config -> ESP System Settings -> CPU frequency: 240 MHz
Component Config -> ESP System Settings -> Event loop task stack size: 16384
Partition Table -> Partition Table -> Custom Partition table CSV : Enabled
Partition Table -> Custom partition CSV file: partitions.csv

# Specific to esp32s3
Component Config -> ESP System Settings -> Watch CPU1 Idle Task : Disabled
```
