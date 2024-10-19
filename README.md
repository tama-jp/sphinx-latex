# sphinx-latex

```
v202410192100-g1.23.1-p3.12.6-j23-2024-09-17
```

test
```
docker-compose up --build

docker-compose --file docker-compose_image.yml up --build

```



```
docker-compose exec sphinx-doc /bin/sh
```
初期化
```
sphinx-quickstart --sep -q -p ドキュメント -a non -v 1.0.0  -l ja . 

sphinx-quickstart --sep -q -p ドキュメント \
                  -a "non" -v 1.0.0 \
                  -r 1.0.0 \
                  -l ja \
                  --extensions myst_parser,sphinx.ext.autodoc,sphinx.ext.napoleon,sphinx_rtd_theme,sphinx_multiversion,sphinxcontrib.plantuml .

```
