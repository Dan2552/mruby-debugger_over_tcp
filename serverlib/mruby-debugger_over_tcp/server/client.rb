class Client
  def initialize(connection)
    @connection = connection
    @id = SecureRandom.uuid[0..5]
  end

  def send_message(message)
    connection.puts(message)
  end

  attr_reader :id

  private

  attr_reader :connection
end
