FROM alpine:edge

LABEL maintainer "Adam Spannbauer <spannbaueradam@gmail.com>"

WORKDIR /usr/src/app

RUN adduser -u 9000 -D app

RUN apk --no-cache add \
        R \
        R-dev \
        R-doc \
        curl \
        libressl-dev \
        curl-dev \
        libxml2-dev \
        gcc \
        g++ \
        git \
        coreutils \
        bash \
        ncurses && \
    git clone https://github.com/ropensci/git2r.git && \
    R CMD INSTALL --configure-args="--with-libssl-include=/usr/lib/" git2r && \
    rm -rf git2r /tmp/* && \
    R -e "install.packages('lintr', repos = 'http://cran.us.r-project.org')" && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

COPY . /usr/src/app
RUN chown -R app:app /usr/src/app

USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/codeclimate-R"]
