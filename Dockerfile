FROM debian:bullseye-20220228
# https://hub.docker.com/_/debian

RUN apt update -y
RUN apt remove -y python3-distutils python3 && \
    apt install -y curl git \
                   software-properties-common build-essential \
                   libnss3-dev zlib1g-dev libgdbm-dev libncurses5-dev \
                   libssl-dev libffi-dev libreadline-dev libsqlite3-dev libbz2-dev

WORKDIR /usr/src

## ■ Python
# https://computingforgeeks.com/how-to-install-python-latest-debian/
ENV PYTHONVERSION 3.10.2
ENV PYTHONVERSIONBIN 3.10

RUN curl -s -o /tmp/Python-$PYTHONVERSION.tgz  https://www.python.org/ftp/python/$PYTHONVERSION/Python-$PYTHONVERSION.tgz && \
    tar xvf /tmp/Python-$PYTHONVERSION.tgz && \
    rm -rf /tmp/Python-$PYTHONVERSION.tgz && \
    cd /usr/src/Python-$PYTHONVERSION && \
    ./configure --enable-optimizations && \
    make altinstall && \
    ln -s /usr/local/bin/python$PYTHONVERSIONBIN /usr/local/bin/python3 && \
    ln -s /usr/local/bin/pip$PYTHONVERSIONBIN /usr/local/bin/pip3

RUN python3 -m pip install --upgrade pip

# ■ go言語
# https://go.dev/dl/
ENV ARCH amd64
ENV GOVERSION 1.18
ENV HOME /root
ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $HOME/work
ENV PATH $GOPATH/bin:$PATH

WORKDIR /usr/local
RUN curl -s -o /tmp/go.tar.gz https://storage.googleapis.com/golang/go$GOVERSION.linux-$ARCH.tar.gz && \
    tar xvf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz

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
RUN pip install --upgrade myst-parser

# ■ Apache
ENV APACHE_DOCUMENT_ROOT /docs/build/html

RUN apt-get update; \
    apt-get install -y apache2

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# データ設定
WORKDIR /util
COPY air.toml /util/air.toml
COPY ./run.sh /util/run.sh

RUN chmod 775 /util/run.sh

WORKDIR /docs

EXPOSE 80

CMD ["/bin/sh", "-c", "/util/run.sh"]
