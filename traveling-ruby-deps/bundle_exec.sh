#!/bin/bash
set -ex

# Figure out where this script is located.
SELFDIR=$(cd $(dirname $0) && pwd)

# Tell Bundler where the Gemfile and gems are.
export BUNDLE_GEMFILE="$SELFDIR/vendor/Gemfile"
unset BUNDLE_IGNORE_CONFIG
command_name=$1
shift
#find the command path
binpath=`find "$SELFDIR/vendor" -wholename "*/gems/*/bin/$command_name" | grep -E 'gems/[^/]+/bin'`
# Run the actual app using the bundled Ruby interpreter, with Bundler activated.
exec "$SELFDIR/ruby/bin/ruby" -rbundler/setup -r"$SELFDIR/undo_bundler" "$binpath" "$@"
