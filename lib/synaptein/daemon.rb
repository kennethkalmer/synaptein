module Synaptein
  
  # Responsible for configuring and setting up the synaptein daemon process.
  #
  # Responsibilities include:
  # * Managing the Event loop
  # * Allowing receptors to 'spawn' processes the EM way
  # * Allowing transmitters to 'spawn' process the EM way
  #
  class Daemon
    
    # Symbol array of receptors to start, defaults to the HTTP receptor
    @@receptors = [ :http ]
    cattr_accessor :receptors
    
    # Symbol array of transmitters to start, defaults to the XMPP transmitter
    @@transmitters = [ :xmpp ]
    cattr_accessor :transmitters
    
    # List of running receptors
    @@running_receptors = {}
    
    # List of running transmitters
    @@running_transmitters = {}
    
    class << self
      
      def start! #:nodoc:
        # configure signal traps
        trap_signals!
        
        # start event loop
        EM.run {
          # spawn receptors
          self.receptors.each do |r|
            klass = Synaptein::Receptor.const_get( r.to_s.classify )
            @@running_receptors[r] = klass.spawn!
            @@running_receptors[r].notify
          end
          $stdout.write("Receptors running\n")
          
          # spawn transmitters
          self.transmitters.each do |t|
            klass = Synaptein::Transmitter.const_get( t.to_s.classify )
            @@running_transmitters[t] = klass.spawn!
          end
        }
      end
      
      def transmitter(key)
        @@running_transmitters[key]
      end
      
      private
      
      def trap_signals!
        trap("INT") do
          EM.stop
        end
        trap("TERM") do
          EM.stop
        end
      end
      
    end
    
  end
end
