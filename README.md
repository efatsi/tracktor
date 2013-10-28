#Tracktor

Tracking your Harvest timers the Arduino way

##Setup

You'll need to have 6 buttons and LEDs hooked up like so:

![tracktor-fritzing-diagram](http://cl.ly/image/0F0g323c3v0d/tractor_diagram.jpg)

Set the following environment variables:

* HARVEST_DOMAIN
* HARVEST_EMAIL
* HARVEST_PASSWORD


Initialize 6 (or less) timers in the Harvest app for today.

##Runing The App

Start the Sinatra app (ruby farmer.rb) and direct your browser to http://localhost:4567/settings. You'll see the list of today's timers on Harvest and their IDs. Copy paste the IDs into the Button fields you want and submit the form.

Leave the Sinatra app running and start Plow (ruby plow.rb) in another Terminal window. Once you see `Ready to get to work!`, click away and you're timers (theoretically) will be updating!
