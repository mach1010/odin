require 'socket'
require 'json'

$host = 'localhost'
$port= 2000
$path = "/index.html"
$socket = TCPSocket.open($host, $port)

def get_method
  puts "GET or POST?"
  method = gets.chomp
  case method
  when 'GET'
    $socket.print "GET #{$path} HTTP/1.1\r\n"
    $socket.print "Date: #{Time.now.ctime}\r\n\r\n"
  when 'POST'
    puts 'name?'
    name = gets.chomp
    puts 'email?'
    email = gets.chomp
    params = {:user => {:name => name, :email => email}}.to_json
    header = ["POST /thanks.html HTTP/1.1",
              "Date: #{Time.now.ctime}",
              "Content-Length: #{params.length}"]
    $socket.print header.join("\r\n") + "\r\n\r\n"
    $socket.print params
  else
    get_method
  end
end

get_method
response = $socket.read
headers, body = response.split("\r\n\r\n", 2)
puts headers
puts body
#
# {"user":{"name":"a","email":"a"
# {"user":{"name":"a","email":"a"}}