{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "catppuccin_mocha-zsh-syntax-highlighting";
  version = "1.0.0";  # You can adjust this version as needed

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "zsh-syntax-highlighting";
    rev = "7926c3d3e17d26b3779851a2255b95ee650bd928";
    hash = "sha256-l6tztApzYpQ2/CiKuLBf8vI2imM6vPJuFdNDSEi7T/o=";
  };

  installPhase = ''
    mkdir -p $out/share/zsh-syntax-highlighting/themes
    cp themes/catppuccin_mocha-zsh-syntax-highlighting.zsh $out/share/zsh-syntax-highlighting/themes/
  '';

  meta = with lib; {
    description = "Catppuccin Mocha theme for zsh-syntax-highlighting";
    homepage = "https://github.com/catppuccin/zsh-syntax-highlighting";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = [];
  };
})