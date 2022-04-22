make epub
make latexpdf
make html

rm -rf /docs/data
mkdir -p /docs/data
cp -r /docs/build/html /docs/data/html
cp /docs/build/epub/sphinx.epub /docs/data/doc.epub
cp /docs/build/latex/sphinx.pdf /docs/data/doc.pdf

