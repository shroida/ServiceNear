import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/worker_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<WorkerModel>> getWorkers();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final SupabaseClient supabase;

  HomeRemoteDataSourceImpl(this.supabase);

  @override
  Future<List<WorkerModel>> getWorkers() async {
    final data = await supabase.from('workers').select();

    return (data as List).map((e) => WorkerModel.fromMap(e)).toList();
  }
}
