class Sanitize

  # Characters that should be replaced with entities in text nodes.
  ENTITY_MAP = {
    '<' => '&lt;',
    '>' => '&gt;',
#    '"' => '&quot;',
#    "'" => '&#39;'
  }

end