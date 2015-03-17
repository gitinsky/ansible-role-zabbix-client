#!/bin/bash -u

while test "$#" -gt 0
  do
  driveID="$1" 
  echo -n "$driveID" 
  smartctl -A "$driveID"|
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
