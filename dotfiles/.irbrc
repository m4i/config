IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:SAVE_HISTORY] = 100000

require 'irb/completion'

%w(
  benchmark
  date
  fileutils
  find
  json
  open-uri
  pathname
  pp
  securerandom
  time
  yaml
).each do |lib|
  begin
    require lib
  rescue LoadError
    $stderr.puts "cannot load #{lib}"
  end
end
