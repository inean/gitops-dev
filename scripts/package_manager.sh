#!/usr/bin/env bash

# Utility method
abort() {
  printf "%s\n" "$@"
  exit 1
}

# Help
usage() {
  cat <<EOS
Packager Manager
Usage: $0 [options]
    -d, --dry-run    Don't make persistent changes.
    -i, --install    Uninstall without prompting.
    -u, --uninstall  Suppress all output.
    -h, --help       Display this message.
EOS
  exit "${1:-0}"
}

# global status to indicate whether there is anything wrong.
failed=false

# Default vars
opt_prefix=""
opt_action=""
opt_dryrun=""
   
# detect os.
un=$(uname)
case "$un" in
  Darwin)
    ostype=macos
    opt_prefix=/usr/local
    if [[ "$(uname -m)" == "arm64" ]]; then
      opt_prefix=/opt/homebrew
    fi
  ;;
  *)
    abort "Unsupported system type '$un'"
  ;;
esac

# Parse command line
while [[ $# -gt 0 ]]; do
  case "$1" in
    -d|--dry-run) opt_dryrun=1;;
    -u|--uninstall) opt_action="uninstall";;
    -i|--install) opt_action="install";;
    -h|--help) usage;;
    *) warn "Unrecognized option: '$1'"; usage 1;;
  esac
  shift
done

# source install/uninstall methods for this os.
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
if [[ ! -f $SCRIPT_DIR/$ostype.sh ]]; then
    abort "Can't inject packager ops methods for $ostype" 
fi
source $SCRIPT_DIR/$ostype.sh
# run action
packager_${opt_action} $opt_prefix $opt_dryrun

[[ $failed != true ]]