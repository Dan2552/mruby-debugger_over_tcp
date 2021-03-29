module DebuggerOverTCP
  class Server
    def initialize(port)
      @port = port
    end

    def start!
      server = TCPServer.new(port)

      loop do
        puts "Listening for client..."
        connection = server.accept
        client_listener(connection)
      end
    end

    private

    attr_reader :port

    def client_listener(connection)
      client = Client.new(connection)
      puts "Connected to client #{client.id}"

      loop do
        if message = connection.gets
          if message == "(debugger) > \n"
            print(message.gsub("\n", "").gsub("[_EOL]", "\n"))
            input = STDIN.gets
            if input
              input = input.strip
              exit(0) if input == "exit"
              client.send_message(input)
            end
          elsif message == "(nbdebugger) > \n"
            if !@nbfirst
              @nbfirst = true
              print(message.gsub("\n", "").gsub("[_EOL]", "\n"))
              input = STDIN.gets
              if input
                input = input.strip
                exit(0) if input == "exit"
                client.send_message(input)
              end
            end
          else
            print(message.gsub("\n", "").gsub("[_EOL]", "\n"))
          end
        end
      end
    rescue Errno::ECONNRESET
      disconnect_reason = "client unexpectedly exited"
    ensure
      disconnect_reason ||= "server exited"
      puts "Client #{client.id} disconnected (#{disconnect_reason})"
      connection.close
    end
  end
end
