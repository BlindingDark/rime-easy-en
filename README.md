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

## 感谢

easy_en 原作者 [Patricivs](https://github.com/Patricivs)
