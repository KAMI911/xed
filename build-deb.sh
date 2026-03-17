#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE="xed-builder"
OUTPUT="${SCRIPT_DIR}/dist"

echo ">>> Building Docker image..."
docker build -f "${SCRIPT_DIR}/Dockerfile.build" -t "${IMAGE}" "${SCRIPT_DIR}"

echo ">>> Extracting .deb packages to ${OUTPUT}..."
mkdir -p "${OUTPUT}"
docker run --rm \
    -v "${OUTPUT}:/out" \
    "${IMAGE}" \
    sh -c "cp /output/*.deb /out/ && ls -lh /out/"

echo ""
echo "Done. Packages are in: ${OUTPUT}"
