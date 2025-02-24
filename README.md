# rime-easy-en
Rime / Easy English 可混输的英文输入法

## 安装

### 使用 plum 安装 easy_en

[东风破](https://github.com/rime/plum) 安装口令：

``` shell
bash rime-install BlindingDark/rime-easy-en
```

安装完毕后，你就可以将 easy_en 加入候选方案中使用了

``` yaml
schema_list:
  - schema: double_pinyin
  - schema: luna_pinyin_simp
  - schema: easy_en # 添加英文输入法
```

如果想要中英混输效果，以朙月拼音（luna_pinyin）为例，可执行以下命令：

``` shell
bash rime-install BlindingDark/rime-easy-en:customize:schema=luna_pinyin
```

若想更新到最新版，则重复执行安装命令即可。

### 连续输入增强

![](images/continuous-input-enhancement.gif)

连续输入增强功能可以允许你在单独使用 easy_en 时连续输入单词后，选词时在每个单词后自动增加空格。目前由于技术限制，使用该功能后选词调频将无法生效。  

连续输入增强功能依托于 [RIME Lua 脚本扩展](https://github.com/hchunhui/librime-lua)，请升级 rime 到最新版以确保可以使用该扩展。  
Linux 用户需要安装带有 lua 扩展的 librime 版本，以下是部分发行版的安装方式

- ArchLinux
  ``` shell
  yay -S librime
  ```

Linux 用户也可以按照[这里的说明](https://github.com/hchunhui/librime-lua#instructions)进行编译安装带有 lua 扩展的 librime。  

#### 安装分词程序

目前有三种分词程序

##### lua native module

**注意 Windows 系统只能使用这种方式进行分词**

easy_en 可以使用 [wordninja-rs-lua](https://github.com/BlindingDark/wordninja-rs-lua) 进行分词。  
以下是部分发行版的安装方式

- ArchLinux (AUR)
  ``` shell
  yay -S wordninja-rs-lua
  ```

你也可以去项目的 [release](https://github.com/BlindingDark/wordninja-rs-lua/releases) 页面下载编译好的程序，或者参照项目说明进行手动编译。  
目前 Windows 用户应下载 `wordninja_windows_32_lua53.dll`，然后将下载到的文件重命名为 `wordninja.dll`。  

接下来需要在 `easy_en.custom.yaml` 的 `patch` 节点中添加 `easy_en/wordninja_rs_lua_module_path` 选项，以指定程序路径（不指定时的默认路径为 `/usr/lib/lua/5.4/wordninja.so`）  
然后添加 `easy_en/use_wordninja_rs_lua_module` 选项开启分词  
注意，Windows 系统下配置路径也应该使用 `/` 而不应该使用 `\` 作为路径分隔符  

``` yaml
patch:
  easy_en/use_wordninja_rs_lua_module: true
  easy_en/wordninja_rs_lua_module_path: "/SOME/PATH/wordninja.so"
```

限于 rime 目前的限制，lua native module 还无法正确加载 lua 链接库，导致无法正确运行，下面是临时的解决方案  

* Linux  
  启动输入法时添加 `LD_PRELOAD` 环境变量，如
  ``` shell
  LD_PRELOAD=/usr/lib/liblua5.4.so fcitx5
  ```

* Windows  
  将 `lua53.dll` 解压到 weasel 目录（右键点击 rime 托盘后，选择 `程序文件夹` 即可打开 weasel 目录）  
  你可以点击[这里](https://sourceforge.net/projects/luabinaries/files/5.3.6/Windows%20Libraries/Dynamic/lua-5.3.6_Win32_dllw6_lib.zip/download)下载，解压后即可获取到 `lua53.dll`  

##### wordninja rust

easy_en 可以使用 [wordninja-rs](https://github.com/chengyuhui/wordninja-rs) 进行分词。  
以下是部分发行版的安装方式

- ArchLinux (AUR)
  ``` shell
  yay -S wordninja-rs
  ```

你也可以去项目的 [release](https://github.com/chengyuhui/wordninja-rs/releases) 页面下载编译好的程序，或者参照下面的步骤进行手动编译  

``` shell
git clone --depth=1 https://github.com/chengyuhui/wordninja-rs
cd wordninja-rs
cargo build --release
```

编译完毕之后， 当前目录下的 `target/release/wordninja` 即为相应的可执行程序。  

接下来需要在 `easy_en.custom.yaml` 的 `patch` 节点中添加 `easy_en/wordninja_rs_path` 选项，以指定程序路径（不指定时的默认路径为 `/usr/bin/wordninja`）  
然后添加 `easy_en/use_wordninja_rs` 选项开启分词  
注意，Windows 系统下配置路径也应该使用 `/` 而不应该使用 `\` 作为路径分隔符  

``` yaml
patch:
  easy_en/use_wordninja_rs: true
  easy_en/wordninja_rs_path: "/SOME/PATH/wordninja-rs/target/release/wordninja"
```

##### wordninja (python)

easy_en 可以使用 [wordninja](https://github.com/keredson/wordninja) 进行分词。  
你可以使用 `pip` 来安装它  

``` shell
pip install wordninja
```

接下来可以在 `easy_en.custom.yaml` 的 `patch` 节点中添加 `easy_en/use_wordninja_py` 选项开启分词  

``` yaml
patch:
  easy_en/use_wordninja_py: true
```

注意，wordninja (python) 要比前两种方式慢上很多倍。

#### 安装连续输入增强功能

由于 plum 目前还不能自动引入 lua 脚本，所以在使用连续输入增强之前还需要手动在 rime 配置目录下的 `rime.lua` 文件中添加以下内容，`rime.lua` 文件不存在可手动创建。

``` lua
-- easy_en_enhance_filter: 连续输入增强
-- 详见 `lua/easy_en.lua`
local easy_en = require("easy_en")
easy_en_enhance_filter = easy_en.enhance_filter
```

以上步骤都做好之后重新部署 rime 即可生效。

#### 不使用连续输入增强

你可以在 `easy_en.custom.yaml` 的 `patch` 节点中添加选项以关闭连续输入增强功能。  

```yaml
patch:
  engine/filters:
    - uniquifier
```

在某些系统上，若不按照类似上述方式手动关闭连续输入增强，即使没有引入 lua 脚本也会导致 easy_en 无法正常使用。

### 手动安装 easy_en

本节内容仅为手动安装所需要进行的步骤，如果你使用 `plum` 进行安装，则不需要进行下面的操作。  
连续输入增强的安装方式请参照上面的说明。  

将 `easy_en.schema.yaml` `easy_en.dict.yaml` `easy_en.yaml` `lua/easy_en.lua` 复制到 rime 配置目录。  

如果想要中英混输效果，以朙月拼音（luna_pinyin）为例，需要在 `luna_pinyin.custom.yaml` 文件中的 `patch` 下添加 `__include: easy_en:/patch`，效果如下  

``` yaml
patch:
  __include: easy_en:/patch
```

某些特殊方案需要指定方案名称，如微软双拼  

``` yaml
patch:
  __include: easy_en:/patch_double_pinyin_mspy
```

以下是需要指定名称的方案  

- 微软双拼 `easy_en:/patch_double_pinyin_mspy`
- 地球拼音 `easy_en:/patch_terra_pinyin`

## 卸载

1. 删除位于 `plum/package/` 下的 easy_en git 仓库
1. 删除 `default.yaml` schema_list 中的 easy_en
1. 删除 `rime` 配置目录下 easy_en 开头的文件
1. 如果使用了混输，还需要删除对应方案的 `custom.yaml` 下 `__patch` 中的如下内容
   ```yaml
   # Rx: BlindingDark/rime-easy-en:customize:schema=double_pinyin {
     - patch/+:
         __include: easy_en:/patch
   # }
   ```
1. 如果使用了连续输入增强，还需要删除 `rime` 配置目录下的 `lua/easy_en.lua`，以及 `rime.lua` 中添加的脚本内容
1. 重新部署 rime

## 问题

### 混输时出现带有☯图案的英文

这个特性或许会方便双拼用户输入字典中不存在的英文，参见 [#2](https://github.com/BlindingDark/rime-easy-en/issues/2)  
你可以通过 `patch` 补丁来禁用这一特性。例如你不想在 luna_pinyin 中显示不在词典中的英文单词，就可以像这样，在 `luna_pinyin.custom.yaml` 的 `patch` 节点中添加关闭选项  

```yaml
patch:
  easy_en/enable_sentence: false
```

### 未使用连续输入增强功能时，英文模式下出现带有☯图案的无意义单词

这是因为开启了造句功能而导致的，连续输入增强需依靠该功能才能工作（开启连续输入增强后会自动隐藏这些单词）。  
若是你没有使用连续输入增强，又不想看到这些无意义单词，可以在 `easy_en.custom.yaml` 的 `patch` 节点中添加选项以关闭造句功能。  

```yaml
patch:
  translator/enable_sentence: false
```

### 连续输入增强功能太卡/如何关闭连续输入增强的分词功能

你可以在 `easy_en.custom.yaml` 的 `patch` 节点中添加选项以关闭分词功能。  

```yaml
patch:
  easy_en/split_sentence: false
```

### 混输时英文单词排的太靠后

你可以通过调整 `initial_quality` 选项来调节英文单词在候选项中显示的位置。  
例如你想调整 luna_pinyin 的英文单词排序位置，就可以在 `luna_pinyin.custom.yaml` 中做如下设置  

```yaml
patch:
  easy_en/initial_quality: 0
```

easy_en 对此项的默认设置为 -1，你可以尝试 0 到 0.5 左右的数值。数值**越大**，英文单词出现的就**越靠前**。  

## 感谢

easy_en 原作者 [Patricivs](https://github.com/Patricivs)  

[ECDICT](https://github.com/skywind3000/ECDICT)  

[wordninja-rs](https://github.com/chengyuhui/wordninja-rs)  

[wordninja](https://github.com/keredson/wordninja)  

YOU!
