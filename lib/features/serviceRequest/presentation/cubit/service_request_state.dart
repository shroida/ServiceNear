import 'package:servicenear/features/serviceRequest/domain/entities/service_request.dart';

abstract class ServiceRequestState {}

class ServiceRequestInitial extends ServiceRequestState {}

class ServiceRequestLoading extends ServiceRequestState {}

class ServiceRequestLoaded extends ServiceRequestState {
  final List<ServiceRequest> requests;

  ServiceRequestLoaded(this.requests);
}

class ServiceRequestSuccess extends ServiceRequestState {}

class ServiceRequestError extends ServiceRequestState {
  final String message;

  ServiceRequestError(this.message);
}
