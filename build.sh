#!/usr/bin/env bash

# 対象のディレクトリを指定 (例: /docs)
DIRECTORY="/docs"

# PlantUML ファイルの変換
find "$DIRECTORY" -name "*.puml" | while read -r puml_file; do
    # 出力ファイルの名前を決定 (拡張子を .png に変更)
    output_file="${puml_file%.puml}.png"

    echo "Converting $puml_file to $output_file..."

    # PlantUML JAR ファイルを使ってPNGに変換
    # PlantUML の jar ファイルパスを指定する
    plantuml_jar="/usr/local/bin/plantuml.jar"

    echo "java -jar \"$plantuml_jar\" \"$puml_file\""
    java -jar "$plantuml_jar" "$puml_file"

    # 変換が成功したか確認
    if [ $? -eq 0 ]; then
        echo "Successfully converted $puml_file to $output_file"
    else
        echo "Failed to convert $puml_file"
    fi
done


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