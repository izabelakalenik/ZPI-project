part of 'register_bloc.dart';


final defaultUser = UserModel(
  email: '',
  password: '',
  name: '',
  username: '',
  birthYear: 0,
  gender: '',
  country: 'Poland',
  favoriteGenres: [],
);

@immutable
class RegisterState extends Equatable {
  final UserModel user;

  const RegisterState({required this.user});

  RegisterState copyWith({UserModel? user}) {
    return RegisterState(user: user ?? this.user);
  }

  @override
  List<Object?> get props => [user];
}

class RegisterProceed extends RegisterState {
  const RegisterProceed(UserModel user) : super(user: user);
}

class RegisterComplete extends RegisterState {
  const RegisterComplete(UserModel user) : super(user: user);
}

class RegisterInitial extends RegisterState {
  RegisterInitial() : super(user: defaultUser);
}

class RegisterLoading extends RegisterState {
  const RegisterLoading(UserModel user) : super(user: user);
}

class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure({required this.error, required super.user});

  @override
  List<Object?> get props => super.props + [error];
}

class FacebookRegisterFailure extends RegisterState {
  final String error;

  const FacebookRegisterFailure({required this.error, required super.user});

  @override
  List<Object?> get props => super.props + [error];
}

class RegisterUsernameTaken extends RegisterState {
  final String error;

  const RegisterUsernameTaken({required this.error, required super.user});

  @override
  List<Object?> get props => super.props + [error];
}