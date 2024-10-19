### 基本的なマークダウン構文

#### 見出し

```markdown
# これはH1見出しです
## これはH2見出しです
### これはH3見出しです
```

#### 強調

```markdown
*斜体*
**太字**
_斜体_
__太字__
```

#### リスト

- アイテム1
- アイテム2
    - ネストされたアイテム

```markdown
- アイテム1
- アイテム2
  - ネストされたアイテム
```

1. 項目1
2. 項目2

```markdown
1. 項目1
2. 項目2
```

#### リンクと画像

```markdown
[Google](https://www.google.com)

![画像の説明](https://via.placeholder.com/150)
```

#### 引用

```markdown
> これは引用です。
```

#### コードブロック

```markdown
```python
def hello():
    print("こんにちは")
```
```

### MySTの拡張構文

#### 数式 (dollar math)

インライン数式: `$y = mx + b$`

ブロック数式:

```markdown
$$
E = mc^2
$$
```

#### 定義リスト

```markdown
Markdown
:   軽量なマークアップ言語

Sphinx
:   ドキュメント生成ツール
```

#### 注意書き (Admonition)

```markdown
```{note}
これは注意書きです。
```
```

他にも`{warning}`, `{tip}`, `{important}`などのアドモニションが使えます。

#### コードフェンス (Colon Fence)

```markdown
:::python
def hello_world():
    print("こんにちは、世界")
:::
```

#### タブの利用

```markdown
```{tab} タブ1
タブ1の内容
```

```{tab} タブ2
タブ2の内容
```
```

#### 引用（インラインでの参照）

```markdown
```{cite}`Author2021`
```

#### 目次

```markdown
```{toc}
```

#### 目次の設定 (directive)

```markdown
```{toctree}
:titlesonly:

index
about
contact
```
```

#### 画像サイズの調整

```markdown
![サンプル画像](https://via.placeholder.com/150){ width=50% }
```
