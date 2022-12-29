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

jq -r '.[] | [ .prefix, .description ] | @csv' jrbashnippets.code-snippets | tr -d '"' | while IFS=, read -r field1 field2
do
    echo "| $field1 | $field2"
done