require 'resolv'
require 'uri'
require 'net/http'
require 'colorize'

SUBDOMAINS = ["www", "mail", "ftp", "blog", "admin", "dev", "shop", "api", "test", "secure"]

# 🛠 Small Stylish Logo
puts """
███████╗██╗   ██╗██████╗  ██████╗ ███████╗███████╗
██╔════╝██║   ██║██╔══██╗██╔═══██╗██╔════╝██╔════╝
███████╗██║   ██║██████╔╝██║   ██║███████╗█████╗  
╚════██║██║   ██║██╔══██╗██║   ██║╚════██║██╔══╝  
███████║╚██████╔╝██████╔╝╚██████╔╝███████║███████╗
╚══════╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝╚══════╝
""".colorize(:light_blue)

puts "🔹 Created for Ethical Bug Bounty Hunters".colorize(:cyan)
puts "🔹 GitHub: https://github.com/iBlameHannibal/".colorize(:light_cyan)
puts "\n"

def get_ip_address(domain)
  begin
    Resolv.getaddress(domain)
  rescue Resolv::ResolvError
    "Could not resolve"
  end
end

def extract_domain(url)
  uri = URI.parse(url)
  uri.host || url  
rescue URI::InvalidURIError
  url
end

def check_alive(domain)
  url = "http://#{domain}"
  begin
    response = Net::HTTP.get_response(URI(url))
    return "✅ Alive (#{response.code})".colorize(:green) if response.is_a?(Net::HTTPSuccess)
    "❌ Down (#{response.code})".colorize(:red)
  rescue StandardError
    "❌ Down (No Response)".colorize(:red)
  end
end

def find_subdomains(domain)
  found = []
  SUBDOMAINS.each do |sub|
    subdomain = "#{sub}.#{domain}"
    ip = get_ip_address(subdomain)
    found << { subdomain: subdomain, ip: ip, status: check_alive(subdomain) }
  end
  found
end


def reverse_ip_lookup(ip)
  begin
    Resolv.getname(ip)
  rescue Resolv::ResolvError
    "No reverse lookup found"
  end
end


def fetch_http_headers(domain)
  url = URI.parse("http://#{domain}")
  begin
    response = Net::HTTP.get_response(url)
    headers = response.each_header.map { |k, v| "#{k}: #{v}" }
    headers.empty? ? "No headers found" : headers.join("\n")
  rescue StandardError
    "Failed to fetch headers"
  end
end

def get_valid_input(prompt)
  loop do
    print prompt.colorize(:light_yellow)
    input = gets.chomp.strip
    return input unless input.empty?
    puts "⚠️  Input cannot be empty! Please enter a value.".colorize(:red)
  end
end


user_input = get_valid_input("Enter a website URL: ")
file_name = get_valid_input("Enter a name for the output file (without .txt): ") + ".txt"

domain = extract_domain(user_input)
ip_address = get_ip_address(domain)
status = check_alive(domain)
reverse_lookup = reverse_ip_lookup(ip_address)
http_headers = fetch_http_headers(domain)
subdomains = find_subdomains(domain)

File.open(file_name, "w") do |file|
  file.puts "🔍 Bug Bounty Scan Results for: #{domain}"
  file.puts "-------------------------------------"
  file.puts "Main Domain: #{domain}"
  file.puts "IP Address: #{ip_address}"
  file.puts "Reverse IP Lookup: #{reverse_lookup}"
  file.puts "Status: #{status}"
  file.puts "\n🛰️ Subdomains Found:"
  subdomains.each do |sub|
    file.puts "#{sub[:subdomain]} | #{sub[:ip]} | #{sub[:status]}"
  end
  file.puts "\n🌐 HTTP Headers:"
  file.puts http_headers
end


puts "\n✅ Scan Completed! Results saved to #{file_name}".colorize(:green)
puts "📌 Main Domain: #{domain} (#{status})"
puts "📌 IP Address: #{ip_address}"
puts "📌 Reverse Lookup: #{reverse_lookup}".colorize(:light_magenta)
puts "📌 Subdomains Found: #{subdomains.length}".colorize(:light_cyan)

subdomains.each do |sub|
  puts "#{sub[:subdomain]} | #{sub[:ip]} | #{sub[:status]}"
end

puts "\n🌐 HTTP Headers:".colorize(:light_yellow)
puts http_headers.colorize(:light_cyan)
