FROM ghcr.io/tama-jp/docker-language-programming:v-gpj-202410152200-g1.23.1-p3.12.6-j23-2024-09-17

# Install Air
RUN go install github.com/air-verse/air@latest

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
      graphviz \
      imagemagick \
      make \
      \
      latexmk \
      lmodern \
      fonts-freefont-otf \
      texlive-latex-recommended \
      texlive-latex-extra \
      texlive-fonts-recommended \
      texlive-fonts-extra \
      texlive-lang-cjk \
      texlive-lang-chinese \
      texlive-lang-japanese \
      texlive-luatex \
      texlive-xetex \
      xindy \
      tex-gyre \
 && apt-get autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

#RUN python3 -m pip install  myst-parser
RUN pip install --upgrade myst-parser --root-user-action=ignore && \
    pip install --upgrade sphinx-rtd-theme --root-user-action=ignore && \
    pip install --upgrade sphinx-bootstrap-theme --root-user-action=ignore && \
    pip install --upgrade sphinx-multiversion --root-user-action=ignore && \
    pip install --upgrade sphinxcontrib-plantuml --root-user-action=ignore && \
    pip install --upgrade linkify-it-py --root-user-action=ignore

# フォントファイルを追加
COPY SourceHanSansJP.zip /tmp/SourceHanSansJP.zip
COPY NotoSansJP.zip /tmp/NotoSansJP.zip

# 必要なパッケージをインストール
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
    fontconfig unzip && \
    mkdir -p /usr/share/fonts/noto && \
    unzip -o -d /usr/share/fonts/noto /tmp/NotoSansJP.zip && \
    unzip -o -d /usr/share/fonts/noto /tmp/SourceHanSansJP.zip && \
    chmod 644 /usr/share/fonts/noto/*.otf && \
    fc-cache -fv


# フォント設定ファイルを追加
COPY local.conf /etc/fonts/local.conf

# PlantUMLのインストール
RUN curl -L https://sourceforge.net/projects/plantuml/files/plantuml.jar/download -o /usr/local/bin/plantuml.jar && \
    echo '#!/bin/sh\njava -jar /usr/local/bin/plantuml.jar "$@"' > /usr/local/bin/plantuml && \
    chmod +x /usr/local/bin/plantuml


# ■ Apache
ENV APACHE_DOCUMENT_ROOT /docs/build/html

RUN apt-get update; \
    apt-get install -y apache2 && \
    sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf && \
    sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# データ設定
WORKDIR /util
COPY ./air.toml /util/air.toml
COPY ./run.sh /util/run.sh
COPY ./build.sh /util/build.sh

RUN chmod 775 /util/run.sh && \
    chmod 775 /util/build.sh

WORKDIR /docs

EXPOSE 80

ENTRYPOINT ["/bin/sh", "-c", "/util/run.sh"]
