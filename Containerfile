FROM registry.fedoraproject.org/fedora-minimal:42 as build
RUN dnf install -y highlight wget2 tar make jq && dnf clean all
RUN wget2 https://github.com/bash/seite/releases/download/0.1.7/x86_64-unknown-linux-musl.tar.gz -O seite.tar.gz && \
	tar -xvf seite.tar.gz && \
	mv seite /usr/local/bin/ && \
	rm seite.tar.gz
RUN mkdir -p /usr/src/wiki
COPY . /usr/src/wiki
WORKDIR /usr/src/wiki
RUN make

FROM scratch
COPY --from=build /usr/src/wiki/public .
