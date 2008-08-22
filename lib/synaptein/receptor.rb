module Synaptein
  
  # = Receptors
  #
  # A Receptor in Synaptein is responsible for receiving a message from the
  # outside world, and translate it into a #Synaptian::Message object before
  # passing it on to the Router for delegation.
  # 
  # A receptor can be capable of receiving any format of information from any
  # source. For example, the #Synaptein::Recepter::Http implementation processes
  # a set format of XML into a #Synaptein::Message
  # 
  # The goal would be to have as many possible receptors running as possible
  # at the same time as required, and thus build up a powerful daemon capable
  # of dissiminating a large volume of information reliably.
  #
  module Receptor
    
  end
end
