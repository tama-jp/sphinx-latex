FROM tamatan/go-python-java:v-gpj-202208221400-g1.19-p3.10.6-j11.0.16

# Install Air
RUN go install github.com/cosmtrek/air@latest

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
RUN pip install --upgrade myst-parser && \
     pip install sphinx-rtd-theme && \
     pip install sphinx-adc-theme && \
     pip install sphinx-bootstrap-theme

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
