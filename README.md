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

## 感谢

easy_en 原作者 [Patricivs](https://github.com/Patricivs)

[ECDICT](https://github.com/skywind3000/ECDICT)
