# GRAB BAG
## The hottest new way to store and share your files

View it live at: https://grab-bag-1701.herokuapp.com/

### Setup

To set up a local copy of this project, perform the following:

* Clone the repository: `git clone https://github.com/glassjoseph/grab_bag.git`
* `cd` into the project's directory
* Run `bundle install`
* Run `bundle exec rake db:{create,migrate,seed}` to set up the database locally and seed it with files, folders, users, and comments
* To login as an admin (in development), use these credentials - username: admin1, password: password
* Run the application in the dev environment with `rails s`
* Visit http://localhost:3000/ and enjoy

### Schema

A visual representation of the schema is here:
![schema pic](app/assets/images/24_may_schema.png?raw=true)


### Features (the basic version)

Visitor

 * Visitor things

User

 * A user can authenticate via Facebook or manually
 * She must provide a username and phone number for Two Factor Authentication purposes
 * A user can view and edit her details
 * A user can be an admin, at which point she can deactivate users, delete folders, files, and comments

Admin

 * Admin things


Folder

 * Every user is created with a home folder
 * When a new folder is created, its entire path is stored in the database
 * Folders can be made public (or private, if already public)
 * Folders can be shared by entering another user's username


File (in the schema, Binary)

 * Files can be uploaded or downloaded if they belong to that user, or if they are in a folder shared with that user
 * Files can be previewed on the page


Comment

 * A user can leave comments on any file that is owned or shared with her

Like

 * A user can like a comment or a file to which she has access

### Features (the in-depth version)


### Design
### Contributors

[Joseph Glass](https://github.com/glassjoseph)
[Jonathan Kidd](https://github.com/jk1dd)
[Sam Landfried](https://github.com/samlandfried)
[Danny Radden](https://github.com/dannyradden)
[Brett Schwartz](https://github.com/bschwartz10/)
