# ArcMovies
A simple iOS app to check upcoming movies using TMDB API.

<p align="center">
  <img src="../development/screenShots/moviesList.png" width="25%">
  <img src="../development/screenShots/movieDetails.png" width="25%">
</p>

### Running the app
The app is compatible with XCode 9 and Swift 4.1
 1. Clone this repo and open XCode
 2. Open the file ArcMovies.xcworkspace
 3. Run the app

### Libraries used
 - CocoaPods to manage the project dependencies.
 - [SDWebImage](https://github.com/rs/SDWebImage) in order to cache the movie images easily. It was used in the movies list and movie details screens.

### Some information
 - The app is only in English, since there was no requirements about that.
 - The movies list is based on US Region only
 - Movie details screen has only the information that was asked for
 - Later on I intend to add .gitignore in order to remove Pod files.
 - Models identifiers are not using camel case because of JSONDecoder