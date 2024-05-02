#!/usr/bin/env bash

# This script is used to setup neovim.

APPIMAGE_LINK="https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"
CURL_CMD="curl -s -L ${APPIMAGE_LINK}"
TARGET_DIR="${HOME}/.local/share/nvim-appimage"

# Ensure target dir exists
mkdir -p "${TARGET_DIR}" || exit 1

# Check if update is needed
if [ -f "${TARGET_DIR}/nvim.appimage.sha256" ]; then
    SUM_INSTALLED=$(cat ${TARGET_DIR}/nvim.appimage.sha256 | cut -d " " -f 1)
    SUM_REMOTE=$(${CURL_CMD} | sha256sum | cut -d " " -f 1)

    echo "Installed: ${SUM_INSTALLED}"
    echo "Remote: ${SUM_REMOTE}"
    if [ "${SUM_INSTALLED}" == "${SUM_REMOTE}" ]; then
        echo "Neovim is up to date."
        exit 0
    fi
fi

pushd /tmp

${CURL_CMD} -O && chmod +x nvim.appimage
./nvim.appimage --appimage-extract && rm -rf ${TARGET_DIR} && mkdir -p ${TARGET_DIR} && mv squashfs-root/** ${TARGET_DIR}

ln -sf ${TARGET_DIR}/AppRun ${HOME}/.local/bin/nvim

sha256sum nvim.appimage > ${TARGET_DIR}/nvim.appimage.sha256

popd
