#!/usr/bin/env bash
# -*- coding: utf-8 -*-
#
# DESCRIPTION: generate-md-reference Extracts the snippets shortcut and description and inserts a markdown
# table in README.md
#
# VERSION: 0.0.1
#
# AUTHOR: Jordi Roca
# CREATED: 2022/12/29 21:34
#
# GITHUB: https://github.com/jordiroca/
# WEBSITE: https://jordiroca.com
#
# LICENSE: See LICENSE file.
#

echo '| prefix | description |' > _reftable.md
echo '| --- | --- |' >> _reftable.md

jq -r '.[] | [ .prefix, .description ] | @csv' jrbashnippets.code-snippets |
    tr -d '"' |
    while IFS=, read -r field1 field2; do
        echo "| <pre>$field1</pre> | $field2 |"
    done >> _reftable.md


inicio='STARTREFTABLE'
final='ENDREFTABLE'

# newContent=`cat _reftable.md`
# perl -0777 -i -pe "s/(.*$inicio.*).*(.*$final.*)/\$1$newContent\$2/s" README.md

# sed -e "/$inicio/,/$final/{ /$inicio/{p; r _reftable.md
#                         };/$final/p; d }" README.md

csplit -s -f _tmpsplit_ README.md '/.*STARTREFTABLE.*/+1' '/.*ENDREFTABLE.*/'
cat _tmpsplit_00 _reftable.md _tmpsplit_02 > README.md

rm -f _reftable.md _tmpsplit_0*
