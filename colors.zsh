if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

export BOLD_VALUE="1m"

export BLACK_VALUE='0;30m'
export RED_VALUE='0;31m'
export DARK_GRAY_VALUE='1;30m'
export LIGHT_RED_VALUE='1;31m'
export GREEN_VALUE='0;32m'
export LIGHT_GREEN_VALUE='1;32m'
export ORANGE_VALUE='0;33m'
export YELLOW_VALUE='1;33m'
export BLUE_VALUE='0;34m'
export LIGHT_BLUE_VALUE='1;34m'
export PURPLE_VALUE='0;35m'
export LIGHT_PURPLE_VALUE='1;35m'
export CYAN_VALUE='0;36m'
export LIGHT_CYAN_VALUE='1;36m'
export LIGHT_GRAY_VALUE='0;37m'
export WHITE_VALUE='1;37m'
export NC_VALUE='0m'

esc=$(printf '\033[')

export BOLD="\033${BOLD_VALUE}"
export BLACK='\033[0;30m'
export RED="${esc}${RED_VALUE}"
export DARK_GRAY='\033[1;30m'
export LIGHT_RED='\033[1;31m'
export GREEN='\033[0;32m'
export LIGHT_GREEN='\033[1;32m'
export ORANGE='\033[0;33m'
export YELLOW='\033[1;33m'
export BLUE='\033[0;34m'
export LIGHT_BLUE='\033[1;34m'
export PURPLE='\033[0;35m'
export LIGHT_PURPLE='\033[1;35m'
export CYAN='\033[0;36m'
export LIGHT_CYAN='\033[1;36m'
export LIGHT_GRAY='\033[0;37m'
export WHITE='\033[1;37m'
export NC='\033[0m'
