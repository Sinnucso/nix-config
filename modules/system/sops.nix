{inputs, config, ... }:

let
  secretspath = builtins.toString inputs.mysecrets;
in
{
  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
#    defaultSopsFile = ../../secrets.yaml;
    age.keyFile = "/home/sinnucso/.config/sops/age/keys.txt";
#    secrets.nixos_secret = {
#      sopsFile = ../../secrets.yaml;
#    };
    secrets.test = {};    
  };
}
