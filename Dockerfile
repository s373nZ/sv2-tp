FROM debian:bookworm-slim

# Install build dependencies
RUN apt-get update && apt-get install -y \
    capnproto \
    libcapnp-dev \
    build-essential \
    cmake \
    libtool \
    autotools-dev \
    automake \
    pkg-config \
    bsdmainutils \
    curl \
    git \
    ca-certificates \
    libevent-dev \
    libboost-system-dev \
    libboost-filesystem-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libminiupnpc-dev \
    libzmq3-dev \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy source code
COPY . /sv2-tp

WORKDIR /sv2-tp

# Build using CMake
RUN cmake -B build \
    && cmake --build build --parallel $(nproc) \
    && cp build/bin/sv2-tp /usr/local/bin/

EXPOSE 8181

ENTRYPOINT ["/usr/local/bin/sv2-tp"]
CMD ["-debug=sv2", "-debuglogfile=0", "-loglevel=sv2:trace"]
