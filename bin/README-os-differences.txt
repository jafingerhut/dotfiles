Some differences between Mac OS X, Ubuntu Linux, and Red Hat Linux
systems that I often use, including:

uname output strings
For a Mac, system_profiler output strings
For Ubuntu and Red Hat, lsb_release output strings
Path name for 'env' binary
Versions of Python2 and Python3 installed, if any, and in which directories
Version of emacs installed, and where
Value of OSTYPE variable (_not_ environment variable) in bash

----------------------------------------------------------------------
Mac OS X 10.6.5 "Snow Leopard"
    /usr/bin/uname
    Example "uname -a" output:
    Darwin andys-mbp.local 10.8.0 Darwin Kernel Version 10.8.0: Tue Jun  7 16:33:36 PDT 2011; root:xnu-1504.15.3~1/RELEASE_I386 i386
    Output of "uname -s": "Darwin"
    Output of "uname -o": illegal option -- o
    Output of "uname -v": "Darwin Kernel Version 10.8.0: Tue Jun  7 16:33:36 PDT 2011; root:xnu-1504.15.3~1/RELEASE_I386"

    Output of "system_profiler SPSoftwareDataType | grep 'System Version'": System Version: Mac OS X 10.6.8 (10K549)

    No program lsb_release installed

    /usr/bin/env

    (Everything in /opt/local comes from optional MacPorts packages
    that I installed)
    /opt/local/bin/python 2.7.9
    /usr/bin/python 2.6.1
    /opt/local/bin/python3 3.3.2

    Output of "/usr/bin/emacs --version": 22.1.1
    Output of "emacs --version" after installing MacPorts emacs package: 24.4.1

    Value of OSTYPE in bash: TBD (probably darwin10)

----------------------------------------------------------------------
Mac OS X 10.11.6 "El Capitan"
    /usr/bin/uname
    Example "uname -a" output:
    Darwin JAFINGER-M-W0SR 15.6.0 Darwin Kernel Version 15.6.0: Tue Apr 11 16:00:51 PDT 2017; root:xnu-3248.60.11.5.3~1/RELEASE_X86_64 x86_64

    Output of "system_profiler SPSoftwareDataType | grep 'System Version'": System Version: OS X 10.11.6 (15G1510)

    No program lsb_release installed

    /usr/bin/env

    (Everything in /opt/local comes from optional MacPorts packages
    that I installed)
    /opt/local/bin/python3 /opt/local/bin/python 3.4.6
    /opt/local/bin/python2 2.7.13
    /usr/bin/python 2.7.10

    Output of "/usr/bin/emacs --version": 22.1.1
    Output of "emacs --version" after installing MacPorts emacs package: 25.1.1

    Value of OSTYPE in bash: darwin15

----------------------------------------------------------------------
Mac OS X 10.12.5 "Sierra"
    /usr/bin/uname
    Example "uname -a" output:
    Darwin Our-Mac-mini.local 16.6.0 Darwin Kernel Version 16.6.0: Fri Apr 14 16:21:16 PDT 2017; root:xnu-3789.60.24~6/RELEASE_X86_64 x86_64
    Output of "uname -s": "Darwin"
    Output of "uname -o": illegal option -- o
    Output of "uname -v": "Darwin Kernel Version 16.6.0: Fri Apr 14 16:21:16 PDT 2017; root:xnu-3789.60.24~6/RELEASE_X86_64"

    Output of "system_profiler SPSoftwareDataType | grep 'System Version'": System Version: macOS 10.12.5 (16F73)

    No program lsb_release installed

    /usr/bin/env

    (No MacPorts installed on this Mac)
    /usr/bin/python 2.7.10

    Output of "/usr/bin/emacs --version": 22.1.1 (from 2007, still!)
    Output of "emacs --version" after installing MacPorts emacs package: 25.1.1

    Value of OSTYPE in bash: darwin16

----------------------------------------------------------------------
Ubuntu 14.04.2 Linux
    /bin/uname
    Example "uname -a" output:
    Linux p4dev 4.8.0-46-generic #49~16.04.1-Ubuntu SMP Fri Mar 31 14:51:03 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
    Output of "uname -s": "Linux"
    Output of "uname -o": "GNU/Linux"
    Output of "uname -v": "#49~16.04.1-Ubuntu SMP Fri Mar 31 14:51:03 UTC 2017"

    No program system_profiler installed

    /usr/bin/lsb_release
    Output of "lsb_release -i": Distributor ID: Ubuntu
    Output of "lsb_release -d": Description:    Ubuntu 14.04.5 LTS
    Output of "lsb_release -r": Release:        14.04

    /usr/bin/env

    I would guess that not all of these versions of Python are
    installed by default.  I probably installed some of those packages
    as a result of the install steps for some p4lang repositories.
    /usr/bin/python2 /usr/bin/python 2.7.6
    /usr/bin/python3 3.4.3

    Output of "emacs --version" after installing 'emacs24' package: 24.3

    emacs-24.3 seems to be latest version easily installable via
    Ubuntu 14.04.02 packages.  emacs-24.4 might be oldest version
    easily supported by clojure-mode, without changes to clojure-mode.

    I found these instructions for installing a precompiled version of
    Emacs 25 on Ubuntu 14.04 and Ubuntu 16.04:
    http://ubuntuhandbook.org/index.php/2017/04/install-emacs-25-ppa-ubuntu-16-04-14-04/
        sudo add-apt-repository ppa:kelleyk/emacs
        sudo apt update
        sudo apt install emacs25
        (Binary installed as /usr/bin/emacs-25.2)

    Value of OSTYPE in bash: linux-gnu

