FROM    ubuntu:21.04

# Skip tzdata (required by ) installation questions, by setting ...
ENV     DEBIAN_FRONTEND=noninteractive

ENV     CC=clang
ENV     CXX=clang++

RUN     apt-get update                                              \
        && apt-get install --yes --quiet --no-install-recommends    \
            clang                                                   \
            clang-format											\
            cmake                                                   \
            make                                                    \
            python3-pip                                             \
        && pip install                                              \
            conan

COPY    scripts/entrypoint.sh /entrypoint.sh
RUN     chmod +x /entrypoint.sh

COPY    . /usr/src/app
WORKDIR /usr/src/app

ENTRYPOINT [ "/entrypoint.sh" ]
