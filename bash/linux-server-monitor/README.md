# Linux Server Monitoring Tool

A simple Bash-based Linux server monitoring tool that collects
system information and monitors CPU, memory, and disk utilization.

## Features

- Displays system hostname and operating system.
- Shows system uptime.
- Displays CPU model and available CPU cores.
- Calculates CPU utilization using `/proc/stat`.
- Monitors memory utilization.
- Monitors disk utilization.
- Generates warnings when CPU, memory, or disk usage reaches 80%.

## Requirements

- Linux operating system
- Bash
- `procps` (for system utilities such as `free`)
- `util-linux` (for system utilities such as `lscpu`)
- `gawk` or `mawk` (for `awk` calculations)

## Sample Output

```text
    LINUX SERVER  MONITOR

SYSTEM INFORMATION
Server Name: Ashwanth
Operating System: Ubuntu 26.04.1 LTS
Uptime: up 3 hours, 33 minutes
Model name:                              13th Gen Intel(R) Core(TM) i7-13650HX

CPU INFORMATION
Available CPUs: 20

CPU UTILIZATION
Taking CPU measurement....
CPU Usage: 0.05%
Measurement complete!

MEMORY UTILIZATION
Memory Usage: 6%

DISK UTILIZATION
Disk Usage: 1%

```

## How It Works

- `hostname` retrieves the system hostname.
- `uptime -p` displays system uptime.
- `lsb_release` retrieves operating system information.
- `lscpu` provides CPU details.
- `/proc/stat` provides CPU time counters used to calculate CPU utilization.
- `free` provides memory statistics.
- `df` reports filesystem disk usage.
- `awk` processes command output and performs decimal calculations.
- Bash conditional statements generate warnings when usage reaches the configured threshold.




