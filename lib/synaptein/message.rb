module Synaptein
  
  # = Synaptein Messages
  # 
  # Messages are the backbone of the synaptein system. These travel from
  # receptors to transmitters, and contain all the data needed for messages
  # to be routed successfully.
  # 
  # A message has the following accessors:
  # * receptor - Who made this
  # * destinations - An array of destination URI's
  # * body - The body to be sent
  # 
  # A convience attribute called +created_at+ is set. This may be used to bench
  # the flow of the message through the system, but other than that has no real
  # purpose
  # 
  class Message
    
    attr_accessor :receptor, :destinations, :body
    attr_reader :created_at
    
    # Create a new message, passing in receptor, destinations and body as 
    # paramters to get going quickly
    def initialize( options = {} )
      options.assert_valid_keys( :receptor, :destinations, :body )
      
      @receptor = options[:receptor]
      @destinations = options[:destinations] || []
      @body = options[:body]
      
      @created_at = Time.now
    end
    
    def to_s
      "Synaptein::Message - receptor: #{@receptor}, destination: #{@destinations.join(',')}, body: #{@body}"
    end
    
  end
end
