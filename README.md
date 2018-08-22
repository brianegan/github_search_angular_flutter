# github_search_angular_flutter
Demonstrates how to use the bloc pattern for both an Angular and Flutter app

## Structure

  * github_search_common - Code that is common to both the Angular App and Flutter app
    - Contains the Data layer. For now, this means a simple in-memory cache and github web client, composed together via a Repository. In a bigger app, this might need to be split out more to handle things like SQLite storage for Flutter and IndexDB storage for Web projects
    - Contains the search bloc, which depends on the Repository.
    - Contains tests for all of this!
  * flutter_app - Run it as you would a normal flutter app! `flutter run` or via an Editor / IDE
  * angular_dart_app - Run it with `webdev serve`
    - Still a bit rough, think AngularDart could use something like a generic `StreamBuilder` component as the async pipe didn't quite provide all the functionality I was looking for.
