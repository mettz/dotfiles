{
  inputs,
  pkgs,
  systemSettings,
  ...
}:

let
  system = systemSettings.system;
  extensions = inputs.nix-vscode-extensions.extensions.${system};
in
{
  home.packages = with pkgs; [
    nixfmt-rfc-style # official Nix formatter
    nil # Nix LSP implementation
  ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    userSettings = {
      # UI/UX
      "catppuccin.accentColor" = "blue";
      "extensions.ignoreRecommendations" = true;
      "telemetry.telemetryLevel" = "off";
      "window.restoreWindows" = "none";
      "window.titleBarStyle" = "custom";
      "workbench.startupEditor" = "none";
      "workbench.iconTheme" = "catppuccin-frappe";
      "workbench.colorTheme" = "Catppuccin Frappé";
      "workbench.editorAssociations" = {
        "*.pdf" = "pdf.preview";
      };

      # Editor
      "editor.acceptSuggestionOnCommitCharacter" = false;
      "editor.fontSize" = 16;
      "editor.fontFamily" = "Iosevka";
      "editor.fontWeight" = 500;
      "editor.fontLigatures" = true;
      "editor.multiCursorModifier" = "ctrlCmd";
      "editor.quickSuggestions" = {
        "other" = true;
        "comments" = true;
        "strings" = true;
      };
      "editor.suggestSelection" = "first";
      "editor.inlayHints.enabled" = "offUnlessPressed";
      "editor.bracketPairColorization.enabled" = false;
      "editor.stickyScroll.enabled" = false;
      "editor.inlineSuggest.enabled" = true;
      "editor.semanticHighlighting.enabled" = true;

      # Terminal
      "terminal.integrated.fontFamily" = "IosevkaTerm Nerd Font Mono";
      "terminal.integrated.fontSize" = 17;
      "terminal.integrated.minimumContrastRatio" = 1;
      "terminal.integrated.defaultProfile.linux" = "fish";
      "terminal.integrated.profiles.linux" = {
        "fish" = {
          "path" = "fish";
        };
      };

      # Web lang support
      "[html][javascript][javascriptreact][json][typescriptreact][typescript]" = {
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.codeActionsOnSave" = {
          "source.organizeImports" = "explicit";
        };
      };
      "javascript.updateImportsOnFileMove.enabled" = "always";
      "typescript.updateImportsOnFileMove.enabled" = "always";

      # Rust
      "[rust]" = {
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "rust-lang.rust-analyzer";
      };
      "rust-analyzer.check.allTargets" = false;
      "rust-analyzer.lens.implementations.enable" = false;
      "rust-analyzer.check.command" = "clippy";
      "rust-analyzer.imports.granularity.group" = "module";
      "rust-analyzer.hover.actions.implementations.enable" = false;
      "rust-analyzer.rustfmt.extraArgs" = [ "+nightly" ];

      # C/C++
      "[c][cpp]" = {
        "editor.defaultFormatter" = "xaver.clang-format";
        "editor.formatOnSave" = true;
        "editor.formatOnPaste" = true;
      };
      "clangd.path" = "/home/mettz/.config/VSCodium/User/globalStorage/llvm-vs-code-extensions.vscode-clangd/install/18.1.3/clangd_18.1.3/bin/clangd";

      # Nix
      "[nix]" = {
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
      "nix.formatterPath" = "nixfmt";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [ "nixfmt" ];
          };
        };
      };

      # Other extensions
      "git.autofetch" = true;
      "git.confirmSync" = false;
      "git.openRepositoryInParentFolders" = "always";
      "vsintellicode.modify.editor.suggestSelection" = "choseToUpdateConfiguration";
      "vsicons.dontShowNewVersionMessage" = true;
      "github.copilot.enable" = {
        "*" = true;
        "plaintext" = true;
        "markdown" = true;
        "scminput" = false;
      };
      "github.copilot.editor.enableAutoCompletions" = true;

      # Miscellaneous
      "files.associations" = {
        "*.xml" = "html";
        "*.svg" = "html";
        "*.c" = "c";
      };
    };
    extensions = [
      extensions.vscode-marketplace.bradlc.vscode-tailwindcss
      extensions.vscode-marketplace-release.dart-code.dart-code
      #extensions.vscode-marketplace.dart-code.flutter
      #extensions.vscode-marketplace.eamodio.gitlens
      #extensions.vscode-marketplace.esbenp.prettier-vscode
      #extensions.vscode-marketplace.github.copilot
      #extensions.vscode-marketplace.jnoortheen.nix-ide
      #extensions.vscode-marketplace.llvm-vs-code-extensions.vscode-clangd
      #extensions.vscode-marketplace.ms-vsliveshare.vsliveshare
      #extensions.vscode-marketplace.rust-lang.rust-analyzer
      #extensions.vscode-marketplace.tamasfe.even-better-toml
      #extensions.vscode-marketplace.tauri-apps.tauri-vscode
      #extensions.vscode-marketplace.tomoki1207.pdf
      #extensions.vscode-marketplace.usernamehw.errorlens
      #extensions.vscode-marketplace.visualstudioexptteam.intellicode-api-usage-examples
      #extensions.vscode-marketplace.visualstudioexptteam.vscodeintellicode
      #extensions.vscode-marketplace.vscode-icons-team.vscode-icons
      #extensions.vscode-marketplace.xaver.clang-format
      #extensions.vscode-marketplace.yzhang.markdown-all-in-one

      # Catppuccin comes from its overlay so that it can be configured in a declarative way
      (pkgs.catppuccin-vsc.override {
        accent = "blue";
      })
      extensions.vscode-marketplace.catppuccin.catppuccin-vsc-icons
    ];
    keybindings = [
      {
        key = "ctrl+1";
        command = "-workbench.action.focusFirstEditorGroup";
      }
      {
        key = "ctrl+1";
        command = "workbench.action.terminal.toggleTerminal";
        when = "terminal.active";
      }
      {
        key = "ctrl+oem_3";
        command = "-workbench.action.terminal.toggleTerminal";
        when = "terminal.active";
      }
    ];
  };
}
