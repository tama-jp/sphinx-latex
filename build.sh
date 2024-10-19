#!/usr/bin/env bash

# 対象のディレクトリを指定 (例: /docs)
DIRECTORY="/docs"

# Sphinx ドキュメントのビルド
echo "Building Sphinx documentation..."

make -C /docs clean
make -C /docs html
make -C /docs latexpdf
make -C /docs epub

rm -rf /docs/data
mkdir -p /docs/data
cp -r /docs/build/html /docs/data/html
cp /docs/build/epub/*.epub /docs/data/
cp /docs/build/latex/*.pdf /docs/data/

rm -rf /docs/build

echo "Sphinx documentation build complete."