import 'package:servicenear/common/entities/worker.dart';

import '../../domain/repositories/home_repositories.dart';
import '../datasource/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Worker>> getWorkers() async {
    final models = await remoteDataSource.getWorkers();

    return models
        .map(
          (m) => Worker(
            id: m.id,
            firstName: m.firstName,
            lastName: m.lastName,
            email: m.email,
            phoneNumber: m.phoneNumber,
            userType: m.userType,
            location: m.location,
            createdAt: m.createdAt,
            specialty: m.specialty,
            about: m.about,
            address: m.address,
            rating: m.rating,
            reviewsCount: m.reviewsCount,
          ),
        )
        .toList();
  }
}
