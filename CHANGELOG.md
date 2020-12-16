# Changelog

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
