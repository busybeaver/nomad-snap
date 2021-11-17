# A Debian based minimal Node.js with Python installed; mostly used for running the GitHub Action CI locally via "act";
# Tries to mimic the runtime environment of GitHub Actions while being as minimal as possible
FROM node:slim@sha256:79a728a6d750a11177abe61bf0cd7212604b01656bcc42f548cb90853c1adb81

RUN apt-get update && apt-get install python -y && apt-get clean
