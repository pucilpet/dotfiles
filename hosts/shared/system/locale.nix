{lib, ...}: {
  i18n = {
    defaultLocale = lib.mkDefault "fi_FI.UTF-8";

    extraLocaleSettings = {
      LC_TIME = lib.mkDefault "fi_FI.UTF-8";
    };

    supportedLocales = lib.mkDefault [
      "fi_FI.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };

  time = {
    timeZone = lib.mkDefault "Europe/Helsinki";
    hardwareClockInLocalTime = true;
  };
}
