unless Object.const_defined?("ExitError")
  class ExitError < StandardError; end
end

class DebuggerOverTCP
  def self.instance(renew = false)
    @instance = nil if renew
    @instance ||= new
  end

  def initialize(verbose = false)
    @verbose = verbose
    @empty_messages = 0
  end

  def print(str, retries = 1)
    STDOUT.print(str) if @verbose
    client.write(str + "\n")
    str
  rescue SimpleTCP::UnexpectedWriteError
    return if retries == 0
    puts(str, retries - 1)
  end

  def puts(str, retries = 1)
    STDOUT.puts(str) if @verbose
    client.write(str + "[_EOL]\n")
    str
  rescue SimpleTCP::UnexpectedWriteError
    return if retries == 0
    puts(str, retries - 1)
  end

  def gets(retries = 1)
    # Read from TCP and add any messages to the queue
    messages = client.read

    # If would block when blocking, ignore
    return if messages.nil?

    # If getting empty messages, send an empty message back - essentially like a
    # ping just to force the client to sure the connection is connected still.
    if messages == ""
      print("")
      return
    end

    messages.split("\n").each do |message|
      gets_buffer << message if messages.length > 0
    end

    # Pop (FIFO) only one message at a time
    message = gets_buffer.shift
    STDOUT.puts(message) if message && @verbose
    message
  rescue SimpleTCP::UnexpectedReadError
    return if retries == 0
    gets(retries - 1)
  end

  protected

  def client
    @client ||= SimpleTCP::Client.new
    @client.connect("127.0.0.1", 3465) unless @client.connected?
    @client
  rescue SimpleTCP::FailedToConnectError
    STDOUT.puts("Failed to connect to debugger (run `bundle exec mrb-debugger`)")
    sleep(3)
    client
  end

  private

  def gets_buffer
    @gets_buffer ||= []
  end
end
