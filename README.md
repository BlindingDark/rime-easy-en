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

## 卸载

1. 删除位于 `plum/package/` 下的 easy_en git 仓库
1. 删除 `default.yaml` schema_list 中的 easy_en
1. 删除 `rime` 用户文件夹下 easy_en 开头的文件
1. 如果使用了混输，还需要删除对应方案的 `custom.yaml` 下 `__patch` 中的如下内容
   ```yaml
   # Rx: BlindingDark/rime-easy-en:customize:schema=double_pinyin {
     - patch/+:
         __include: easy_en:/patch
   # }
   ```
1. 重新部署 rime

## 问题

### 混输时出现带有☯图案的英文

这个特性或许会方便双拼用户输入字典中不存在的英文，参见 [#2](https://github.com/BlindingDark/rime-easy-en/issues/2)  
你可以通过 `patch` 补丁来禁用这一特性。例如你不想在 luna_pinyin 中显示不在词典中的英文单词，就可以像这样，在 `luna_pinyin.custom.yaml` 的 `patch` 节点中添加关闭选项  

```yaml
patch:
  easy_en/enable_sentence: false
```

### 英文模式下无法连续输入英文单词

在单独把 easy_en 作为主要输入模式（非混输模式）时，造句功能默认是关闭的。  
若开启了造句功能，则会导致无意义的词出现在候选列表中，好处是可以连续输入英文单词，不过英文单词之间不会自动加上空格。  
你可以在 `easy_en.custom.yaml` 的 `patch` 节点中添加开启造句功能的选项。  

```yaml
patch:
  translator/enable_sentence: true
```

### 疑难

以下是目前未能实现的功能，欢迎分享你的办法！

- 连续输入英文单词时自动在单词之间加入空格
- 记住用户自造的英文单词

## 感谢

easy_en 原作者 [Patricivs](https://github.com/Patricivs)

[ECDICT](https://github.com/skywind3000/ECDICT)
