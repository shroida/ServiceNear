import 'package:servicenear/features/WorkerInfo/domain/entities/rating_entity.dart';

abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingSuccess extends RatingState {}

class RatingLoaded extends RatingState {
  final List<RatingEntity> reviews;

  RatingLoaded(this.reviews);
}

class RatingError extends RatingState {
  final String message;
  RatingError(this.message);
}
