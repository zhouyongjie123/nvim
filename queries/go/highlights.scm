; inherits: go
; 追加规则：Neovim 核心会把 runtime 与 after 下所有 queries/go/highlights.scm 拼接，
; 本文件排在基础查询之后，因此相同节点上这里的捕获优先。

; 内置类型转换 int(x) / string(x) 等：语法上是 call_expression 的 function，
; 基础查询会把它当作函数调用染成浅蓝，这里钉回类型黄
((call_expression
   function: (identifier) @type.builtin)
 (#any-of? @type.builtin
   "bool" "byte" "complex64" "complex128" "error" "float32" "float64"
   "int" "int8" "int16" "int32" "int64" "rune" "string"
   "uint" "uint8" "uint16" "uint32" "uint64" "uintptr" "any"))

; 复合字面量的键 Name: value —— 结构体字段，染成字段橙
; 用锚点 . 限定只取第一个 literal_element，避免把值位置的标识符也染成字段
(keyed_element
  .
  (literal_element
    (identifier) @field))

; 类型位置里的包名（如 *config.ApplicationConfigurationProperties 的 config）
; 基础查询捕获为 @module，但该组没有配色，这里在 highlights.lua 中补上
