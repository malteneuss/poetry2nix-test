# Use the Nix image as the base
FROM docker.io/nixos/nix:2.21.1

RUN mkdir /app
WORKDIR /app
# Copy the default.nix file into the Docker image
COPY nix /app/nix
COPY default.nix .

# Run nix-build to build the default.nix file
RUN nix-build