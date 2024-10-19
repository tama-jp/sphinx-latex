# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

import os
import sys

project = 'ドキュメント'
copyright = '2024, non'
author = 'non'

version = '1.0.0'
release = '1.0.0'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    'myst_parser',
    'sphinx.ext.autodoc',
    'sphinx.ext.napoleon',
    'sphinx_rtd_theme',
    'sphinx_multiversion',
    'sphinxcontrib.plantuml',
]

templates_path = ['_templates']
exclude_patterns = []

language = 'ja'

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'alabaster'
html_static_path = ['_static']

# 以下追加

myst_enable_extensions = [
    "amsmath",
    "attrs_inline",
    "colon_fence",
    "deflist",
    "dollarmath",
    "fieldlist",
    "html_admonition",
    "html_image",
    "linkify",
    "replacements",
    "smartquotes",
    "strikethrough",
    "substitution",
    "tasklist",
]

source_suffix = {
    '.rst': 'restructuredtext',
    '.txt': 'markdown',
    '.md': 'markdown',
}

# プロジェクトのルートディレクトリを取得
project_root = os.path.abspath(os.path.dirname(os.path.dirname(__file__)))

# PlantUMLのjarファイルへの相対パスを設定
plantuml_jar_path = os.path.join(project_root, 'tools', 'plantuml', 'plantuml-lgpl-1.2024.4.jar')

# PlantUMLの設定
plantuml = f'java -jar {plantuml_jar_path}'

# デバッグ用にパスを確認
print(f"PlantUML JAR Path: {plantuml_jar_path}")

latex_elements = {
    'preamble': r'''
    \usepackage{longtable}
    '''
}