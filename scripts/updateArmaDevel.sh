#/bin/bash

steamcmd="/home/arma/steamcmd/steamcmd.sh"

unbuffer "${steamcmd}" "+runscript ../scripts/updateArmaDevelWindows" | grep -v login
