class NonBlockingDebuggerOverTCP < DebuggerOverTCP
  def initialize(verbose = false)
    super
  end

  def self.debugger_input(input)
    s = "begin\n"
    r = "\nrescue => exc\nNonBlockingDebuggerOverTCP.instance.puts exc.class.to_s; NonBlockingDebuggerOverTCP.instance.puts exc.inspect\nend"
    s + input + r
  end

  protected

  def client
    @client ||= SimpleTCP::Client.new(blocking: false)

    # Prevent calling to connect too often if failing
    return @client if @last_failed_at && (Time.now.to_i - @last_failed_at < 3)

    @last_failed_at = nil

    @client.connect("127.0.0.1", 3465) unless @client.connected?
    @client
  rescue SimpleTCP::FailedToConnectError => e
    @last_failed_at = Time.now.to_i
    raise e
  end
end

NB_TCP_DEBUGGER = '
begin
  NonBlockingDebuggerOverTCP.instance.print("(nbdebugger) > ")
  _input = NonBlockingDebuggerOverTCP.instance.gets
  if !_input.nil? && _input.length > 0
    output = eval(NonBlockingDebuggerOverTCP.debugger_input(_input)).inspect
    NonBlockingDebuggerOverTCP.instance.puts("=> #{output}")
    NonBlockingDebuggerOverTCP.instance.print("(debugger) > ")
  end
rescue SimpleTCP::FailedToConnectError, SimpleTCP::DisconnectedError
end
'
