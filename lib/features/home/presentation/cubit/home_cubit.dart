import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_workers_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetWorkersUseCase getWorkers;

  HomeCubit(this.getWorkers) : super(HomeInitial());

  Future<void> fetchWorkers() async {
    emit(HomeLoading());
    try {
      final workers = await getWorkers();
      emit(HomeLoaded(workers));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
