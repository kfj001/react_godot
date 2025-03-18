# Use Ubuntu as the base image
FROM --platform=linux/amd64  ubuntu:25.04
# Arguments (Godot framework version)
ARG GODOT_VERSION="4.4"

#Environment Variables
ENV DEBIAN_FRONTEND="noninteractive"

WORKDIR /app


# Install Basic Linux updates and foundational packages
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        wget unzip nodejs npm git ssh
# Download & Install Godot Linux x64

# Download and extract Godot
RUN wget https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip && \
    unzip Godot_v${GODOT_VERSION}-stable_linux*.zip && \
    mv Godot_v${GODOT_VERSION}-stable_linux*64 /usr/local/bin/godot

# Download and extract export templates like HTML 5
RUN wget https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_export_templates.tpz && \
unzip Godot_v${GODOT_VERSION}-stable_export_templates.tpz && \
mkdir -p ~/.local/share/godot/export_templates/${GODOT_VERSION}.stable && \
mv templates/* ~/.local/share/godot/export_templates/${GODOT_VERSION}.stable

# Remove unnecessary files
RUN rm Godot_v${GODOT_VERSION}-stable_export_templates.tpz Godot_v${GODOT_VERSION}-stable_linux*.zip

WORKDIR /workspaces