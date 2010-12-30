# encoding: utf-8

class String
  def modulize
    gsub('__','/').
    gsub(/\/(.?)/u){ "::#{$1.upcase}" }.
    gsub(/(?:_+|-+)([a-z])/u){ $1.upcase }.
    gsub(/(\A|\s)([a-z])/u){ $1 + $2.upcase }
  end
  
  def parse
    rfc2822 = "(#{Time::RFC2822_DAY_NAME.join('|')}, )? \d{1,2} #{Time::RFC2822_MONTH_NAME.join('|')} \d{4,4} \d{2,2}:\d{2,2}:\d{2,2} [+-]\d{4,4}"
    ansi    = "#{Time::RFC2822_DAY_NAME.join('|')} #{Time::RFC2822_MONTH_NAME.join('|')} +\d{1,2} \d{2,2}:\d{2,2}:\d{2,2} [A-Z]{3,3} \d{4,4}"
    case self
    when /^[+-]?\d+$/u
      to_i
    when /^[+-]?\d+\.\d+/u
      to_f
    when /^(true|false)$/iu
      self =~ /^true$/iu ? true : false
    when /^#{rfc2822}|#{ansi}$/u
      Time.parse(self) rescue self
    else
      self
    end
  end
end
