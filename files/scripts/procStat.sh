#!/bin/sh -eu

paramName="$1" 
procName="$2" 
if test "$procName" = 'java'
  then
  procName="java\s.*$3" 
  fi

countProc()
  {
  local procName="$1"
  ps axo pid,pcpu,pmem,command|grep -P "^\s*\d+\s+\d+(\.\d+)?\s+\d+(\.\d+)?\s+[^\s]*$procName(\s.*)?\s*$"|
    {
    local procPcpu=0
    local procPmem=0
    local procFdnum=0
    local myPid=''
    local myPcpu=''
    local myPmem=''
    local theRest=''

    while read myPid myPcpu myPmem theRest
      do
      procPcpu=$(echo "x=$procPcpu + $myPcpu; if(x<1 && x>0) print 0; x" | bc)
      procPmem=$(echo "x=$procPmem + $myPmem; if(x<1 && x>0) print 0; x" | bc)
      procFdnum=$(($procFdnum + $(sudo /etc/zabbix/scripts/procStatFdnum.sh "$myPid")))
      done
    
    echo "$procPcpu $procPmem $procFdnum"
    };
  }

case "$paramName" in
  pcpu)
    countProc "$procName" | cut -d ' ' -f 1
    ;;
  pmem)
    countProc "$procName" | cut -d ' ' -f 2
    ;;
  fdnum)
    countProc "$procName" | cut -d ' ' -f 3
    ;;
  *)
   echo "ZBX_NOTSUPPORTED" 
   ;;
esac
