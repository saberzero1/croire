{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.vscode-extensions.asvetliakov.vscode-neovim
        pkgs.vscodium
      ];
    };
    programs = {
      vscode = {
        enable = false;
        enableExtensionUpdateCheck = true;
        mutableExtensionsDir = true;
        package = pkgs.vscodium;
        userSettings = {
          "workbench.iconTheme": "file-icons",
          "pieces.setCopilotLocation": true,
          "workbench.colorTheme": "Tokyo Night Storm",
          "editor.fontFamily": "'Fira Mono', Consolas, 'Courier New', monospace",
          "[scss]": {
          "editor.defaultFormatter": "esbenp.prettier-vscode"
          },
          "[typescript]": {
          "editor.defaultFormatter": "esbenp.prettier-vscode"
          },
          "[css]": {
          "editor.defaultFormatter": "esbenp.prettier-vscode"
          },
          "[typescriptreact]": {
          "editor.defaultFormatter": "esbenp.prettier-vscode"
          },
          "[jsonc]": {
          "editor.defaultFormatter": "esbenp.prettier-vscode"
          },
          "[html]": {
          "editor.defaultFormatter": "esbenp.prettier-vscode"
          },
          "files.eol": "\n",
          "svelte.enable-ts-plugin": true,
          "vscode-neovim.neovimExecutablePaths.linux": "/usr/bin/nvim",
          "extensions.experimental.affinity": {
          "asvetliakov.vscode-neovim": 1
          },
          "editor.lineNumbers": "relative",
          "editor.cursorSurroundingLines": 7,
          "[javascript]": {
          "editor.defaultFormatter": "esbenp.prettier-vscode"
          },
          "apc.imports": [
          "/C:/Users/e.bangma/AppData/Local/nvim/lua/vscode/apc-ui/script.js",
          "/C:/Users/e.bangma/AppData/Local/nvim/lua/vscode/apc-ui/styles.css",
          ],
          "workbench.layoutControl.enabled": false,
          "window.commandCenter": false,
          "syncSettings.resources": [
          "extensions",
          "keybindings",
          "settings",
          "snippets",
          "uiState"
          ],
          "workbench.sideBar.location": "right",
          "workbench.editor.showTabs": "multiple",
          "window.titleBarStyle": "custom",
          "apc.stylesheet": {
          "body": {
          // other panels should be transparent see "workbench.colorCustomizations"
          "background-image": "linear-gradient(to top, rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.2)), url(/C:/Users/e.bangma/AppData/Local/nvim/lua/vscode/resources/background.jpg)",
          "background-size": "cover",
          "background-blend-mode": "multiply",
          "background-repeat": "no-repeat",
          "background-color": "#1979c2ff",
          },
          "body::before": {
          "content": "''",
          "position": "fixed",
          "top": "0",
          "left": "0",
          "width": "100%",
          "height": "100%",
          "background": "inherit",
          "filter": "blur(10px) brightness(0.35)",
          "z-index": "-1"
          },
          ".monaco-editor .cursor": "background: linear-gradient(to bottom, #ee0979, #ff6a00) !important; box-shadow: 0 0 42px 5px #ee0979, #ff6a00 0px 0px 34px 1px; color: #161616 !important"
          },
          "apc.activityBar": {
          "position": "bottom",
          "hideSettings": true,
          "size": 20
          },
          "apc.statusBar": {
          "position": "editor-bottom",
          "height": 20,
          "fontSize": 10
          },
          "apc.electron": {
          //"titleBarStyle": "hiddenInset",
          "titleBarStyle": "hidden",
          "trafficLightPosition": {
          "x": 7,
          "y": 5
          }
          },
          "apc.header": {
          "height": 25,
          "fontSize": 11
          },
          "apc.listRow": {
          "height": 19,
          "fontSize": 11
          },
          //"workbench.iconTheme": "material-icon-theme",
          "workbench.settings.editor": "json",
          "workbench.startupEditor": "none",
          //"editor.fontFamily": "'Roboto Mono'",
          "editor.fontSize": 11,
          "breadcrumbs.enabled": false,
          "editor.minimap.enabled": false,
          "editor.tokenColorCustomizations": {
          "textMateRules": [
          {
          "name": "Default",
          "scope": [
          "",
          "support.type.property-name.json",
          "meta.attribute.unrecognized",
          "support.type.property-name.css",
          "meta.field.declaration",
          "meta.template.expression"
          ],
          "settings": {
          "foreground": "#ddd"
          }
          },
          {
          "name": "Grey - comments",
          "scope": [
          "comment"
          ],
          "settings": {
          "foreground": "#455A64"
          }
          },
          {
          "name": "Green - string",
          "scope": [
          "string.quoted.single",
          "string.quoted.double",
          "string.template",
          "punctuation.definition.string.template",
          "variable.parameter.url.css"
          ],
          "settings": {
          "foreground": "#98c379"
          }
          },
          {
          "name": "Purple - number",
          "scope": [
          "constant.numeric",
          "keyword.other.unit",
          "constant.other.color.rgb-value.hex"
          ],
          "settings": {
          "foreground": "#c678dd"
          }
          },
          {
          "name": "Yellow - Keywords",
          "scope": [
          "keyword.control",
          "keyword.operator",
          "variable.language",
          "constant.language",
          "storage.modifier",
          "entity.other.ng-binding-name.template.html",
          "source.css meta.property-value",
          "string.regexp",
          "punctuation.definition.template-expression.begin",
          "support.type.object.module",
          "punctuation.separator.statement.and.shell"
          ],
          "settings": {
          "foreground": "#FFD14A"
          }
          },
          {
          "name": "blue",
          "scope": [
          "storage.type",
          "meta.definition.method",
          "meta.definition.function",
          "entity.name.type.class",
          "meta.function-call",
          "entity.name.tag",
          "entity.name.tag",
          "entity.other.attribute-name.id.css",
          "entity.other.attribute-name.class.css",
          "meta.at-rule.keyframes",
          "support.function.misc",
          "support.class.component",
          "support.function.builtin.shell",
          "entity.name.command.shell"
          ],
          "settings": {
          "foreground": "#00AEFF"
          }
          },
          {
          "name": "Cyan 200",
          "scope": [
          "meta.attribute",
          "entity.other.attribute-name.tsx",
          "entity.other.attribute-name.jsx",
          "entity.other.attribute-name.pseudo-class",
          "entity.other.attribute-name.pseudo-element",
          "storage.type.function",
          "storage.type.class",
          "entity.other.ng-binding-name.event.html",
          "entity.other.ng-binding-name.property"
          ],
          "settings": {
          "foreground": "#80DEEA"
          }
          },
          {
          "name": "[CSS] - Keyword",
          "scope": [
          "source.css punctuation.definition.keyword",
          "source.css keyword",
          "entity.name.tag.reference",
          "keyword.other.important",
          "string.unquoted.heredoc.expanded.shell",
          "keyword.control.at-rule",
          "punctuation.definition.tag.end",
          "punctuation.definition.tag.begin"
          //
          ],
          "settings": {
          "foreground": "#f6b"
          }
          },
          {
          "name": "types",
          "scope": [
          "entity.name.type",
          "support.type.primitive",
          "meta.interface",
          "storage.type.class.jsdoc",
          "variable.other.normal.shell",
          "variable.parameter.positional.shell",
          "variable.other.assignment.shell",
          // "support.type.builtin.tsx"
          "support.type.builtin"
          ],
          "settings": {
          "foreground": "#4DB6AC"
          }
          },
          {
          "name": "red test",
          "scope": [
          "storage.type.string",
          "meta.toc-list.id.html",
          "storage.identifier",
          "function.support",
          "function.support.builtin",
          "function.support.core" //
          ],
          "settings": {
          "foreground": "#F00"
          }
          }
          ]
          },
          "workbench.colorCustomizations": {
          "sideBar.border": "#00000000",
          "statusBar.border": "#00000000",
          "terminal.border": "#00000000",
          "panel.border": "#00000000",
          "activityBar.border": "#00000000",
          "activityBar.activeBorder": "#00000000",
          "list.focusAndSelectionOutline": "#00000000",
          "editorIndentGuide.activeBackground1": "#00000000",
          "editorGroupHeader.tabsBackground": "#00000000",
          "sideBar.background": "#00000000",
          "sideBarSectionHeader.border": "#00000000",
          "sideBarSectionHeader.background": "#00000000",
          "editor.background": "#00000000",
          "editorIndentGuide.background1": "#00000000",
          "peekViewEditor.background": "#00000000",
          "peekViewEditorGutter.background": "#00000000",
          "peekViewTitle.background": "#00000000",
          "peekViewResult.background": "#00000000",
          "tab.border": "#00000000",
          "tab.activeModifiedBorder": "#00000000",
          "tab.inactiveModifiedBorder": "#00000000",
          "tab.activeBackground": "#00000000",
          "tab.inactiveBackground": "#00000000",
          "tab.lastPinnedBorder": "#00000000",
          "editorOverviewRuler.border": "#00000000",
          "statusBar.background": "#00000000",
          "statusBar.debuggingBackground": "#00000000",
          "statusBar.noFolderBackground": "#00000000",
          "statusBar.focusBorder": "#00000000",
          "statusBarItem.activeBackground": "#00000000",
          "widget.shadow": "#00000000",
          "focusBorder": "#00000000",
          "tree.indentGuidesStroke": "#00000000",
          "panel.background": "#00000000",
          "activityBar.background": "#00000000",
          "activityBar.dropBorder": "#00000000",
          "peekViewEditor.matchHighlightBackground": "#00000000",
          "peekViewEditor.matchHighlightBorder": "#00000000",
          "titleBar.activeBackground": "#0C1125",
          "titleBar.inactiveBackground": "#0C1125",
          "activityBarBadge.background": "#0C1125",
          "editorWidget.background": "#0C1125",
          "settings.dropdownBackground": "#0C1125",
          "input.background": "#0C1125",
          "badge.background": "#0C1125",
          "activityBar.inactiveForeground": "#01589b99",
          "button.background": "#01589b99",
          "panelTitle.inactiveForeground": "#01589b99",
          "editorLineNumber.foreground": "#01589b99",
          "editorSuggestWidget.border": "#01589b99",
          "list.hoverBackground": "#01589b99",
          "list.inactiveSelectionBackground": "#01589b99",
          "list.activeSelectionBackground": "#01589b99",
          "input.border": "#01589b99",
          "editorLineNumber.activeForeground": "#1979c2",
          "editorWidget.border": "#1979c2",
          "peekView.border": "#1979c2",
          "statusBar.foreground": "#1979c2",
          "activityBar.foreground": "#29B6F6",
          "activityBarBadge.foreground": "#29B6F6",
          "sideBarSectionHeader.foreground": "#29B6F6",
          "sideBarTitle.foreground": "#29B6F6",
          "tab.activeBorder": "#29B6F6",
          "icon.foreground": "#29B6F6",
          "badge.foreground": "#29B6F6",
          "list.focusOutline": "#29B6F6",
          "panelTitle.activeForeground": "#29B6F6",
          "panelTitle.activeBorder": "#29B6F6",
          "titleBar.activeForeground": "#29B6F6",
          "sideBar.foreground": "#81bae6",
          "gitDecoration.modifiedResourceForeground": "#81bae6",
          "gitDecoration.untrackedResourceForeground": "#81bae6",
          "gitDecoration.ignoredResourceForeground": "#81bae6",
          "gitDecoration.addedResourceForeground": "#81bae6",
          "gitDecoration.renamedResourceForeground": "#81bae6",
          "tab.activeBorderTop": "#00000000",
          "editorGroupHeader.tabsBorder": "#00000000"
          }
          };
          };
          };
          };
          }
