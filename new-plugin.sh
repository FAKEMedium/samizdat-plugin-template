#!/bin/sh
# Turn this template into a new plugin: ./new-plugin.sh <ModuleName>
# e.g. ./new-plugin.sh Widget   ->   Samizdat::Plugin::Widget, helper `widget`, schema `widget`
set -e
M=$1
[ -z "$M" ] && { echo "Usage: $0 <ModuleName>  (CamelCase, e.g. Widget)"; exit 1; }
m=$(printf '%s' "$M" | tr 'A-Z' 'a-z')

# rename paths (deepest first) containing 'skeleton'
find . -depth -name '*skeleton*' -not -path './.git/*' | while read -r p; do
  np=$(printf '%s' "$p" | sed "s/skeleton/$m/g")
  mkdir -p "$(dirname "$np")"; mv "$p" "$np"
done

# substitute content: Skeleton -> $M, skeleton -> $m (skip .git)
grep -rlI -e Skeleton -e skeleton . --exclude-dir=.git 2>/dev/null | while read -r f; do
  sed -i "s/Skeleton/$M/g; s/skeleton/$m/g" "$f"
done

echo "Renamed Skeleton -> $M / skeleton -> $m."
echo "Next: review Makefile.PL (NAME, ABSTRACT, PREREQ_PM), fill in the model/migration,"
echo "set x-samizdat-audience in settings/$m/schema.yml, then: git add -A && git commit."
echo "Delete this script when done: rm new-plugin.sh"
