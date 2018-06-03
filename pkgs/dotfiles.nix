with import <nixpkgs> {};

stdenv.mkDerivation rec {
  version = "0.0.1";
  name = "dotfiles-${version}";

  src = fetchFromGitHub {
    owner = "aabs";
    repo = "fishdots";
    rev = "v${version}";
    sha256 = "25bd291ccee95446552474427651002813ad4fd5";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp dotfiles-update $out/bin
  '';

}
