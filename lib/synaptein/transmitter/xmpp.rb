require 'xmpp4r-simple'

module Synaptein
  module Transmitter
    
    # = Jabber (XMPP) Transmitter
    # 
    # The idea behind this class is the reason the project was born, enough
    # sulking, on to the real docs.
    # 
    # The XMPP transmitter maintains an active Jabber presence, dissiminating
    # message to the intended recipients as quickly as possible.
    # 
    # It's worth noting that the transmitter will discard any incoming messages,
    # but will accept any authorization requests to allow for seamless 
    # transmittion of said messages.
    # 
    # Currently support is only planned for a single active JID, but future
    # versions might implement multiple active clients and the ability to
    # send as a different sender based on certain criteria.
    #
    class Xmpp
      
      # The running instance of xmpp4-simple.
      @@client = nil
      cattr_reader :client
      
      class << self
        
        def spawn!
          configure!
          
          EM.spawn { |message|
            unless message.nil?
              $stdout.write("Transmitting message: #{message.inspect}")
              
              message.destinations.each do |dest|
                Synaptein::Transmitter::Xmpp.deliver( dest, message.body )
              end
            end
          }
        end
        
        def deliver( jid, message )
          self.client.deliver( jid, message )
        end
        
        private
        
        def configure!
          @@client ||= Jabber::Simple.new('ispinabox@devbox', 'secret')
        end
        
      end
    end
  end
end
