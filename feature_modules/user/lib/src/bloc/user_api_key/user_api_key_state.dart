import 'package:equatable/equatable.dart';

abstract class UserApiKeyState extends Equatable {}

class UserApiKeyInitial extends UserApiKeyState {
  @override
  List<Object?> get props => [];
}

class UserApiKeyLoadInProgress extends UserApiKeyState {
  @override
  List<Object?> get props => [];
}

class UserApiKeyLoadSuccess extends UserApiKeyState {
  UserApiKeyLoadSuccess({required this.apiKey});

  final String apiKey;

  @override
  List<Object?> get props => [apiKey];
}

class UserApiKeyLoadFailure extends UserApiKeyState {
  @override
  List<Object?> get props => [];
}

class UserApiKeyDeleteInProgress extends UserApiKeyLoadSuccess {
  UserApiKeyDeleteInProgress({required super.apiKey});

  @override
  List<Object?> get props => [];
}

class UserApiKeyDeleteSuccess extends UserApiKeyState {
  UserApiKeyDeleteSuccess();

  @override
  List<Object?> get props => [];
}

class UserApiKeyDeleteFailure extends UserApiKeyLoadSuccess {
  UserApiKeyDeleteFailure({required super.apiKey});

  @override
  List<Object?> get props => [];
}
