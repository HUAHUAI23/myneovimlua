# TODO List

---

- [X] 为markdown文件设置特定的cmp
- [ ] 利用cmp实现 类似marktext @ 效果  
      参考: <https://github.com/hrsh7th/nvim-cmp/blob/main/doc/cmp.txt>
      cmp.event:on 事件设置为confirm done，cmp完成后 删除 @符号  
      sources[n].keyword_pattern  
      sources[n].trigger_characters &emsp; trigger_characters = { "+", "@" }, 触发 cmp 补全框的字符  
      completion.keyword_pattern ref: <https://github.com/hrsh7th/nvim-cmp/discussions/1403>
- [ ] 参考cmp path源 实现markdown 文件链接预览
- [ ] ctrl-space 键位映射失效，不知道是window terminal终端问题，还是设置问题
- [ ] jumplist problem in markdown and telescope current buffer find
- [ ] learn about neovim runtimepath and packpath
