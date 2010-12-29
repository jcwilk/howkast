class String
  def modulize
    gsub('__','/').
    gsub(/\/(.?)/){ "::#{$1.upcase}" }.
    gsub(/(?:_+|-+)([a-z])/){ $1.upcase }.
    gsub(/(\A|\s)([a-z])/){ $1 + $2.upcase }
  end
  
  def parse
    rfc2822 = "(#{Time::RFC2822_DAY_NAME.join('|')}, )? \d{1,2} #{Time::RFC2822_MONTH_NAME.join('|')} \d{4,4} \d{2,2}:\d{2,2}:\d{2,2} [+-]\d{4,4}"
    ansi    = "#{Time::RFC2822_DAY_NAME.join('|')} #{Time::RFC2822_MONTH_NAME.join('|')} +\d{1,2} \d{2,2}:\d{2,2}:\d{2,2} [A-Z]{3,3} \d{4,4}"
    case self
    when /^[+-]?\d+$/
      to_i
    when /^[+-]?\d+\.\d+/
      to_f
    when /^(true|false)$/i
      self =~ /^true$/i ? true : false
    when /^#{rfc2822}|#{ansi}$/
      Time.parse(self) rescue self
    else
      self
    end
  end
end
