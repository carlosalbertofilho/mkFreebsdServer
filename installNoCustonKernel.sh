#!/bin/sh

set -e

for subscript in root-scripts/*.sh; do
    echo executing "$subscript";
    $subscript;
done

echo
echo success!
echo