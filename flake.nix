{
  description = "dependencies for coding a  GUI in c";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };
  outputs =
    { self, nixpkgs }:
    {
      devShells.x86_64-linux.default =
        let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
        in
        pkgs.mkShell {
          packages = with pkgs; [
            gcc
            glfw
            SDL2
            pkg-config
            gnumake
          ];
          shellHook = ''echo "required deps have been installed into the shell, enjoy!!!" tree '';
        };
    };
}
