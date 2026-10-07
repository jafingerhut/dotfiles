# OS detection
function is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_ubuntu() {
  if [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]]; then
    echo "is_ubuntu found /etc/issue containing Ubuntu"
    return 1
  else
    source /etc/os-release
    if [[ "${ID_LIKE}" == *"ubuntu"* ]]; then
      echo "is_ubuntu found /etc/os-release ID_LIKE containing ubuntu"
      return 1
    fi
  fi
  echo "is_ubuntu returning false"
  return 0
}
function get_os() {
  for os in osx ubuntu; do
    is_$os; [[ $? == ${1:-0} ]] && echo $os
  done
}
