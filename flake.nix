{
  description = "GLFW Game Development Environment with C";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs =
    { self, nixpkgs }:
    let
      # should work for both arch and x86 64 bits machine
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = fn: nixpkgs.lib.genAttrs systems (system: fn nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            glfw
            libGL 
            xorg.libX11
            xorg.libXrandr
            xorg.libXinerama
            xorg.libXcursor
            xorg.libXi
            pkg-config 
            gnumake 
            glxinfo 
          ];

          shellHook = ''
            echo "Welcome to the GLFW Game Dev Environment!"
            echo "GCC version: $(gcc --version | head -n1)"
            echo "GLFW version: $(pkg-config --modversion glfw3)"
            echo "OpenGL info:"
            glxinfo | grep "OpenGL version string" || echo "glxinfo not available"
            export PKG_CONFIG_PATH="${pkgs.glfw}/lib/pkgconfig:${pkgs.libGL.dev}/lib/pkgconfig:${pkgs.xorg.libX11.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
            export CFLAGS="-I${pkgs.glfw}/include -I${pkgs.libGL.dev}/include -I${pkgs.xorg.libX11.dev}/include"
            export LDFLAGS="-L${pkgs.glfw}/lib -L${pkgs.libGL}/lib -L${pkgs.xorg.libX11}/lib"
          '';
        };
      });
    };
}
