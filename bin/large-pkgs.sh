sed -ne '/^Package: \(.*\)/{s//\1/;h;};/^Installed-Size: \(.*\)/{s//\1/;G;s/\n/ /;p;}' /var/lib/dpkg/status | sort -n
