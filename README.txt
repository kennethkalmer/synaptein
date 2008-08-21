synaptein
=========

As per Wikipedia:

  The word "synapse" comes from "synaptein", which Sir Charles Scott
  Sherrington and colleagues coined from the Greek "syn-" ("together") and
  "haptein" ("to clasp").

synaptein is a simple daemon that translate from other protocols into Jabber,
and in future versions back again.

This has several (not immediately obvious) benefits:

* Quicker message dispatching for stateless and short lived services. This
  includes bash scripts sending via curl, or cron notifications, etc.

* Translating incoming Jabber messages into AMQP for true distributed
  processing and task delegation

* Translating incoming Jabber messages into REST for processing by Merb, Rails
  or Halcyon

And many others...

synaptein will be written in Ruby, and initially support incoming XML message
to Jabber convertions, with a seperate Rails plugin for sending messages to
the synaptein daemon.

