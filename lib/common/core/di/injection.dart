import 'package:get_it/get_it.dart';
import 'package:servicenear/features/WorkerInfo/data/datasources/rating_remote_datasource.dart';
import 'package:servicenear/features/WorkerInfo/data/datasources/rating_remote_datasource_impl.dart';
import 'package:servicenear/features/WorkerInfo/data/repositories/worker_repository_impl.dart';
import 'package:servicenear/features/WorkerInfo/domain/repositories/worker_repository.dart';
import 'package:servicenear/features/WorkerInfo/domain/usecases/fetch_reviews_usecase.dart';
import 'package:servicenear/features/WorkerInfo/domain/usecases/sumbit_rating_usecase.dart';
import 'package:servicenear/features/WorkerInfo/presentation/cubit/worker_info_cubit.dart';
import 'package:servicenear/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:servicenear/features/auth/domain/repositories/user_repository.dart';
import 'package:servicenear/features/chat/data/datasources/chat_datasource.dart';
import 'package:servicenear/features/chat/data/datasources/chat_datasource_impl.dart';
import 'package:servicenear/features/chat/data/repositories/chat_repostories_impl.dart';
import 'package:servicenear/features/chat/domain/repositories/chat_repositories.dart';
import 'package:servicenear/features/chat/domain/usecases/get_all_chats_usecase.dart';
import 'package:servicenear/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:servicenear/features/chat/domain/usecases/make_all_chat_messages_read.dart';
import 'package:servicenear/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:servicenear/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Auth
import 'package:servicenear/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:servicenear/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:servicenear/features/auth/domain/repositories/auth_repository.dart';

// Home
import 'package:servicenear/features/home/data/datasource/home_remote_datasource.dart';
import 'package:servicenear/features/home/data/repositories/home_repository_impl.dart';
import 'package:servicenear/features/home/domain/repositories/home_repositories.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Supabase
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  /// UserRepository
  sl.registerLazySingleton<UserRepository>(() => UserRepository(sl()));

  /// ================= AUTH =================
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  /// ================= HOME =================
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));

  /// ================= RATING =================

  sl.registerLazySingleton<RatingRemoteDataSource>(
    () => RatingRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<WorkerRepository>(() => WorkerRepositoryImpl(sl()));

  sl.registerLazySingleton<SubmitRatingUseCase>(
    () => SubmitRatingUseCase(sl()),
  );

  sl.registerLazySingleton<FetchReviewsUseCase>(
    () => FetchReviewsUseCase(sl()),
  );

  sl.registerFactory<WorkerInfoCubit>(() => WorkerInfoCubit(sl(), sl()));

  /// ================= Chat =================

  sl.registerLazySingleton<ChatDataSource>(() => ChatDatasourceImpl(sl()));

  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));

  sl.registerLazySingleton<SendMessageUseCase>(() => SendMessageUseCase(sl()));

  sl.registerLazySingleton<GetMessagesUsecase>(() => GetMessagesUsecase(sl()));

  sl.registerLazySingleton<GetAllChatsUseCase>(() => GetAllChatsUseCase(sl()));
  sl.registerLazySingleton<MakeAllChatMessagesReadUseCase>(
    () => MakeAllChatMessagesReadUseCase(sl()),
  );

  sl.registerFactory<ChatCubit>(() => ChatCubit(sl(), sl(), sl(), sl()));
}
