{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.ollama = {
    enable = true;
    syncModels = true;

    loadModels = [
      "qwen2.5-coder:1.5b-base" # FIM
      "qwen3.5:9b" # Pair programming
      "deepseek-r1:7b" # Complex reasoning
      "phi4-mini" # Generic model
    ];
  };
}
