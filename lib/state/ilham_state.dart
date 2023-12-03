import 'package:equatable/equatable.dart';

abstract class IlhamState extends Equatable {
  const IlhamState();

  @override
  List<Object> get props => [];
}

class IlhamInitialState extends IlhamState {}

class IlhamLoadingState extends IlhamState {}

class IlhamLoadedState extends IlhamState {
  final List<Map<String, dynamic>> ilhamList;

  const IlhamLoadedState(this.ilhamList);

  @override
  List<Object> get props => [ilhamList];
}

class IlhamSuccessState extends IlhamState {

}

class IlhamErrorState extends IlhamState {
  final String error;

  const IlhamErrorState(this.error);

  @override
  List<Object> get props => [error];
}
