#!/bin/bash -u

setarch x86_64 --uname-2.6  megacli -LDInfo -Lall -Aall|grep -iPc '^State\s*\:(?!\s*Optimal\s*$)'
