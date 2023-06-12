#! /bin/bash

VDI_FILE="$1"
set -x
du -sh .
VBoxManage modifymedium --compact "${VDI_FILE}"
du -sh .
