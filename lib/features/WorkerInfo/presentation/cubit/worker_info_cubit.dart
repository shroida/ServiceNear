import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/WorkerInfo/domain/usecases/fetch_reviews_usecase.dart';
import 'package:servicenear/features/WorkerInfo/domain/usecases/sumbit_rating_usecase.dart';
import 'package:servicenear/features/WorkerInfo/presentation/cubit/worker_info_state.dart';
import '../../domain/entities/rating_entity.dart';

class WorkerInfoCubit extends Cubit<RatingState> {
  final SubmitRatingUseCase submitRatingUseCase;
  final FetchReviewsUseCase fetchReviewsUseCase;

  WorkerInfoCubit(this.submitRatingUseCase, this.fetchReviewsUseCase)
    : super(RatingInitial());

  Future<void> submitRating(RatingEntity rating) async {
    emit(RatingLoading());

    try {
      await submitRatingUseCase(rating);

      final reviews = await fetchReviewsUseCase(rating.workerId);

      emit(RatingLoaded(reviews));
    } catch (e) {
      emit(RatingError(e.toString()));
    }
  }

  Future<void> fetchReviews(String workerId) async {
    emit(RatingLoading());

    try {
      final reviews = await fetchReviewsUseCase(workerId);
      emit(RatingLoaded(reviews));
    } catch (e) {
      emit(RatingError(e.toString()));
    }
  }
}
