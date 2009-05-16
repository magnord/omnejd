module AutoSanitize
  
  CLEANERS =  [:body, :description, :comment]
  
          
  SANITIZE_BODY = {
    :elements => [
      'a', 'b', 'blockquote', 'br', 'caption', 'cite', 'code', 'col',
      'colgroup', 'dd', 'dl', 'dt', 'em', 'i', 'img', 'li', 'ol', 'p', 'pre',
      'q', 'small', 'strike', 'strong', 'sub', 'sup', 'table', 'tbody', 'td',
      'tfoot', 'th', 'thead', 'tr', 'u', 'ul',
      'object', 'param', 'embed'],

    :attributes => {
      'a'          => ['href', 'title'],
      'blockquote' => ['cite'],
      'col'        => ['span', 'width'],
      'colgroup'   => ['span', 'width'],
      'img'        => ['align', 'alt', 'height', 'src', 'title', 'width'],
      'ol'         => ['start', 'type'],
      'q'          => ['cite'],
      'table'      => ['summary', 'width'],
      'td'         => ['abbr', 'axis', 'colspan', 'rowspan', 'width'],
      'th'         => ['abbr', 'axis', 'colspan', 'rowspan', 'scope',
                       'width'],
      'ul'         => ['type'],
      'object'     => ['width', 'height'],
      'param'      => ['name', 'value'],
      'embed'      => ['src', 'type', 'allowscriptaccess', 'allowfullscreen', 'width', 'height']
    },

    :protocols => {
      'a'          => {'href' => ['http', 'https', 'mailto', :relative]},
      'blockquote' => {'cite' => ['http', 'https', :relative]},
      'img'        => {'src'  => ['http', 'https', :relative]},
      'q'          => {'cite' => ['http', 'https', :relative]}
    }
  }

end
