{
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    extraConfig = ''
      HandlePowerKey=suspend
      HibernateDelaySec=3600
    '';
  };
}
