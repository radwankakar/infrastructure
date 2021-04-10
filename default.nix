# to install
# nix-env -p /nix/var/nix/profiles/headstart-infra-tooling-packages -f nix -i
#
# use
#
# https://lazamar.co.uk/nix-versions/
# to find rev for specific package version

let
  pkgs = import <nixpkgs> {};
  inherit (pkgs) buildEnv;
in buildEnv {
  name = "headstart-infra-tooling-packages";
  paths = [

    (import (builtins.fetchGit {
      # Descriptive name to make the store path easier to identify
      name = "pre-commit-2.7.1";
      url = "https://github.com/NixOS/nixpkgs/";
      ref = "refs/heads/nixpkgs-unstable";
      rev = "559cf76fa3642106d9f23c9e845baf4d354be682";
    }) {}).pre-commit
  ];

  postBuild = ''
  echo 'put shell commands here'
  '';
}