----------------------------------------------------------------------
Ubuntu 16.04.2 Linux
    /bin/uname
    Example "uname -a" output:
    Linux p4dev 4.8.0-46-generic #49~16.04.1-Ubuntu SMP Fri Mar 31 14:51:03 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
    Output of "uname -s": "Linux"
    Output of "uname -o": "GNU/Linux"
    Output of "uname -v": "#49~16.04.1-Ubuntu SMP Fri Mar 31 14:51:03 UTC 2017"

    No program system_profiler installed

    /usr/bin/lsb_release
    Output of "lsb_release -i": Distributor ID: Ubuntu
    Output of "lsb_release -d": Description:    Ubuntu 16.04.2 LTS
    Output of "lsb_release -r": Release:        16.04

    /usr/bin/env

    /usr/bin/python2 /usr/bin/python 2.7.12
    /usr/bin/python3 3.5.2

    Output of "emacs --version" after installing 'emacs24' package: 24.5.1

    Value of OSTYPE in bash: linux-gnu

----------------------------------------------------------------------
Ubuntu 17.04 Linux
    /bin/uname
    Example "uname -a" output:
    Linux p4dev 4.10.0-24-generic #28-Ubuntu SMP Wed Jun 14 08:14:34 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
    Output of "uname -s": "Linux"
    Output of "uname -o": "GNU/Linux"
    Output of "uname -v": "#28-Ubuntu SMP Wed Jun 14 08:14:34 UTC 2017"

    No program system_profiler installed

    /usr/bin/lsb_release
    Output of "lsb_release -i": Distributor ID: Ubuntu
    Output of "lsb_release -d": Description:    Ubuntu 17.04
    Output of "lsb_release -r": Release:        TBD: 17.04 ?

    /usr/bin/env

    /usr/bin/python2 /usr/bin/python 2.7.13
    /usr/bin/python3 3.5.3

    Output of "emacs --version" after installing 'emacs24' package: 24.5.1
    emacs25 is available as standard package choice from Ubuntu, and
    should be what is installed if you install the 'emacs' virtual
    package.

    Value of OSTYPE in bash: linux-gnu

----------------------------------------------------------------------
Red Hat Enterprise Linux Server release 6.2 (Cisco Enterprise Linux)
    /bin/uname
    Example "uname -a" output:
    Linux sjc-ads-7081 2.6.32-642.6.2.el6.x86_64 #1 SMP Mon Oct 24 10:22:33 EDT 2016 x86_64 x86_64 x86_64 GNU/Linux
    Output of "uname -s": "Linux"
    Output of "uname -o": "GNU/Linux"
    Output of "uname -v": "#1 SMP Mon Oct 24 10:22:33 EDT 2016"

    No program system_profiler installed

    /usr/bin/lsb_release
    Output of "lsb_release -i": Distributor ID: RedHatEnterpriseServer
    Output of "lsb_release -d": Description:    Red Hat Enterprise Linux Server release 6.2 (Santiago)
    
    /bin/env /usr/bin/env (second links to first)

    /usr/bin/python /usr/bin/python2 2.6.6
    /usr/cisco/bin/python /usr/cisco/bin/python2 2.7.10
    No python3 executable in either /usr/bin nor /usr/cisco/bin
    (If I source /ws/jafinger-sjc/nxos/myown.sh)
    /ws/jafinger-sjc/pyats-2.2.0-2016-06-01-via-thaw/bin/python 3.4.1

    (The ones below are not normally in my command path)
    /router/bin/python 2.7.6
    /router/bin/python3 3.4.0

    Value of OSTYPE in bash: linux-gnu

----------------------------------------------------------------------
Windows 10 plus Cygwin Net Release version 2.879 (64 bit)
    /usr/bin/uname
    Example "uname -a" output:
    CYGWIN_NT-10.0 JAFINGER-CA481 2.8.0(0.309/5/3) 2017-04-01 20:47 x86_64 Cygwin
    Output of "uname -s": "CYGWIN_NT-10.0"
    Output of "uname -o": "Cygwin"
    Output of "uname -v": "2017-04-01 20:47"

    No program system_profiler installed
    No program lsb_release installed

    /usr/bin/env

    /usr/bin/python 2.7.13
    /usr/bin/python2 2.7.13

    No program emacs installed

    Value of OSTYPE in bash: cygwin
