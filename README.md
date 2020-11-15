# rime-easy-en
Rime / Easy English 可混输的英文输入法

## 安装
[东风破](https://github.com/rime/plum) 安装口令：

``` shell
bash rime-install BlindingDark/rime-easy-en
```

你可以将 easy_en 加入候选列表中，修改 `default.yaml`

``` yaml
schema_list:
  - schema: double_pinyin
  - schema: luna_pinyin_simp
  - schema: easy_en
```

如果想要中英混输效果，以朙月拼音（luna_pinyin）为例，可执行以下命令：

``` shell
bash rime-install BlindingDark/rime-easy-en:customize:schema=luna_pinyin
```

若想更新到最新版，则重复执行安装命令即可。

### 连续输入增强

![](images/continuous-input-enhancement.gif)

连续输入增强功能可以允许你在单独使用 easy-en 时连续输入单词后，选词时在每个单词后自动增加空格。目前由于技术限制，使用该功能后选词调频将无法生效。

连续输入增强功能依托于 [RIME Lua 脚本扩展](https://github.com/hchunhui/librime-lua)，请升级 rime 到最新版以确保可以使用该扩展。
Linux 用户需要安装带有 lua 扩展的 librime 版本，以下是部分发行版的安装方式

- ArchLinux
  ``` shell
  yay -S librime
  ```
  推荐使用 fcitx5 并配合 fcitx5-configtool 在 GUI 下设置开启 lua 插件。

Linux 用户也可以按照[这里的说明](https://github.com/hchunhui/librime-lua#instructions)进行编译安装

分词功能依赖 [wordninja](https://github.com/keredson/wordninja)，这是一个 python 程序，你可以使用 `pip` 来安装它。

``` shell
pip install wordninja
```

#### 安装连续输入增强功能

由于 plum 目前还不能自动引入 lua 脚本，所以在使用连续输入增强之前还需要手动在 rime 配置目录下的 `rime.lua` 文件中添加以下内容，`rime.lua` 文件不存在可手动创建。

``` lua
-- easy_en_enhance_filter: 连续输入增强
-- 详见 `lua/easy_en.lua`
local easy_en = require("easy_en")
easy_en_enhance_filter = easy_en.enhance_filter
```

以上步骤都做好之后重新部署 rime 即可生效。

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

这是因为开启了造句功能而导致的，连续输入 lua 脚本需依靠该功能才能工作（开启 lua 脚本后会自动隐藏这些单词）。  
若是你没有使用连续输入 lua 脚本，又不想看到这些无意义单词，可以在 `easy_en.custom.yaml` 的 `patch` 节点中添加选项以关闭造句功能。  

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

### 疑难

以下是目前未能解决的问题，欢迎讨论！

- 使用连续输入增强则无法调频  
  因目前加空格的实现方案受限于 librime-lua 的技术性限制 [librime-lua#11](https://github.com/hchunhui/librime-lua/issues/11)
- 无法记住用户自造的英文单词  
  没找到原因，欢迎指教
- 调用 python 的速度不够快  
  以后的版本可能会尝试开后台进程避免每次执行都要加载代码

## 感谢

easy_en 原作者 [Patricivs](https://github.com/Patricivs)  

[ECDICT](https://github.com/skywind3000/ECDICT)  

[wordninja](https://github.com/keredson/wordninja)  

YOU!
