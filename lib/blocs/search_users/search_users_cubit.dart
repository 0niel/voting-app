import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as Models;
import 'package:bloc/bloc.dart';
import 'package:face_to_face_voting/data/models/user.dart';
import 'package:face_to_face_voting/data/sources/remote_data.dart';
import 'package:face_to_face_voting/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_users_state.dart';
part 'search_users_cubit.freezed.dart';

class SearchUsersCubit extends Cubit<SearchUsersState> {
  SearchUsersCubit({
    required this.avatars,
    required this.teams,
    required this.account,
    required this.remoteData,
  }) : super(const SearchUsersState.initial());

  final Avatars avatars;
  final Account account;
  final Teams teams;
  final RemoteData remoteData;

  void searchUsers(Models.Document event, String query) async {
    emit(const SearchUsersState.loading());

    try {
      final jwt = await account.createJWT();

      final users = await remoteData.searchUsers(event.$id, query, jwt.jwt);

      final teamId = event.data['participants_team_id'];
      final teamMemberships = await teams
          .listMemberships(teamId: teamId, queries: [Query.limit(1000)]);

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

  void getUser(Models.Document event, String userId) async {
    emit(const SearchUsersState.loading());

    try {
      final jwt = await account.createJWT();

      final teamId = event.data['participants_team_id'];
      final teamMemberships = await teams
          .listMemberships(teamId: teamId, queries: [Query.limit(1000)]);

      final isParticipant = teamMemberships.memberships
          .any((membership) => membership.userId == userId);

      final user = await remoteData.getUser(event.$id, userId, jwt.jwt);

      final avatarByteList = await avatars.getInitials(
        name: StringFormatter.cyryllicToLat(user.name),
      );

      final avatar = Image.memory(avatarByteList);

      emit(SearchUsersState.loadedUser(MapEntry(user, isParticipant), avatar));
    } catch (e) {
      emit(SearchUsersState.error(e.toString()));
    }
  }
}
