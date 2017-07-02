#/bin/bash

steamcmd="/home/arma/steamcmd/steamcmd.sh"

unbuffer -p "${steamcmd}" "+runscript ../scripts/updateArmaDevelWindows" | grep -v login
