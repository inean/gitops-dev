#!/usr/bin/env bash

# Set up temp dir
tmpdir=/tmp/uninstall.$$
mkdir -p "$tmpdir" || abort "Unable to create temp dir '$tmpdir'"
trap '
  rm -fr "$tmpdir"
  # Invalidate sudo timestamp before exiting
  /usr/bin/sudo -k
' EXIT

packager_install() {
  abort "Not yet implemented"
  failed=true
} 

packager_uninstall() {
  # Download and run the uninstall script.
  script_url="https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh" 
  opt_dryrun=""

  # Dry run script
  if [[ ! -z $1 ]]; then
    opt_dryrun="--dry-run"
  fi
  curl -sLo $tmpdir/uninstall.sh $script_url || abort "failed to download script from $script_url"
  chmod +x $tmpdir/uninstall.sh
  sudo $tmpdir/uninstall.sh --force $opt_dryrun

  # Clean up Homebrew directories.
  if [[ $opt_dryrun -eq "" ]]; then
    sudo rm -rf $1/Homebrew
    sudo rm -rf $1Caskroom
    sudo rm -rf $1/bin/brew
  fi
}
