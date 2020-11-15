# Changelog

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
