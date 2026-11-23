#!/bin/bash

#System Information
HOST=$(hostname)
UPTIME=$(uptime -p)
OS=$(lsb_release -ds)
CPU_COUNT=$(nproc)

#Memory Information
read TOTAL_MEM USED_MEM <<< "$(free -m | awk '/Mem:/ {print $2, $3}')"
MEM_PERCENT=$((USED_MEM * 100 / TOTAL_MEM))

#Disk Information
read DISK_USAGE <<< "$(df -h / | awk 'NR==2 {print $5}')"

echo "    LINUX SERVER  MONITOR    "
echo ""

#Display System Information
echo "SYSTEM INFORMATION"
echo "Server Name: $HOST"
echo "Operating System: $OS"
echo "Uptime: $UPTIME"

lscpu | grep "Model name"

echo ""

echo "CPU INFORMATION"
echo "Available CPUs: $CPU_COUNT"

echo ""
#CPU Utilisation

echo "CPU UTILIZATION"
echo "Taking CPU measurement...."
CPU1=$(grep '^cpu ' /proc/stat)
read -r _ USER1 NICE1 SYSTEM1 IDLE1 IOWAIT1 IRQ1 SOFTIRQ1 STEAL1 GUEST1 GUEST_NICE1 <<< "$CPU1"
TOTAL1=$((USER1 + NICE1 + SYSTEM1 + IDLE1 + IOWAIT1 + IRQ1 + SOFTIRQ1 + STEAL1))

sleep 1

CPU2=$(grep '^cpu ' /proc/stat)
read -r _ USER2 NICE2 SYSTEM2 IDLE2 IOWAIT2 IRQ2 SOFTIRQ2 STEAL2 GUEST2 GUEST_NICE2 <<< "$CPU2"
TOTAL2=$((USER2 + NICE2 + SYSTEM2 + IDLE2 + IOWAIT2 + IRQ2 + SOFTIRQ2 + STEAL2))

TOTAL_DIFF=$((TOTAL2 - TOTAL1))
IDLE_DIFF=$((IDLE2 - IDLE1))

if (( TOTAL_DIFF > 0 )); then
	CPU_USAGE=$(awk "BEGIN {printf \"%.2f\", (($TOTAL_DIFF - $IDLE_DIFF) / $TOTAL_DIFF) * 100}")
else 	
	CPU_USAGE=0
fi

echo "CPU Usage: $CPU_USAGE%"

if (( $(awk "BEGIN {print ($CPU_USAGE >= 80)}") )); then
	echo "WARNING: High CPU usage!"
fi
echo "Measurement complete!"

echo ""

#Memory Utilisation
echo "MEMORY UTILIZATION"
if (( MEM_PERCENT >= 80 )); then
	echo "WARNING: High memory usage!"
fi
echo "Memory Usage: $MEM_PERCENT%"

echo ""

#Disk Utilisation
echo "DISK UTILIZATION"
if (( ${DISK_USAGE%\%} >= 80 )); then
	echo "WARNING: High disk usage!"
fi
echo "Disk Usage: $DISK_USAGE"



