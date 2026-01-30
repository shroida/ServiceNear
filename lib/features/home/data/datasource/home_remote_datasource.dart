import 'package:servicenear/features/auth/data/models/worker_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HomeRemoteDataSource {
  Future<List<WorkerUserModel>> getWorkers();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final SupabaseClient supabase;

  HomeRemoteDataSourceImpl(this.supabase);

  @override
  Future<List<WorkerUserModel>> getWorkers() async {
    final data = await supabase.from('worker').select();

    return (data as List).map((e) => WorkerUserModel.fromJson(e)).toList();
  }
}
