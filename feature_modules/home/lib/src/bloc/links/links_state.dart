import 'package:core/utils.dart';
import 'package:equatable/equatable.dart';

import '../../repository/api/models/links/link_model.dart';

abstract class LinksState extends Equatable {
  const LinksState();

  @override
  List<Object> get props => [];
}

class LinksInitial extends LinksState {
  const LinksInitial();
}

class LinksLoadInProgress extends LinksState {
  const LinksLoadInProgress({this.links});

  final List<LinkModel>? links;

  @override
  List<Object> get props => [links ?? []];
}

class LinksLoadSuccess extends LinksState {
  const LinksLoadSuccess({required this.links});

  final List<LinkModel> links;

  @override
  List<Object> get props => [links];
}

class LinksLoadFailure extends LinksState {
  const LinksLoadFailure({this.loadState = LoadState.genericError});

  final LoadState loadState;

  @override
  List<Object> get props => [loadState];
}
