#/bin/bash

steamcmd="/home/arma/steamcmd/steamcmd.sh"

"${steamcmd}" "+runscript ../scripts/updateArmaDevelWindows" | grep --line-buffered -v login
