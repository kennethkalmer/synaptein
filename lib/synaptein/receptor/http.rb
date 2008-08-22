require 'evma_httpserver'
gem 'libxml-ruby'
require 'libxml'

module Synaptein
  module Receptor
    
    # = Overview
    #  
    # The HTTP receptor is an EventMachine HTTP listener that receives XML 
    # post messages and relays them to Jabber recipients.
    #
    # This is great for allowing shell scripts to send jabber messages, or
    # for Rails to send non-blocking messages without blocking during the
    # connect/authorize/send/disconnect process. Having non-thread safe code 
    # with the xmpp4r gem can also cause weird results.
    #
    # = Protocol
    #
    # The HTTP receptor expects an HTTP POST sent to / with an XML body like 
    # this:
    #
    #   <transmission>
    #     <to>jabberid@example.com</to>
    #     <!--<to>jabberid@example.net</to>-->
    #     <message>
    #       Body of your message
    #     </message>
    #   </transmission>
    # 
    # Wrapped in a <transmission/> tag is the following allowed tags:
    # 
    # * <to/> - A single Jabber ID, multiple tags allowed
    # * <message/> - The message to be sent
    # 
    # The from cannot be set, since this is set in the Synaptein configuration
    # files. You can however embed an identifier in the body to identify the
    # source of the message.
    # 
    # == wget example:
    # 
    # Use wget to send a Jabber message (line wrapped for readibility)
    # 
    #   wget --post-data="<transmission><to>kenneth@devbox</to><message>Whoot</message></transmission>" \
    #     -O resp http://127.0.0.1:8080
    #
    class Http
      
      class << self
        
        # Start the receptor
        def spawn!
          EM.spawn do
            EventMachine.epoll
            EventMachine.start_server("0.0.0.0", 8080, Handler)
          end
        end
        
      end
      
      class Handler < EventMachine::Connection
        include EventMachine::HttpServer
        include LibXML
        
        def process_http_request
          response = EventMachine::DelegatedHttpResponse.new( self )
          
          begin
            parser = XML::Parser.new
            parser.string = @http_post_content
            doc = parser.parse
            
            destinations = doc.find('//transmission/to').inject([]) { |list,to| list << to.content }
            body_node = doc.find('//transmission/message').first
            body = body_node.nil? ? '' : body_node.content
            
            if destinations.empty?
              response.status = 404
              response.content = 'No destinations specified, message discarded'
            else
              message = Synaptein::Message.new(
                :receptor => :http,
                :destinations => destinations,
                :body => body
              )
              routing = proc { Synaptein::Router.route( message ) }
              EM.defer( routing )
              
              response.status = 200
              response.content = 'Message routed'
            end

          rescue => e
            $stdout.write( e.message + "\n" )
            $stdout.write( e.backtrace.join("\n  ") )
            
            response.status = 500
            response.content = e.message
          end
          
          response.send_response
        end
      end
    end
  end
end
