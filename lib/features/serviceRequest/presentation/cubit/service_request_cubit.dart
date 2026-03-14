import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/serviceRequest/domain/usecases/get_booked_service_usecase.dart';
import 'package:servicenear/features/serviceRequest/domain/usecases/get_requests_usecase.dart';
import 'package:servicenear/features/serviceRequest/domain/usecases/get_services_usecase.dart';
import 'package:servicenear/features/serviceRequest/domain/usecases/update_request_status.dart';
import '../../domain/entities/service_request.dart';
import '../../domain/usecases/create_service_request_usecase.dart';
import 'service_request_state.dart';

class ServiceRequestCubit extends Cubit<ServiceRequestState> {
  final CreateServiceRequestUseCase createUseCase;
  final GetRequestsUseCase getRequestsUseCase;
  final UpdateRequestStatus updateRequestStatus;
  final GetServicesUsecase getServicesUsecase;
  final GetBookedServicesUseCase getBookedServicesUseCase;

  ServiceRequestCubit(
    this.createUseCase,
    this.getBookedServicesUseCase,
    this.getRequestsUseCase,
    this.updateRequestStatus,
    this.getServicesUsecase,
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

  Future<void> fetchServices([String? specialty]) async {
    emit(ServiceLoading());

    try {
      final services = await getServicesUsecase.call(specialty ?? '');

      emit(ServiceLoaded(services));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }

  // service_request_cubit.dart
  Future<void> fetchBookedServices(String customerId) async {
    emit(ServiceRequestLoading());

    try {
      print('📡 Cubit fetching booked services for customerId=$customerId');
      final requests = await getBookedServicesUseCase(customerId);
      print('📥 Cubit received ${requests.length} requests: $requests');

      emit(ServiceRequestLoaded(requests));
    } catch (e, stack) {
      print('❌ Cubit error fetching booked services: $e\n$stack');
      emit(ServiceRequestError('Failed to load bookings'));
    }
  }
}
