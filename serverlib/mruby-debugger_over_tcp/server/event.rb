module DebuggerOverTCP
  class Server
    class Event
      attr :origin_client_id
      attr :message

      def initialize(origin_client_id, message)
        @origin_client_id = origin_client_id
        @message = message
      end
    end
  end
end
