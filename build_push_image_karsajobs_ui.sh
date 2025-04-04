#!/bin/bash
set -e                                                                                  # saat ada error pada saat eksekusi script, maka akan dihentikan

# define variable
IMAGE_NAME="karsajobs"                                                                  # variabel nama image
IMAGE_TAG="latest"                                                                      # variabel untuk version tag
GITHUB_USER="tri-susilo"                                                                # variabel user github
GITHUB_PACKAGE="ghcr.io/$GITHUB_USER/$IMAGE_NAME:$IMAGE_TAG"                            # variabel menyimpan format github packages tagging

echo "Build docker image:.."                                                            
docker build -t "$IMAGE_NAME:$IMAGE_TAG" .                                              # proses build docker image dan memberi tag version

echo "Tagging Image..."                                                                 
docker tag "$IMAGE_NAME:$IMAGE_TAG" "$GITHUB_PACKAGE"                                   # melakukan taging pada image supaya sesuai dengan format github packages

echo "Login ke GitHub Container Registry..."
echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$GITHUB_USER" --password-stdin          # login ke github Package. env variabke $GITHUB_TOKEN sudah diset di server sebelumnya berisikan PAT

echo "Upload image ke GitHub Packages..."
docker push "$GITHUB_PACKAGE"                                                           # push image ke github packages

echo "Image berhasil di-push ke GitHub Packages: $GITHUB_PACKAGE"                        # print notifikasi bahwa image berhasil di build dan telah dipush ke github packages