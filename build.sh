#!/bin/bash
PANDOC_OPTS="-s -f markdown_github+yaml_metadata_block"
FULL="metadata.yaml markdown_files/???_*.md"

shopt -s nullglob
for f in markdown_files/*.md ;do
    filename=${f#*/}
    no_ext=${filename%.md}
    html_name="${no_ext#[0-9][0-9][0-9]_}.html"
    pandoc --template=template.html -t writer.lua -o $html_name $PANDOC_OPTS metadata.yaml $f
done

pandoc -o static/informator.epub $PANDOC_OPTS $FULL
pandoc --latex-engine=xelatex --template=template.tex -o static/informator.pdf $PANDOC_OPTS $FULL
