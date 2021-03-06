namespace :build do
  desc "Convert masthead erb to a javascript string variable"
  task masthead: :environment do
    erb_to_jsfile("app/assets/content/#{ENV["AUDIENCE"]}/masthead.html.erb", 'app/assets/javascripts/masthead_content.js', 'malmoMasthead')
    puts "Generated masthead for environment \033[32;1m#{Rails.env}\033[0m and audience \033[32;1m#{ENV["AUDIENCE"]}\033[0m"
  end

  desc "Convert footer erb to a javascript string variable"
  task footer: :environment do
    erb_to_jsfile("app/assets/content/#{ENV["AUDIENCE"]}/footer.html.erb", 'app/assets/javascripts/footer_content.js', 'malmoFooter')
    puts "Generated footer for environment \033[32;1m#{Rails.env}\033[0m and audience \033[32;1m#{ENV["AUDIENCE"]}\033[0m"
  end

  private
    def erb_to_jsfile(erb_file, js_file, js_var)
      # Convert erb template to html
      # Convert erb template to html
      erb = File.read(File.expand_path(erb_file))
      html = ERB.new(erb).result(binding)

      # Make it a one line string and attach it to a js var
      html = html.gsub(/^\s+/, '').gsub(/\n/, ' ').gsub(/\s+/, ' ').gsub(/'/, '"').strip
      js_var = "var #{js_var} = '#{html}';"

      File.open(js_file, 'w') do |f|
        f.puts("// Don't edit this file. Auto generated from an erb template with rake")
        f.puts(js_var)
        f.close
      end
    end
end
