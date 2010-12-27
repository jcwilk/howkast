class String
  def modulize
    gsub('__','/').
    gsub(/\/(.?)/){ "::#{$1.upcase}" }.
    gsub(/(?:_+|-+)([a-z])/){ $1.upcase }.
    gsub(/(\A|\s)([a-z])/){ $1 + $2.upcase }
  end
end
