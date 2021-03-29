# module DebuggerOverTCP
#   class Server
#     class ClientRegistry
#       def register(client)
#         semaphore.synchronize do
#           store[client.id] = client
#         end
#       end

#       def unregister(client)
#         semaphore.synchronize do
#           store.delete(client.id)
#         end
#       end

#       def broadcast(event)
#         semaphore.synchronize do
#           store.each do |client_id, client|
#             next if event.origin_client_id == client_id

#             client.send_message(event.message)
#           end
#         end
#       end

#       private

#       def store
#         @store ||= {}
#       end

#       def semaphore
#         @semaphore ||= Mutex.new
#       end
#     end
#   end
# end
