#!/usr/bin/env bash
# taken from https://github.com/jogendra/dotfiles/blob/master/installers/install.sh
# Run all dotfiles installers.

set -e

cd "$(dirname $0)"/..

# find the installers and run them iteratively
find . -name install.sh | while read installer ; do sh -c "${installer}" ; done
