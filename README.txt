= synaptein

* http://synaptein.rubyforge.org
* http://www.opensourcery.co.za/synaptein

== DESCRIPTION:

  The word "synapse" comes from "synaptein", which Sir Charles Scott
  Sherrington and colleagues coined from the Greek "syn-" ("together") and
  "haptein" ("to clasp").

synaptein is a simple daemon that translates between Jabber and other protocols.

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


== FEATURES/PROBLEMS:

* Initially only support translating XML (REST) to Jabber.
* Support planned for the reverse

== SYNOPSIS:

Configure and run the daemon

  $ synaptein -h
  $ synaptein run

The do a standard HTTP POST to http://localhost:4567/transmit with this XML 
body:

  <transmission>
    <to>jabberid@example.com</to>
    <!--<to>jabberid@example.net</to>-->
    <message>
      The message to be sent
    </message>
  </transmission>

Simle as that. Messages can be sent from anything that can talk HTTP.

== REQUIREMENTS:

* xmpp4r-simple
* eventmachine
* eventmachine_httpserver

== INSTALL:

* gem install synaptein

== LICENSE:

(The MIT License)

Copyright (c) 2008 Kenneth Kalmer

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
