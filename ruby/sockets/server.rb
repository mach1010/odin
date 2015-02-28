require 'socket'
require 'json'

class Request
  attr_reader :path, :params, :length
  def initialize(client)
    @client = client
    parse_headers
    get_params 
    log_to_console
  end
  
  def parse_headers
    header_string, @headers = '', Hash.new(nil)
    @method, @path, @http = @client.gets.split(' ', 3)

    while line = @client.gets
      header_string << line
      break if header_string =~ /\r\n\r\n$/
    end

    header_string.split(/\r\n/).each do |line| 
      pair = line.split(': ')
      @headers[pair.first] = pair.last
    end
  end

  def get_params
    length = @headers['Content-Length'].to_i
    @params = JSON.parse(@client.read(length))
  end
  
  def log_to_console
    puts 'REQUEST:'
    puts @method, @path, @http, @headers
    puts @params if @params
    puts
  end
end

class Response
  attr_reader :resource, :header
  def initialize(request)
    @request = request
    @status, @reason, @length = nil
    @params = @request.params
    @resource = render_template
    determine_status
    @header = construct_header
    log_to_console
  end
  
  def render_template
    resource = get_resource 
    if @params && resource
      sub = "<ul><li>Name: #{@params['user']['name']}</li><li> Email: #{@params['user']['email']}</li></ul>"
      resource.gsub('<%= yield %>', sub)
    else
      resource
    end
  end
  
  def get_resource 
    File.exists?(resource = ".#{@request.path}") && 
    !File.directory?(resource) ? File.read(resource) : nil
  end
  
  def determine_status
    if @resource
      @status, @reason, @length = '200', 'OK', @resource.length
    else
      @status, @reason, @length = '404', 'FILE NOT FOUND', nil
    end
  end
  
  def construct_header
    header_info = ["HTTP/1.1", "#{@status}", "#{@reason}", 
                   "Content-Type: text/html",
                   "Content-Length: #{@length}",
                   "Date: #{Time.now.ctime}",
                   "Server: Ruby",
                   "Connection: close"]
    header_info.join("\r\n") + "\r\n\r\n"
  end
  
  def log_to_console
    puts 'RESPONSE:'
    puts @header
    puts 
  end
end

class Server
 def initialize(port)
   @port = port
   @client
   @request
   @response
   @socket = TCPServer.open(@port)
 end

 def listen
   # listen endlessly
   loop{
     # accept a request
     @client = @socket.accept
     # parse the request
     @request = Request.new(@client)
     # create response based on request
     @response = Response.new(@request)
     # send the response
     @client.print @response.header
     # IO.copy_stream(@response.resource, @client)
     @client.print @response.resource
     # close the transaction
     @client.close
   }
 end
end

#begin:
server = Server.new(2000)
server.listen
