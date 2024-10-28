import '../models/user.dart';

class UserData {
  static UserModel myUser = UserModel(
    username: 'somename',
    email: 'some@gmail.com',
    password: 'mypassword',
    name: 'John Doe', // Example name
    birthYear: 1990, // Example birth year
    gender: 'Male', // Example gender
    country: 'Poland', // Example country
    favoriteGenres: ['Action', 'Adventure', 'Drama'], // Example favorite genres
  );
}