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
  dry_run=""
  # Sanity Check. prefix is optional. If present. Ensure hombrew is installed
  if [[ ! -z $1 ]]; then
    if [[ -x $1/brew ]]; then
      abort '$1/brew not found'
    fi
  fi
  # Dry run script
  if [[ ! -z $2 ]]; then
    dry_run="--dry-run"
  fi
  curl -sLo $tmpdir/uninstall.sh $script_url || abort "failed to download script from $script_url"
  chmod +x $tmpdir/uninstall.sh
  sudo $tmpdir/uninstall.sh -p $1 --force $dry_run

  # Clean up Homebrew directories.
  if [[ $dry_run -eq "" ]]; then
    sudo rm -rf $1/Homebrew
    sudo rm -rf $1Caskroom
    sudo rm -rf $1/bin/brew
  fi
}
