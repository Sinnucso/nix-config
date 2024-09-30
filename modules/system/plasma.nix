{lib, config, pkg, ... }:

{
  imports = [

  ];

  options = {
  plasma.enable
    = lib.mkEnableOption "enable KDE plasma module";
  };
  

  config = lib.mkIf config.plasma.enable {
  #somestuff
    environment.systemPackages = with pkgs; [
      sl
    ];
  };

}
