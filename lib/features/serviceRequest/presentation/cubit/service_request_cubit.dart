import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/serviceRequest/domain/usecases/get_requests_usecase.dart';
import '../../domain/entities/service_request.dart';
import '../../domain/usecases/create_service_request_usecase.dart';
import 'service_request_state.dart';

class ServiceRequestCubit extends Cubit<ServiceRequestState> {
  final CreateServiceRequestUseCase createUseCase;
  final GetRequestsUseCase getRequestsUseCase;
  final UpdateRequestStatus updateRequestStatus;

  ServiceRequestCubit(
    this.createUseCase,
    this.getRequestsUseCase,
    this.updateRequestStatus,
  ) : super(ServiceRequestInitial());

  Future<void> createRequest(ServiceRequest request) async {
    emit(ServiceRequestLoading());

    try {
      await createUseCase(request);

      await getServiceRequests(request.customerId);
    } catch (e) {
      emit(ServiceRequestError(e.toString()));
    }
  }

  Future<void> getServiceRequests(String customerId) async {
    emit(ServiceRequestLoading());

    try {
      final requests = await getRequestsUseCase(customerId);

      emit(ServiceRequestLoaded(requests));
    } catch (e) {
      emit(ServiceRequestError(e.toString()));
    }
  }
}
