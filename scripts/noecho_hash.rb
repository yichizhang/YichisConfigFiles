require 'digest'
begin
  require 'io/console'
rescue LoadError
end

def show_hash(name, hash)
  print name
  print " "
  print hash
  print "\n"
end

if STDIN.respond_to?(:noecho)
  def get_password(prompt="Password: ")
    print prompt
    STDIN.noecho(&:gets).chomp
  end
else
  def get_password(prompt="Password: ")
    `read -s -p "#{prompt}" password; echo $password`.chomp
  end
end

password = get_password()

print "\n"

# Compute digest by chunks
md5 = Digest::MD5.new
md5 << password                       # << is an alias for update
show_hash("md5       ", md5.hexdigest)

# Other encoding formats
show_hash("SHA256-hex", (Digest::SHA256.hexdigest password))
show_hash("SHA256-b64", (Digest::SHA256.base64digest password))
