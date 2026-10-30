{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.aichat.enable = true;
  programs.aichat.settings = {
    model = "ollama:phi4-mini"; # default model
    stream = true;
    highlight = true;
    save_session = true;

    clients = [
      {
        type = "openai-compatible";
        name = "ollama";
        api_base = "http://localhost:11434/v1";
        api_key = "ollama"; # Local placeholder key
        models = [
          {
            name = "deepseek-r1:7b";
            max_input_tokens = 131072;
            supports_reasoning = true; # Handles R1 thinking blocks correctly
          }
          {
            name = "phi4-mini";
            max_input_tokens = 131072;
          }
          {
            name = "qwen2.5-coder:1.5b-base";
            max_input_tokens = 32768;
          }
        ];
      }
    ];
  };
}
