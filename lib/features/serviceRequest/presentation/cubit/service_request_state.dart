import 'package:servicenear/features/serviceRequest/domain/entities/service.dart';
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

class ServiceLoading extends ServiceRequestState {}

class ServiceLoaded extends ServiceRequestState {
  final List<Service> services;

  ServiceLoaded(this.services);
}

class ServiceError extends ServiceRequestState {
  final String message;

  ServiceError(this.message);
}
