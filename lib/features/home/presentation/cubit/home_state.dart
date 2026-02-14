import 'package:servicenear/common/entities/worker.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Worker> workers;
  HomeLoaded(this.workers);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
