#! /bin/bash

VDI_FILE="$1"
set -x
VBoxManage modifymedium --compact "${VDI_FILE}"
