FROM    ubuntu:21.04

# Skip tzdata (required by ) installation questions, by setting ...
ENV     DEBIAN_FRONTEND=noninteractive

ENV     CC=clang
ENV     CXX=clang++

RUN     apt-get update                                              \
        && apt-get install --yes --quiet --no-install-recommends    \
            clang                                                   \
            clang-format                                            \
            cmake                                                   \
            make                                                    \
            python3-pip                                             \
        && pip install                                              \
            conan                                                   \
        && rm -rf /var/lib/apt/lists/*

COPY    . /usr/src/app
WORKDIR /usr/src/app

ENTRYPOINT [ "/usr/src/app/scripts/entrypoint.sh" ]
