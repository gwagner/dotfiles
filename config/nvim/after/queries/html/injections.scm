;extends
(
  document (text) @injection.content
  (#match? @injection.content "^---")
  (#set! injection.language "yaml")
)
