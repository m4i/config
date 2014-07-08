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


# https://github.com/pry/pry/wiki/FAQ#wiki-hirb
begin
  require 'hirb'
rescue LoadError
  # Missing goodies, bummer
end

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |*args|
        Hirb::View.view_or_page_output(args[1]) || @old_print.call(*args)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end
