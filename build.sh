make epub
make latexpdf
make html

rm -rf /docs/data
mkdir -p /docs/data
cp -r /docs/build/html /docs/data/html
cp /docs/build/epub/*.epub /docs/data/
cp /docs/build/latex/*.pdf /docs/data/

