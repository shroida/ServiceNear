import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/service_request.dart';
import '../../domain/usecases/create_service_request_usecase.dart';
import 'service_request_state.dart';

class ServiceRequestCubit extends Cubit<ServiceRequestState> {
  final CreateServiceRequestUseCase createUseCase;

  ServiceRequestCubit(this.createUseCase) : super(ServiceRequestInitial());

  Future<void> createRequest(ServiceRequest request) async {
    emit(ServiceRequestLoading());

    try {
      await createUseCase(request);
      emit(ServiceRequestSuccess());
    } catch (e) {
      emit(ServiceRequestError(e.toString()));
    }
  }
}
