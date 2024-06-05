prepend_to_path_if_exists () {
    local dir=$1
    if [ -d "${dir}" ]
    then
        export PATH="${dir}:$(path_remove ${dir})"
    fi
}

prepend_to_manpath_if_exists () {
    local dir=$1
    if [ -d "${dir}" ]
    then
        export MANPATH="${dir}:$(manpath_remove ${dir})"
    fi
}

# Set the title of a GNOME Terminal window
title() {
    echo -e "\033]0;$@\007"
}
