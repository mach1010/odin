require 'socket'

server = TCPServer.open(2000)
loop {
  client = server.accept
  verb, resource, http = client.gets.split(' ', 3)
  
  if File::exists?("./#{resource}")
    response = File.read("./#{resource}")
    status = '200 OK'
  else
    status = '404 NOT FOUND'
  end
  response_line = "HTTP/1.1 #{status}\r\n"
  response_headers = ['Content-type: text/plain',
                      "Content-length: #{response.to_s.length || 0}",
                      "Connection: close",
                      "Date: #{Time.now.ctime}",
                      "Server: Ruby"
                      ]

  client.print response_line
  client.print response_headers.join("\r\n") + "\r\n\r\n"
  client.print response
  
  puts response_line
  puts   response_headers.join("\r\n") + "\r\n\r\n"
  puts 'VERB: ' + verb
  puts 'URI: '  + resource
  puts 'HTTP: ' + http
  puts

  client.close
}