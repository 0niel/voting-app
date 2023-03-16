import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as Models;
import 'package:bloc/bloc.dart';
import 'package:face_to_face_voting/data/models/user.dart';
import 'package:face_to_face_voting/data/sources/remote_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_users_state.dart';
part 'search_users_cubit.freezed.dart';

class SearchUsersCubit extends Cubit<SearchUsersState> {
  SearchUsersCubit({
    required this.teams,
    required this.account,
    required this.remoteData,
  }) : super(const SearchUsersState.initial());

  final Account account;
  final Teams teams;
  final RemoteData remoteData;

  void searchUsers(Models.Document event, String query) async {
    emit(const SearchUsersState.loading());

    try {
      final jwt = await account.createJWT();

      final users = await remoteData.searchUsers(event.$id, query, jwt.jwt);

      final teamId = event.data['participants_team_id'];
      final teamMemberships = await teams.listMemberships(teamId: teamId);

      final usersWithStatus = users.map((user) {
        final isParticipant = teamMemberships.memberships
            .any((membership) => membership.userId == user.id);

        return MapEntry(user, isParticipant);
      }).toList();

      emit(SearchUsersState.loaded(usersWithStatus));
    } catch (e) {
      emit(SearchUsersState.error(e.toString()));
    }
  }
}
