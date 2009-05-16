module AutoSanitize
  
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def auto_sanitizes(*args)
      attrs, options = args[-1].is_a?(Hash) ? [args[0...-1], args[-1]] : [args, {}]
      cattr_accessor :sanitization_rules
      self.sanitization_rules ||= {}
      strings = []
      self.content_columns.each { |x| strings << x.name.to_sym if [:string, :text].include?(x.type) }
      attrs = strings if attrs == [:all]
      attrs.each do |attr_name|
        attr_name = attr_name.to_sym
        raise "There is no string attribute named #{attr_name}" unless strings.include?(attr_name)
        self.sanitization_rules[attr_name] = options 
      end
      send :include, InstanceMethods
    end
  end

  module InstanceMethods
    #
    # Go through the sanitization rules. Skip those who have the option :at_assign true,
    # since they are processed when assigned, not at validation time. Process the rest
    # by looking up the attribute name in AutoSanitize::CLEANERS.
    # Apply clean_html or strip_html depending on the lookup, but let :with => :clean|:strip
    # override. Also, if :no_trim is true, don't trim away whitespace. 
    # If :nullify is true, replace a blank value with nil.
    #
    def before_validation
      self.class.sanitization_rules.each do |attrib, opts|
        next if opts[:at_assign] || opts[:leave] || self.respond_to?("#{attrib}_changed?") &&
                                                    !send("#{attrib}_changed?")
        case opts[:with] || (AutoSanitize::CLEANERS.include?(attrib) && :clean) || :strip
        when :clean
          res = clean_html(read_attribute(attrib))
        when :strip
          res = strip_html(read_attribute(attrib))
        else
          raise "Illegal :with option '#{opts[:with]}'" unless opts[:with].is_a?(Hash)
          res = clean_html(read_attribute(attrib), opts[:with])
        end
        res = res.strip unless opts[:no_trim]
        res = nil if opts[:nullify] && res.blank?
        write_attribute(attrib, res)
      end
      true
    end
  end
  
      
  def strip_html(str)
    return '' unless str
    Sanitize.clean(str)
  end
      
  def clean_html(str, cleaner=SANITIZE_BODY)
    return (str || '') if str.blank?
    str = Tidier::TIDIER.clean(str)
    return str if str.blank?
    str.gsub!(/j\s*a\s*v\s*a\s*s\s*c\s*r\s*i\s*p\s*t/i, '') unless str.include?('/javascripts/')
    Sanitize.clean(str, cleaner)
  end
  
end
