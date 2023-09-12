#!/usr/bin/env bash
set -ex

PROJECT="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"  # https://stackoverflow.com/a/246128
U="$(id -u)"
G="$(id -g)"

mkdir -p "${PROJECT}/out"
docker run \
    --rm \
    --privileged \
    --network=bridge \
    -v "${PROJECT}:/root/project" \
    --interactive \
    --tty \
    'ghcr.io/void-linux/void-glibc-full:latest' \
    /bin/sh -c "\
        chmod +x /root/project/ci/set_repository.sh && /root/project/ci/set_repository.sh && \
        chmod +x /root/project/ci/install_dependencies.sh && /root/project/ci/install_dependencies.sh && \
        chmod +x /root/project/gen.sh && /root/project/gen.sh && \
        sh -c 'mv -vf /root/void-mklive/void-live-x86_64-*.iso /root/project/out/' && \
        chown -R '${U}:${G}' /root/project/out/ \
    "
docker image rm 'ghcr.io/void-linux/void-glibc-full:latest' || true

set +x

echo
echo "Success! Image is in directory:"
echo "  ${PROJECT}/out/"
