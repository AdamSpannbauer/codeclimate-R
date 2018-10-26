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
        ncurses

RUN git clone https://github.com/ropensci/git2r.git
RUN R CMD INSTALL --configure-args="--with-libssl-include=/usr/lib/" git2r
RUN rm -rf git2r /tmp/*

RUN R -e "install.packages(c('lintr', 'jsonlite'), repos = 'http://cran.us.r-project.org')"
RUN rm -rf /tmp/*

COPY . /usr/src/app
RUN chown -R app:app /usr/src/app

USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/codeclimate-R"]
