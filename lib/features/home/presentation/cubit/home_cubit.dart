import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/home/domain/entities/worker_user_home_model.dart';
import 'package:servicenear/features/home/domain/repositories/home_repositories.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepository) : super(HomeInitial());
  final HomeRepository homeRepository;
  List<WorkerUserHomeModel> workers = [];
  Future<void> fetchWorkers() async {
    emit(HomeLoading());
    try {
      workers = await homeRepository.getWorkers();
      emit(HomeLoaded(workers));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
