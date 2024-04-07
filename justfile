lock:
  nix-shell shell.nix --run "poetry lock"  

build:
  nix-build release.nix -A python-app

run:
  ./result/bin/some