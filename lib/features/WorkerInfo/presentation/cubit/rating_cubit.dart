import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/WorkerInfo/domain/usecases/sumbit_rating_usecase.dart';
import 'package:servicenear/features/WorkerInfo/presentation/cubit/worker_info_state.dart';
import '../../domain/entities/rating_entity.dart';

class RatingCubit extends Cubit<RatingState> {
  final SubmitRatingUseCase submitRatingUseCase;

  RatingCubit(this.submitRatingUseCase) : super(RatingInitial()) {
    print("🔥 RatingCubit created");
  }

  Future<void> submitRating(RatingEntity rating) async {
    emit(RatingLoading());

    try {
      await submitRatingUseCase(rating);
      emit(RatingSuccess());
    } catch (e) {
      emit(RatingError(e.toString()));
    }
  }
}
