{ lib, config, ... }:
{
  plugins.copilot-cmp = lib.mkIf config.plugins.cmp.enable {
    enable = false;
  };
  plugins.copilot-lua = {
    enable = false;
    suggestion = {
      enabled = false;
    };
    panel = {
      enabled = false;
    };
  };

  extraConfigLua = lib.mkIf config.plugins.cmp.enable ''
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  '';
}
