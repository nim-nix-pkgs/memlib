{
  description = ''Load Windows DLL from memory'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."memlib-master".dir   = "master";
  inputs."memlib-master".owner = "nim-nix-pkgs";
  inputs."memlib-master".ref   = "master";
  inputs."memlib-master".repo  = "memlib";
  inputs."memlib-master".type  = "github";
  inputs."memlib-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."memlib-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}