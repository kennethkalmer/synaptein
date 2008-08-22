module Synaptein
  
  # = The synaptein router
  # 
  # The router is responsible for getting messages from a receptor to a 
  # transmitter.
  # 
  # At the moment this is pretty static, always routing messages from any
  # receptor to the XMPP transmitter for delivery.
  # 
  # This will eventually grow to become a fully fledged URI-based router, 
  # allowing for powerful message routing possibilities.
  #
  class Router
    
    class << self
      
      # Route the provided #Synaptein::Message to the 
      # #Synaptein::Transmitter::Xmpp for delivery.
      def route( message )
        transmitter = Synaptein::Daemon.transmitter(:xmpp)
        $stdout.write( "Routing via #{transmitter.to_s}: #{message.inspect}" )
        transmitter.notify( message )
        
      end
      
    end
    
  end
end
