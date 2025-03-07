{
  plugins.cornelis = {
    enable = true;
    settings = {
      use_global_binary = 0;
      agda_prefix = "<Tab>";
    };
  };
  #extraConfigLua = "require('cornelis');";
}
