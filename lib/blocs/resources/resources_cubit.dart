import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as Models;
import 'package:bloc/bloc.dart';
import 'package:face_to_face_voting/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'resources_state.dart';
part 'resources_cubit.freezed.dart';

class ResourcesCubit extends Cubit<ResourcesState> {
  ResourcesCubit({
    required this.databases,
  }) : super(const ResourcesState.initial());

  final Databases databases;

  Future<void> processRealtimeEvent(RealtimeMessage message) async {
    final payload = message.payload;
    final doc = Models.Document.fromMap(payload);

    if (doc.$collectionId == resourcesCollectionId) {
      await _loadResources();
    }
  }

  Future<void> _loadResources() async {
    final documentResponse = await databases.listDocuments(
      databaseId: databaseId,
      collectionId: resourcesCollectionId,
      queries: [Query.limit(100)],
    );

    // sort by document.$createdAt
    final sorted = documentResponse.documents.toList()
      ..sort((a, b) =>
          DateTime.parse(b.$createdAt).compareTo(DateTime.parse(a.$createdAt)));

    emit(ResourcesState.loaded(sorted));
  }

  Future<void> loadResources() async {
    try {
      emit(const ResourcesState.loading());
      await _loadResources();
    } catch (e) {
      emit(ResourcesState.error(e.toString()));
    }
  }
}
