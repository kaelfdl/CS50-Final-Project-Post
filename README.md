# Post

Post is an iOS app that allows iOS developers to start a project with an access token based user login system in place.

The Post app provides basic user login and signup functionality. It also manages user credentials and account deletion.

The app is divided into two parts: Server (nodejs) and Client (swift)

By default, a tab bar controller with three different view controllers will be presented to the user upon successful login. The tab bar controller itself can be modified to incorporate other view controllers as well.

## Prerequisites

Before you begin, ensure you have met the following requirements:
* You have installed the latest version of [mongo shell](https://docs.mongodb.com/manual/mongo/) and [nodejs](https://nodejs.org/en/).
* You have a Mac machine. Running macOS 10.9 or above.
* You have Xcode 11.0 or above.

## Cloning the repository

To clone from the repository:
```
git clone https://github.com/kaelfdl/CS50-Final-Project.git
```

## Installing Post

To install Post, follow these steps:

MacOS:

Navigate to the server directory and install the dependencies.
```
cd /path/to/server
npm install
```

## Using Post

To use Post, follow these steps:

Run the mongo server:
```
mongod --config /path/to/mongod.conf
```

Start the REST API server:
```
cd /path/to/server
npm start
```
Run the iOS app:
```
open -a Xcode /path/to/Post.xcodeproj
cmd + R
```

## User Actions

A user can signup by providing an email, a username, a password, a first and last name.

Upon successful signup, the user will automatically be logged in and presented with the home view controller.

An existing user can choose to login. They will remain logged in unless they choose to logout, delete their account, or until their valid access token expires or becomes invalid.

## Contributing to Post
To contribute to Post, follow these steps:

1. Fork this repository.
2. Create a branch: `git checkout -b fork/<your_github_username>`.
3. Make your changes and commit them: `git commit -m '@github username: <your_message>'`
4. Push to the original branch: `git push origin Post/forks`
5. Create the pull request.

Alternatively see the GitHub documentation on [creating a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).

## Contact

If you want to contact me you can reach me at <kaelewl@gmail.com>

## License

This project uses the following license: [MIT License](https://github.com/kaelfdl/CS50-Final-Project/blob/master/LICENSE).
