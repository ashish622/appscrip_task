
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';

abstract class UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;

  UserLoaded(this.users);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}


abstract class UserEvent {}

class LoadUsers extends UserEvent {}


class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    on<LoadUsers>(_onLoadUsers);
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoadUsers) {
      yield UserLoading();
      try {
        final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          final List<User> users = data.map((json) => User.fromJson(json)).toList();
          yield UserLoaded(users);
        } else {
          yield UserError('Failed to load users: ${response.reasonPhrase}');
        }
      } catch (e) {
        yield UserError('An error occurred: $e');
      }
    }
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<User> users = data.map((json) => User.fromJson(json)).toList();
        emit(UserLoaded(users));
      } else {
        emit(UserError('Failed to load users: ${response.reasonPhrase}'));
      }
    } catch (e) {
      emit(UserError('An error occurred: $e'));
    }
  }
}