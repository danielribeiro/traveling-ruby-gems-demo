#!/bin/bash
set -ex

# Figure out where this script is located.
SELFDIR=$(cd $(dirname $0) && pwd)

# Tell Bundler where the Gemfile and gems are.
export BUNDLE_GEMFILE="$SELFDIR/vendor/Gemfile"
unset BUNDLE_IGNORE_CONFIG
script_relative_path=$1
shift
# Run the actual app using the bundled Ruby interpreter, with Bundler activated.
exec "$SELFDIR/ruby/bin/ruby" -rbundler/setup "$SELFDIR/$script_relative_path" "$@" #todo: configure this
