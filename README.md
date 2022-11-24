# Fakebook

Here you'll find Fakebook, a Rails application that contains a basic set
of features akin to what you'll find on most social media platforms.

Fakebook contains the following features:

- User Registration
- User Profiles
- Post Creation
- Photo Uploads
- Post Likes
- Post Commenting
- Friend Networking
- Posts Feed

This project is done following The Odin Project, which this project in particular can
be found [here](https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project).

## Usage

Here's a basic rundown of how to use Fakebook.

Sign up and make a valid Fakebook account with your email, password, name,
and profile picture of your choice. If necessary you can edit these later.

You'll receive a welcome email so you'll know you're using Fakebook.

Upon logging in, you'll be able to see the navigation bar to access the
application's features.

After logging in or signing up, you'll be first sent to your profile page.
Here you'll see your photo, name, and a feed of all of the posts you've
created.

Your timeline is your main posts feed, where all of the posts from your
friends and yourself are displayed. To view a post completely, just click
on the post's 'View' button. This is also where you can make posts.

To make a post, press the 'Make a new post!' button and add your post body
and photo if you'd like.

Whenever you view a post, you can see the post itself, how many people liked
it, and how many times the post has been commented on. If you want to add
your own, just use the corresponding buttons when viewing a post.

The all users directory contains a list of all users and your friend status with
them. You can add or remove friends here. Whenever you want to add a friend,
the person you're interested in becoming friends with will receive a friend
request.

Whenever there's pending friend requests sent to you, your notifications
indicator will change count, and you can view all new friend requests. It's
up to you whether you would like to accept it or not.

That's a simple walkthrough of how to use Fakebook. If you ever want to adjust
your account settings or delete your account, just access the Account tab from
your navigation bar.

Have fun!

## Testing Notes

During creation of this application, testing was performed using the testing
features provided by Rails.

However, if you were to run said tests, you would notice a lot of errors.

Most of the testing was performed prior to adding Active Storage functionality
and a gem that provides Active Storage validations.

As such, the model and integration tests that would normally pass would be marked
as failing or containing an error.

Testing around Active Storage is a bit of a headache, doubly so when adding a
required validation for User photos.

If you are interested in getting the tests to pass, remove or comment out the
validations for users as well as all view templates that display photo feeds
from users or posts.

## Additional Notes

All of the CSS for this app was done without a framework or template. It's
intended to look as consistent as possible, but there may be some slip ups
here and there (looking at you 'Forgot Password?'' link).

Most of the functionality should work as intended, however some of the reliance
from gems such as Devise may produce unintended effects or cause errors unseen
during development. Ie. During development I noticed that Devise handles
putting multiple forms together on the same page oddly, and would change classes
for both form tags that would disrupt my CSS, so a workaround was added.

This application has implementation for the omniauth-facebook gem together with
Devise, mostly commented out and completely untested. Using it will likely require
said portions to be added back in, views to appropriately display login options
with it, and additional implementation as necessary.

Lastly, this is mostly a project done for learning purposes. There's not much
intention to improve it further, unless a need arises to revisit this application
or to reuse it somehow.
