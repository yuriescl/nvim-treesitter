(line_comment) @comment @spell

[
  (container_doc_comment)
  (doc_comment)
] @comment.documentation @spell

[
  variable: (IDENTIFIER)
  variable_type_function: (IDENTIFIER)
] @variable

parameter: (IDENTIFIER) @variable.parameter

[
  field_member: (IDENTIFIER)
  field_access: (IDENTIFIER)
] @variable.member

; assume TitleCase is a type
([
  variable_type_function: (IDENTIFIER)
  field_access: (IDENTIFIER)
  parameter: (IDENTIFIER)
] @type
  (#lua-match? @type "^%u([%l]+[%u%l%d]*)*$"))

; assume camelCase is a function
([
  variable_type_function: (IDENTIFIER)
  field_access: (IDENTIFIER)
  parameter: (IDENTIFIER)
] @function
  (#lua-match? @function "^%l+([%u][%l%d]*)+$"))

; assume all CAPS_1 is a constant
([
  variable_type_function: (IDENTIFIER)
  field_access: (IDENTIFIER)
] @constant
  (#lua-match? @constant "^%u[%u%d_]+$"))

function: (IDENTIFIER) @function

function_call: (IDENTIFIER) @function.call

exception: "!" @keyword.exception

((IDENTIFIER) @variable.builtin
  (#eq? @variable.builtin "_"))

(PtrTypeStart
  "c" @variable.builtin)

(ContainerDecl
  (ContainerDeclType
    "enum")
  (ContainerField
    (ErrorUnionExpr
      (SuffixExpr
        (IDENTIFIER) @constant))))

field_constant: (IDENTIFIER) @constant

(BUILTINIDENTIFIER) @function.builtin

((BUILTINIDENTIFIER) @keyword.import
  (#any-of? @keyword.import "@import" "@cImport"))

(INTEGER) @number

(FLOAT) @number.float

[
  "true"
  "false"
] @boolean

[
  (LINESTRING)
  (STRINGLITERALSINGLE)
] @string @spell

(CHAR_LITERAL) @character

(EscapeSequence) @string.escape

(FormatSequence) @string.special

(BreakLabel
  (IDENTIFIER) @label)

(BlockLabel
  (IDENTIFIER) @label)

[
  "asm"
  "defer"
  "errdefer"
  "test"
  "opaque"
  "error"
  "const"
  "var"
] @keyword

[
  "struct"
  "union"
  "enum"
] @keyword.type

[
  "async"
  "await"
  "suspend"
  "nosuspend"
  "resume"
] @keyword.coroutine

"fn" @keyword.function

[
  "and"
  "or"
  "orelse"
] @keyword.operator

"return" @keyword.return

[
  "if"
  "else"
  "switch"
] @keyword.conditional

[
  "for"
  "while"
  "break"
  "continue"
] @keyword.repeat

[
  "usingnamespace"
  "export"
] @keyword.import

[
  "try"
  "catch"
] @keyword.exception

[
  "anytype"
  (BuildinTypeExpr)
] @type.builtin

[
  "volatile"
  "allowzero"
  "noalias"
  "addrspace"
  "align"
  "callconv"
  "linksection"
  "pub"
  "inline"
  "noinline"
  "extern"
] @keyword.modifier

[
  "comptime"
  "packed"
  "threadlocal"
] @attribute

[
  "null"
  "unreachable"
  "undefined"
] @constant.builtin

[
  (CompareOp)
  (BitwiseOp)
  (BitShiftOp)
  (AdditionOp)
  (AssignOp)
  (MultiplyOp)
  (PrefixOp)
  "="
  "*"
  "**"
  "->"
  ".?"
  ".*"
  "?"
] @operator

[
  ";"
  "."
  ","
  ":"
  "=>"
] @punctuation.delimiter

[
  ".."
  "..."
] @punctuation.special

[
  "["
  "]"
  "("
  ")"
  "{"
  "}"
] @punctuation.bracket

(Payload
  "|" @punctuation.bracket)

(PtrPayload
  "|" @punctuation.bracket)

(PtrIndexPayload
  "|" @punctuation.bracket)

(PtrListPayload
  "|" @punctuation.bracket)

(ParamType
  (ErrorUnionExpr
    (SuffixExpr
      variable_type_function: (IDENTIFIER) @type)))
