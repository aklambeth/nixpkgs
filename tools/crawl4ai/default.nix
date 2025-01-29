{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "crawl4ai";
  version = "0.4.247";
  src = ./.;
  
  nativeBuildInputs = [
    pkgs.python313
    pkgs.uv
    pkgs.makeWrapper
  ];

buildPhase = ''
   export UV_CACHE_DIR=$TMPDIR/.cache/uv
   export PLAYWRIGHT_BROWSERS_PATH=$out/browsers
   mkdir -p $UV_CACHE_DIR
   
   mkdir -p $out/venv
   ${pkgs.python313}/bin/python -m venv $out/venv
   source $out/venv/bin/activate
   ${pkgs.uv}/bin/uv pip install crawl4ai==0.4.247
   
   mkdir -p $PLAYWRIGHT_BROWSERS_PATH
   $out/venv/bin/python -m playwright install --with-deps chromium
 '';

 installPhase = ''
   mkdir -p $out/bin
   makeWrapper $out/venv/bin/python $out/bin/crawl4ai \
     --set PYTHONPATH "$out/venv/${pkgs.python313.sitePackages}" \
     --set PLAYWRIGHT_BROWSERS_PATH "$out/browsers" \
     --add-flags "-m crawl4ai"

   makeWrapper $out/venv/bin/crawl4ai-doctor $out/bin/crawl4ai-doctor \
     --set PYTHONPATH "$out/venv/${pkgs.python313.sitePackages}" \
     --set PLAYWRIGHT_BROWSERS_PATH "$out/browsers"

   makeWrapper $out/venv/bin/python $out/bin/python \
     --set PYTHONPATH "$out/venv/${pkgs.python313.sitePackages}" \
     --set PLAYWRIGHT_BROWSERS_PATH "$out/browsers"
 '';
}