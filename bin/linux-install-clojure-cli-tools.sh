#! /bin/bash

FNAME="linux-install-1.11.1.1105.sh"

echo "Version of Linux Clojure CLI tools last checked on"
echo "https://clojure.org/guides/getting_started on 2022-Apr-17"
echo "Version: ${FNAME}"
echo ""

set -x
curl -O https://download.clojure.org/install/${FNAME}
chmod +x ${FNAME}
sudo ./${FNAME}
