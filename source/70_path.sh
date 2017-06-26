MY_OS=`uname -s`
MY_MACHINE=`uname -p`

prepend_to_path_if_exists () {
    local dir=$1
    if [ -d "${dir}" ]
    then
        export PATH="${dir}:$(path_remove ${dir})"
    fi
}

prepend_to_path_if_exists "$HOME/Documents/bin"
prepend_to_path_if_exists "$HOME/bin"
prepend_to_path_if_exists "$HOME/bin/${MY_OS}"
prepend_to_path_if_exists "$HOME/bin/${MY_OS}-${MY_MACHINE}"
prepend_to_path_if_exists "$HOME/bin/atp"
