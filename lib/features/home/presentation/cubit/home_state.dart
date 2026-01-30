import 'package:servicenear/features/auth/data/models/worker_user_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<WorkerUserHomeModel> workers;
  HomeLoaded(this.workers);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
