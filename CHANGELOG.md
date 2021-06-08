# Changelog

## 0.9.1

### new / fix

* patch  
  - 新增针对 `terra_pinyin` 的特定配置 (fix [#25](https://github.com/BlindingDark/rime-easy-en/issues/25))

## 0.9

### new

* 分词  
  新的 lua 分词模块 [wordninja-rs-lua](https://github.com/BlindingDark/wordninja-rs-lua)  
  在加载速度以及运行速度方面都有所提升  

* 配置  
  - 新增 `easy_en/use_wordninja_rs_lua_module` 配置
  - 新增 `easy_en/use_wordninja_py` 配置
  - 新增 `easy_en/wordninja_rs_lua_module_path` 配置，默认值为 `"/usr/lib/lua/5.4/wordninja.so"`

### breaking change

* 分词  
  - 现在不再默认使用 `wordninja_rs`，而是使用 `wordninja_rs_lua_module`  

## 0.8.2

### new / fix

* patch  
  - 新增针对 `double_pinyin_mspy` 的特定配置 (fix [#22](https://github.com/BlindingDark/rime-easy-en/issues/22))

## 0.8.1

### new

* 配置  
  - 新增 `use_wordninja_rs` 配置，默认值为 `true`
  - 设置 `easy_en/wordninja_rs_path` 的默认值为 `"/usr/bin/wordninja"`

## 0.8

### new

* 分词  
  使用新的快速分词程序 [wordninja-rs](https://github.com/chengyuhui/wordninja-rs)  
  引入配置 `easy_en/wordninja_rs_path` 指定 `wordninja-rs` 的可执行文件路径  
  如不指定此选项，则会使用之前的 [wordninja](https://github.com/keredson/wordninja) 进行分词

## 0.7

### new

* 分词功能  
  通过调用 [wordninja](https://github.com/keredson/wordninja) 来实现  
  引入配置 `easy_en/split_sentence` 控制是否开启分词功能，默认开启

### breaking change

* `append_blank_filter` 现已被替换为 `easy_en_enhance_filter`  
  需要修改 `rime.lua` 中的代码

  ```diff
  -append_blank_filter = easy_en.append_blank_filter
  +easy_en_enhance_filter = easy_en.enhance_filter
  ```
