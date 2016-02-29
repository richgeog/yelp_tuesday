# Yelpy
This was my very first rails app that I made, it is a very similar application to what yelp is like, but only for restaurants, however the main principles would be the same when it comes to adding further features.

Users can create accounts to allow the user to then add any restaurants they want to, they can also rate and comment any restaurant they wish too and if they want can delete any restaurants they have added themselves to the site.

I used the gem devise to add in user sign up functionality to the app, this made for easy use when setting this part up. I also used Facebook omniauth as a way of allowing the user to sign in using their own Facebook account for easier use.

Image uploads are actioned by using paperclip and stored within the local database currently, it is not compulsory for users to upload an image when they add a restaurant on the site.

#### Update - 29th Feb'16
---
I've gone back to this repository to try and put into practice some learnings from an Upcase trail around testing and refactoring I have recently completed. I felt before some of my methods within my controllers were too long, fairly complex and most likely also breaking single responsibility in some parts, so I have re-factored these and tried to create some smaller methods which then are called by the original methods. I feel fairly happy with these now as they read a lot easier and have made the code become a lot cleaner.

In my feature tests I have added some some helper methods and set these to private, not that they need to be, this is just to highlight some separation from the tests. I added these to dry up some of my tests as I was repeating a lot of the same code many times over before hand. I'm unsure still as to whether placing these within the feature test is correct or if they should be moved out into the helpers folder, I'll continue to do some reading up and see what the best approach is.

I've also re-looked at the routes file, within my config file as when I use `rake routes` there were a whole bunch of routes available to me that I was not using. So to make this clear and easier to see what routes are currently being used I have explicitly amended the routes to only display the routes in use. The users and restaurants I haven't completed as yet, I am trying to understand which I am using through the devise gem and which I am not.