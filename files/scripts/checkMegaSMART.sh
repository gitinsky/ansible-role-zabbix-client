#!/bin/bash -u

for driveID in $(setarch x86_64 --uname-2.6 megacli -PDList -aall|grep -iP '^Device\s+Id\s*:\s*\d+\s*$'|awk '{print $3}')
  do
  echo -n "$driveID" 
  smartctl -d megaraid,$driveID -A /dev/sda|
  while read pNum pName p03 p04 p05 p06 p07 p08 p09 pValue p11
    do
    test "$pNum" -gt "0" \
      -a \(  "$pName" = 'Reallocated_Sector_Ct' \
          -o "$pName" = 'End-to-End_Error' \
          -o "$pName" = 'Current_Pending_Sector' \
          -o "$pName" = 'Offline_Uncorrectable' \
          -o "$pName" = 'UDMA_CRC_Error_Count' \
          \) \
       2>/dev/null || continue
    echo -n " $pName:$pValue" 
    done
  echo ''
  shift
  done
