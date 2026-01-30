import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/home/domain/repositories/home_repositories.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepository) : super(HomeInitial());
  final HomeRepository homeRepository;
  Future<void> fetchWorkers() async {
    emit(HomeLoading());
    try {
      final workers = await homeRepository.getWorkers();
      print('Fetched workers: ${workers.length}'); // debug
      emit(HomeLoaded(workers));
    } catch (e) {
      print('Error fetching workers: $e'); // debug
      emit(HomeError(e.toString()));
    }
  }
}
