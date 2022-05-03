# Oxidizer.sh

![build](https://img.shields.io/github/workflow/status/ivaquero/oxidizer.sh/CI.svg)
![code size](https://img.shields.io/github/languages/code-size/ivaquero/oxidizer.svg)
![repo size](https://img.shields.io/github/repo-size/ivaquero/oxidizer.svg)
![license](https://img.shields.io/github/license/ivaquero/oxidizer.sh)
基于 Rust 工具链的极简 & 可扩展 Dotfile 管理方案（欢迎 PR 和 Fork）

<p align="left">
<a href="README.md">English</a> |
<a href="README-CN.md">简体中文</a>
</p>

来一起氧化开发环境吧!

![oxidizer](https://raw.githubusercontent.com/ivaquero/blog-bio/master/tutorials/images/cmd/oxidizer.png)

## 1. 从这里开始

针对 macOS / Linux 操作系统

```bash
export OXIDIZER=$HOME/oxidizer

git clone --depth=1 https://github.com/ivaquero/oxidizer.sh.git $OXIDIZER
bash $OXIDIZER/install.sh
```

```bash
export BREW_CN=1
```

针对 Windows 操作系统

```powershell
# define path for Oxidizer
$env:OXIDIZER = "$env:USERPROFILE\oxidizer"

git clone --depth=1 https://github.com/ivaquero/oxidizer.sh.git $env:OXIDIZER
. $env:OXIDIZER\install.ps1
```

- 对中国大陆用户，可设置 `BREW_CN` 变量来下载安装 Homebrew：

安装之后，您可以在`custom.sh`中个性化您的系统环境（请参考 `demo-custom.sh`），通过一下命令打开`custom.sh`

```bash
ef ox
```

可使用 `upox` 命令来更新 Oxidizer

## 2. Oxidizer 的主要目标

- 跨平台（主要基于 Rust 工具链）
- 最少依赖 & 最少安装
- 可扩展架构
- 统一接口 & 丝滑操作
- 超级快！（当前载入时间 < 0.50 秒）

## 3. 氧化进度

### 3.1. 命令行替换（推荐以下所有）

☑️ 表示默认安装

- [x] 使用 `bat` 替换 `cat`
- [x] 使用 `fd` 替换 `find`
- [x] 使用 `gitui` 替换 `lazygit`
- [x] 使用 `ls --tree` 替换 `tree`
- [x] 使用 `lsd` 替换 `ls`
- [x] 使用 `ripgrep` 替换 `grep`
- [x] 使用 `sd` 替换 `sed`
- [x] 使用 `tealdeer` 替换 `tldr` 和 `man`
- [x] 使用 `zoxide` 替换 `cd` 和 `z.lua`
- [x] 使用 `zellij` 替换 `tmux`（暂不支持 Windows）
- [ ] 使用 `bottom` 替换 `top` 和 `htop`
- [ ] 使用 `dust` 替换 `du`
- [ ] 使用 `tokei` 替换 `cloc`

### 3.2. 软件替换

- [ ] 使用 `Alacritty` 替换 `iTerm2` 和 `Windows Terminal`（非必需，但强烈推荐）
- [ ] 使用 `Helix` 替换 `NeoVim`
- [ ] 使用 `Deno` 替换 `Node`
- [ ] 使用 `Nushell` 替换 `Zsh` or `Powershell`

> 对 `Nushell`：其 nu 语言比较新，会增加学习成本。另外， nu 脚本目前没有任何检查器和格式化器，编写并不方便。

### 3.3. 其他实用的 Rust 工具

- [x] `pueue`：命令行并行任务管理器
- [x] `hyperfine`：命令行性能测试工具
- [ ] `delta`：`git diff` 渲染器
- [ ] `mdbook`

### 3.4. 插件总结

| 索引 |  插件   | Linux | macOS | Windows | 必需？ |
| :--: | :-----: | :---: | :---: | :-----: | :----: |
|  1   |  Brew   |  ✅   |  ✅   |   ❌    |   ✅   |
|  2   |  Scoop  |  ❌   |  ❌   |   ✅    |   ✅   |
|  3   | Utility |  ✅   |  ✅   |   ✅    |   ✅   |
|  4   | System  | ✅[¹] |  ✅   |   ✅    |   ✅   |
|  5   |  Pueue  |  ✅   |  ✅   |   ✅    |   ✅   |
|  6   |   Git   |  ✅   |  ✅   |   ✅    |        |
|  7   |  Conan  |  ✅   |  ✅   |   ✅    |        |
|  8   |  Conda  |  ✅   |  ✅   |   ✅    |        |
|  9   | Docker  |  ✅   |  ✅   |   ✅    |        |
|  10  |  Julia  |  ✅   |  ✅   |   🕒    |        |
|  11  |  Node   |  ✅   |  ✅   |   ✅    |        |
|  12  |  Rust   |  ✅   |  ✅   |   ✅    |        |
|  13  | TeXLive |  ✅   |  ✅   |   ✅    |        |
|  14  | VS Code |  ✅   |  ✅   |   ✅    |        |
|  15  | Formats |  🕒   |  🕒   |   🕒    |        |
|  16  | Widgets |  🕒   |  🕒   |   🕒    |        |
|  17  | Zellij  |  ✅   |  ✅   |   ❌    |        |
|  18  | NeoVim  |       |       |         |        |
|  19  |  Helix  |       |       |         |        |

✅：完整功能
🚧：部分功能
🕒：基础功能，有待补充
❌：不存在

> [¹]：目前在 Linux 只提供 Ubuntu 的相关快捷操作

Oxidizer 通过 Homebrew 或 Scoop 管理包和软件，以绕过管理员权限的要求。

对 Linux 用户，可以尝试通过添加 [Hombrew-Linux](https://github.com/ivaquero/homebrew-linux/) 来安装 GUI 应用。

## 4. 文件管理

![design](https://raw.githubusercontent.com/ivaquero/blog-bio/master/tutorials/images/cmd/oxidizer-design.png)

- `ff`
  - 通过 `source` 刷新
- `ef`
  - 通过 `$EDITOR` 编辑（ 默认：VSCode ）
- `bf`
  - 通过 `bat`/`cat` 浏览文件
  - 文件夹：通过 `lsd`/`ls` 浏览
- `ipf`
  - 文件：在 `$Oxygen` 中覆盖对应的 `$Element` 文件配置
- `epf`
  - 文件：在 `$Element` 中覆盖对应的 `$Oxygen` 文件配置

例如，当你想编辑 `~/.zshrc`，键入 `ef zs`。

当你使用 `epf zs`，`~/.zshrc` 会被复制并保存到 `$BACKUP/shell` 文件夹。其中，`$BACKUP` 是可以在 `$OXIDIZER/custom.sh` 中自定义的备份路径。通过 `epf ox` 即可轻松打开 `custom.sh` 文件。

下表展示了每个配置文件的缩写。

|    来源    |  缩写  |      对应文件       |
| :--------: | :----: | :-----------------: |
|  oxidizer  |  `ox`  |     `custom.sh`     |
|    zsh     |  `zs`  |      `.zshrc`       |
| powershell |  `ps`  |    `Profile.ps1`    |
| alacritty  |  `al`  |   `alacritty.yml`   |
|   aria2    |  `ar`  |    `aria2.conf`     |
|   conda    |  `c`   |     `.condarc`      |
|    git     |  `g`   |    `.gitconfig`     |
|   conan    |  `cn`  |      `default`      |
|   conan    | `cnr`  |    `remote.json`    |
|   helix    |  `hx`  |    `config.toml`    |
|   helix    | `hxl`  |  `languages.toml`   |
|   julia    | `jls`  |    `startup.jl`     |
|   julia    | `jlp`  |   `Project.toml`    |
|   julia    | `jlm`  |   `Manifest.toml`   |
|   pueue    |  `pu`  |     `pueue.yml`     |
|   pueue    | `pua`  | `pueue_aliases.yml` |
|   cargo    |  `cg`  |        `env`        |
|   cargo    | `cg_`  |      `.cargo`       |
|   neovim   |  `vi`  |     `init.lua`      |
|   neovim   | `vip`  |    `plugins.lua`    |
|   neovim   | `nvv`  |     `init.vim`      |
|    vim     |  `vi`  |      `.vimrc`       |
|   vscode   |  `vs`  |   `settings.json`   |
|   vscode   | `vsk`  | `keybindings.json`  |
|   vscode   | `vss_` |     `snippets`      |
|   winget   |  `w`   |   `settings.json`   |
|   zellij   |  `zj`  |    `config.yaml`    |
|   zellij   | `zjl_` |      `layouts`      |

## 5. 软件管理

- `init_*`
  - 文件：在 `$Oxygen/install` 安装配置文件
- `up_*`
  - 文件：在 `$BACKUP` 文件夹中更新系统配置文件
- `back_*`
  - 文件：在 `$BACKUP` 文件夹中备份文件

### 5.1. VSCode

### 5.2. NeoVim

## 6. 包管理

Oxidizer 致力于为各个包管理器提供统一的接口，以减轻敲击和记忆负担。

|        |   action    | brew [b] | scoop [s] | conda [c] | npm [n] | cargo [cg] | rustup [rs] | julia [jl] | conan [cn] | tlmgr [tl] |
| :----: | :---------: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :--------: | :--------: |
|  `*h`  |    help     |    ✅    |           |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*is`  |   install   |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*us`  |  uninstall  |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*up`  |   update    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*ups` | update self |    ✅    |    ✅     |           |         |            |             |            |            |     ✅     |
| `*ls`  |    list     |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*lv`  |   leaves    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |     ✅     |            |            |
| `*sc`  |   search    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |            |     ✅     |            |
| `*cl`  |    clean    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |     ✅     |            |            |
| `*if`  |    info     |    ✅    |    ✅     |    ✅     |   ✅    |            |             |            |     ✅     |     ✅     |
| `*st`  |   status    |    ✅    |    ✅     |           |   ✅    |            |             |     ✅     |            |            |
| `*ck`  |    check    |    ✅    |    ✅     |           |   ✅    |     ✅     |     ✅      |            |            |     ✅     |
| `*pn`  |     pin     |    ✅    |           |           |         |            |             |     ✅     |            |            |
| `*upn` |    unpin    |    ✅    |           |           |         |            |             |     ✅     |            |            |
| `*dp`  |   depends   |    ✅    |           |    ✅     |         |            |             |            |            |            |
| `*dpt` | depend tree |    ✅    |           |    ✅     |         |            |             |            |            |            |

特别地，Oxidizer 提供两组后缀为`p`的实验性函数，用于并行安装和下载软件包

- brew：`bisp`, `biscp`, `bupp`, `bupap`
- scoop：`sisp`, `supp`

例如，当需要安装 2 个及以上的包时，可以使用 `bisp [pkg1] [pkg1]` 代替 `bis [pkg1] [pkg1]`，you can use 进行并行下载安装。

同理，`biscp`, `bupp`, `bupap` 分别为 `bisc`, `bup`, `bupa` 的并行版本。

使用并行功能前，需要启动 pueue 服务

```bash
# All OS
pueued -d
# or macOS / Linux
bss pu
```

一些包管理器还有项目管理功能

|       | action  | brew [b] | conda [c] | npm [n] | cargo [cg] | rustup [rs] | julia [jl] | conan [cn] |
| :---: | :-----: | :------: | :-------: | :-----: | :--------: | :---------: | :--------: | :--------: |
| `*ii` |  init   |    ✅    |    ✅     |   ✅    |     ✅     |             |            |     ✅     |
| `*b`  |  build  |          |           |         |     ✅     |             |     ✅     |     ✅     |
| `*r`  |   run   |          |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |            |
| `*e`  |  edit   |    ✅    |           |   ✅    |            |             |            |            |
| `*ts` |  test   |    ✅    |           |   ✅    |     ✅     |             |     ✅     |     ✅     |
| `*pb` | publish |          |           |   ✅    |     ✅     |             |            |            |

部分快捷命令被包含在对应的系统扩展中

- `zsh-macos` [zsm]：自启动，包含 `mas`
- `zsh-ubuntu` [zsub]：包含 `apt`
- `pwsh-windows` [pswd]：自启动，包含 `winget`, `wsl`·

|        |   action    | apt [ub] | winget [app] | wsl [wl] | mas [app] |
| :----: | :---------: | :------: | :----------: | :------: | :-------: |
|  `*h`  |    help     |    ✅    |      ✅      |          |    ✅     |
| `*is`  |   install   |    ✅    |      ✅      |    ✅    |    ✅     |
| `*us`  |  uninstall  |    ✅    |      ✅      |          |    ✅     |
| `*up`  |   update    |    ✅    |      ✅      |          |    ✅     |
| `*ups` | update self |    ✅    |              |          |           |
| `*ls`  |    list     |    ✅    |      ✅      |    ✅    |           |
| `*lv`  |   leaves    |          |              |          |           |
| `*sc`  |   search    |    ✅    |              |          |    ✅     |
| `*cl`  |    clean    |    ✅    |              |          |           |
| `*if`  |    info     |    ✅    |      ✅      |          |    ✅     |
| `*st`  |   status    |          |              |          |    ✅     |
| `*ck`  |    check    |    ✅    |              |          |           |
| `*pn`  |     pin     |          |              |          |           |
| `*upn` |    unpin    |          |              |          |           |
| `*dp`  |   depends   |    ✅    |              |          |           |
| `*dpt` | depend tree |          |              |          |           |

### 6.1. Homebrew 管理

- [x] 使用 `aria2` 下载 brew cask
- [x] 使用预下载器安装 Homebrew Casks

- `bris`：brew reinstall 重装
- `bup`：brew upgrade 更新

**前缀 `c` 是一个标志用来严格限制 brew 命令只针对的 casks 操作**

- `bisc`：安装 cask
- `brisc`：重装 cask
- `bupc`：升级 cask

后缀 `a` 是 `all` 的简写，用来使 brew 升级每个 cask（包括含有 `auto_update` 的 cask）

- `bupa`：brew upgrade --greedy

- `bdl`：使用 `aria2` 下载 brew cask
  - `$1`：cask name
- `brp`：适用于下载文件替换缓存中的 brew cask
  - `$1`：cask name
- `bmr`：using brew mirror 使用 brew 镜像
- `bmrq`：reset brew git source to official repositories 重置 brew 到官方源

### 6.2. Conda 环境管理

请注意，Conda 插件基于 `mamba` 和 `conda-tree` 包，需要预先安装

```bash
conda install -c conda-forge mamba conda-tree
```

除了上面[[6. 包管理]]提及的 Conda 命令，Conda 插件还提供了 Conda 环境管理的快捷命令，均以 `ce` 开头

- `ceat`：激活环境
  - 变量长度 = 0：激活 `环境`
  - 变量长度 = 1 或 2：激活 `custom.sh` 中的预定义环境 `Conda_Env`
  - 变量长度 > 2：激活指定环境
- `cerat`：重新激活环境，使用同 `ceat`
- `ceq`：退出环境
- `cerm`：删除环境，使用同 `ceat`，但不会删除 `base` 环境
- `cesd`：更改 conda-forge 子目录
  - `i`：使用 `x86_64`（M1 罗塞塔转译） 环境
  - 非 `i`：使用 `arm64` 环境
- `ceep`：导出环境信息，同 `conda env export environment`

## 7. 项目 & 任务管理

|       |   action    | git [g] | docker <br> container [dkc] | docker <br> image [dki] | lima [lm] | pueue [pu] | brew <br> services [bs] |
| :---: | :---------: | :-----: | :-------------------------: | :---------------------: | :-------: | :--------: | :---------------------: |
| `*h`  |    help     |   ✅    |                             |                         |    ✅     |     ✅     |           ✅            |
| `*ii` |    init     |   ✅    |                             |                         |           |            |                         |
| `*df` |    diff     |   ✅    |             ✅              |                         |           |            |                         |
| `*cl` |    clean    |   ✅    |             ✅              |                         |    ✅     |     ✅     |           ✅            |
| `*ls` |    list     |         |             ✅              |           ✅            |    ✅     |            |           ✅            |
| `*st` |   status    |   ✅    |                             |                         |           |     ✅     |                         |
| `*s`  |    start    |         |             ✅              |                         |    ✅     |     ✅     |           ✅            |
| `*rs` |   restart   |         |             ✅              |                         |           |     ✅     |           ✅            |
| `*pa` |    pause    |         |             ✅              |                         |           |     ✅     |                         |
| `*q`  | kill / stop |         |             ✅              |                         |    ✅     |     ✅     |           ✅            |
| `*rt` |    reset    |         |                             |                         |    ✅     |     ✅     |                         |
| `*a`  |     add     |   ✅    |                             |                         |           |     ✅     |                         |
| `*rm` |   remove    |         |             ✅              |           ✅            |    ✅     |     ✅     |                         |
| `*e`  |    edit     |         |                             |                         |    ✅     |     ✅     |                         |
| `*pl` |    pull     |   ✅    |                             |           ✅            |           |            |                         |
| `*ps` |    push     |   ✅    |                             |           ✅            |           |            |                         |
| `*if` |    info     |         |             ✅              |                         |    ✅     |            |           ✅            |

### 7.1. Git

- [x] 删除 `.gitignore` 中的忽略文件 : `gig`
- [x] 查找 git 产生的大体积文件 `gjk`
- [ ] 集成 `git filter-repo` 命令
  - [x] 根据文件大小清理 `gcl -s`
  - [x] 根据 id 清理 `gcl -i`
  - [x] 根据路径清理 `gcl -p`

### 7.2. Docker

### 7.3. Pueue

### 7.4. Homebrew Services

## 8. 工具管理

### 8.1. Zellij

- [x] 预定义的界面
- [x] 集成 Alacritty
  - [x] 光标快捷键
  - [x] 窗口快捷键
  - [x] 分屏快捷键

### 8.2. Formats

- [x] 转换 markdown
  - [x] 转换至含有 Unicode 的 PDF（中文）

```bash
mdto [文件名] [格式]
```

### 8.3. Widgets

- [x] 天气插件（使用 `wttr/in`）

## 9. 系统管理

### 9.1. macOS

- `update`：更新系统
- `clean`：
  - `clean`：清理垃圾
  - `clean bdl`：清理 homebrew 下载文件
  - `clean log`：清理日志
  - `clean cc`：清理缓存
- `allow`：允许运行非官方来源 App

### 9.2. Linux

## 10. 自定义插件

## 11. 致谢

- [Mario Catuogno's Clean-macOS](https://github.com/MarioCatuogno/Clean-macOS）
- [Mike McQuaid's dotfiles](https://github.com/MikeMcQuaid/dotfiles）

## 12. 许可

这个项目在 MIT 许可下发布
