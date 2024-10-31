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
    favoriteGenres: [1, 2, 3], // Example favorite genres
  );
}