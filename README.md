# moni-chrome.nvim

`moni-chrome` is an amber-on-black Neovim colorscheme inspired by the amber
display option shipped with the 1985 Leading Edge Model D.

Requires Neovim 0.12 or newer.

<img width="1168" height="356" alt="image" src="https://github.com/user-attachments/assets/33e0ec82-4b5a-4ec9-866f-dbb5744b2927" />
<p align="center"><img width="400" height="278" alt="image" src="https://github.com/user-attachments/assets/fb8a489f-2588-4cd0-a024-248adb6c4d7e" /></p>


## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "cosgroveb/moni-chrome.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
}
```

`setup()` applies the colorscheme immediately. Without a plugin manager:

```vim
colorscheme moni-chrome
```

## Configuration

```lua
require("moni-chrome").setup({
  transparent = false,
  dim_inactive_windows = true,
  on_colors = function(colors)
    colors.phosphor = "#ffaa33"
  end,
  on_highlights = function(highlights, colors)
    highlights.Comment = { fg = colors.phosphor_dim, italic = false }
  end,
})
```

- `transparent` removes backgrounds and overrides inactive dimming.
- `dim_inactive_windows` dims inactive windows unless transparent.
- `on_colors` edits colors before highlights and terminal colors.
- `on_highlights` edits highlights before application.

Callbacks run once per theme build. Their return values are ignored.

## Palette

`on_colors` receives these Moni Chrome palette keys:

| Theme token | Value |
| --- | --- |
| `screen` | `#050301` |
| `screen_lifted` | `#0a0602` |
| `screen_solid` | `#050301` |
| `screen_lifted_solid` | `#0a0602` |
| `phosphor` | `#ff9e2c` |
| `phosphor_soft` | `#f08a22` |
| `phosphor_dim` | `#c66a1a` |
| `phosphor_faint` | `#b85d14` |
| `phosphor_bright` | `#ffb156` |
| `phosphor_ghost` | `#794110` |
| `glow_low` | `#170e04` |
| `glow_medium` | `#281907` |
| `glow_high` | `#3c250b` |
| `none` | `NONE` |

## Integrations

Supports GitSigns, Telescope, nvim-cmp, WhichKey, Noice, Flash,
TreesitterContext, and Lualine.

```lua
require("lualine").setup({
  options = { theme = "moni-chrome" },
})
```

## Limitations

The terminal palette is monochrome, so programs that rely on hue alone may be
harder to read.

## Tests

```sh
nvim --headless -u NONE -i NONE --noplugin -l tests/minit.lua
```
