import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/database_configuration/authentication_service.dart';
import 'package:zpi_project/movies/domain/repositories/movie_repositorie.dart';
import 'package:zpi_project/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:zpi_project/movies/data/repositories/movie_repository_impl.dart';
import 'package:zpi_project/movies/domain/entities/movie.dart';
import 'package:logger/logger.dart';

part 'forgotten_password_event.dart';
part 'forgotten_password_state.dart';

class ForgottenPasswordBloc
    extends Bloc<ForgottenPasswordEvent, ForgottenPasswordState> {
  final AuthenticationService _authService = AuthenticationService();
  final MovieRepository _movieRepository;

  ForgottenPasswordBloc()
      : _movieRepository = MovieRepositoryImpl(MovieRemoteDataSource()),
        super(ForgottenPasswordInitial()) {
    on<SendButtonPressed>(_onSendButtonPressed);
  }

  Future<void> _onSendButtonPressed(
    SendButtonPressed event,
    Emitter<ForgottenPasswordState> emit,
  ) async {
    emit(ForgottenPasswordLoading());
    final localizations = event.localizations;
    try {
      List<Movie> movies = await _movieRepository.fetchMovies();

      var logger = Logger();
      for (var movie in movies) {
        logger.log(Level.info,
            "Title: ${movie.title}, Categories: ${movie.categories.join(', ')}");
      }
      await _authService.sendPasswordResetEmail(email: event.email);
      emit(ForgottenPasswordSuccess());
    } catch (error) {
      //emit(ForgottenPasswordFailure(error: error.toString()));
      emit(ForgottenPasswordFailure(error: localizations.send_email_error));
    }
  }
}
