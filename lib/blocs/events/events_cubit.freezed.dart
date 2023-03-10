// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'events_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EventsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Models.DocumentList events) eventsListLoaded,
    required TResult Function(Models.Document event) eventLoaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Models.DocumentList events)? eventsListLoaded,
    TResult? Function(Models.Document event)? eventLoaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Models.DocumentList events)? eventsListLoaded,
    TResult Function(Models.Document event)? eventLoaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_EventsListLoaded value) eventsListLoaded,
    required TResult Function(_EventLoaded value) eventLoaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_EventsListLoaded value)? eventsListLoaded,
    TResult? Function(_EventLoaded value)? eventLoaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_EventsListLoaded value)? eventsListLoaded,
    TResult Function(_EventLoaded value)? eventLoaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventsStateCopyWith<$Res> {
  factory $EventsStateCopyWith(
          EventsState value, $Res Function(EventsState) then) =
      _$EventsStateCopyWithImpl<$Res, EventsState>;
}

/// @nodoc
class _$EventsStateCopyWithImpl<$Res, $Val extends EventsState>
    implements $EventsStateCopyWith<$Res> {
  _$EventsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$EventsStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'EventsState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Models.DocumentList events) eventsListLoaded,
    required TResult Function(Models.Document event) eventLoaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Models.DocumentList events)? eventsListLoaded,
    TResult? Function(Models.Document event)? eventLoaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Models.DocumentList events)? eventsListLoaded,
    TResult Function(Models.Document event)? eventLoaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_EventsListLoaded value) eventsListLoaded,
    required TResult Function(_EventLoaded value) eventLoaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_EventsListLoaded value)? eventsListLoaded,
    TResult? Function(_EventLoaded value)? eventLoaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_EventsListLoaded value)? eventsListLoaded,
    TResult Function(_EventLoaded value)? eventLoaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements EventsState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$EventsStateCopyWithImpl<$Res, _$_Loading>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading();

  @override
  String toString() {
    return 'EventsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Models.DocumentList events) eventsListLoaded,
    required TResult Function(Models.Document event) eventLoaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Models.DocumentList events)? eventsListLoaded,
    TResult? Function(Models.Document event)? eventLoaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Models.DocumentList events)? eventsListLoaded,
    TResult Function(Models.Document event)? eventLoaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_EventsListLoaded value) eventsListLoaded,
    required TResult Function(_EventLoaded value) eventLoaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_EventsListLoaded value)? eventsListLoaded,
    TResult? Function(_EventLoaded value)? eventLoaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_EventsListLoaded value)? eventsListLoaded,
    TResult Function(_EventLoaded value)? eventLoaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements EventsState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_EventsListLoadedCopyWith<$Res> {
  factory _$$_EventsListLoadedCopyWith(
          _$_EventsListLoaded value, $Res Function(_$_EventsListLoaded) then) =
      __$$_EventsListLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({Models.DocumentList events});
}

/// @nodoc
class __$$_EventsListLoadedCopyWithImpl<$Res>
    extends _$EventsStateCopyWithImpl<$Res, _$_EventsListLoaded>
    implements _$$_EventsListLoadedCopyWith<$Res> {
  __$$_EventsListLoadedCopyWithImpl(
      _$_EventsListLoaded _value, $Res Function(_$_EventsListLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? events = null,
  }) {
    return _then(_$_EventsListLoaded(
      null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as Models.DocumentList,
    ));
  }
}

/// @nodoc

class _$_EventsListLoaded implements _EventsListLoaded {
  const _$_EventsListLoaded(this.events);

  @override
  final Models.DocumentList events;

  @override
  String toString() {
    return 'EventsState.eventsListLoaded(events: $events)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventsListLoaded &&
            (identical(other.events, events) || other.events == events));
  }

  @override
  int get hashCode => Object.hash(runtimeType, events);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventsListLoadedCopyWith<_$_EventsListLoaded> get copyWith =>
      __$$_EventsListLoadedCopyWithImpl<_$_EventsListLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Models.DocumentList events) eventsListLoaded,
    required TResult Function(Models.Document event) eventLoaded,
  }) {
    return eventsListLoaded(events);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Models.DocumentList events)? eventsListLoaded,
    TResult? Function(Models.Document event)? eventLoaded,
  }) {
    return eventsListLoaded?.call(events);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Models.DocumentList events)? eventsListLoaded,
    TResult Function(Models.Document event)? eventLoaded,
    required TResult orElse(),
  }) {
    if (eventsListLoaded != null) {
      return eventsListLoaded(events);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_EventsListLoaded value) eventsListLoaded,
    required TResult Function(_EventLoaded value) eventLoaded,
  }) {
    return eventsListLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_EventsListLoaded value)? eventsListLoaded,
    TResult? Function(_EventLoaded value)? eventLoaded,
  }) {
    return eventsListLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_EventsListLoaded value)? eventsListLoaded,
    TResult Function(_EventLoaded value)? eventLoaded,
    required TResult orElse(),
  }) {
    if (eventsListLoaded != null) {
      return eventsListLoaded(this);
    }
    return orElse();
  }
}

abstract class _EventsListLoaded implements EventsState {
  const factory _EventsListLoaded(final Models.DocumentList events) =
      _$_EventsListLoaded;

  Models.DocumentList get events;
  @JsonKey(ignore: true)
  _$$_EventsListLoadedCopyWith<_$_EventsListLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_EventLoadedCopyWith<$Res> {
  factory _$$_EventLoadedCopyWith(
          _$_EventLoaded value, $Res Function(_$_EventLoaded) then) =
      __$$_EventLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({Models.Document event});
}

/// @nodoc
class __$$_EventLoadedCopyWithImpl<$Res>
    extends _$EventsStateCopyWithImpl<$Res, _$_EventLoaded>
    implements _$$_EventLoadedCopyWith<$Res> {
  __$$_EventLoadedCopyWithImpl(
      _$_EventLoaded _value, $Res Function(_$_EventLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
  }) {
    return _then(_$_EventLoaded(
      null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as Models.Document,
    ));
  }
}

/// @nodoc

class _$_EventLoaded implements _EventLoaded {
  const _$_EventLoaded(this.event);

  @override
  final Models.Document event;

  @override
  String toString() {
    return 'EventsState.eventLoaded(event: $event)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventLoaded &&
            (identical(other.event, event) || other.event == event));
  }

  @override
  int get hashCode => Object.hash(runtimeType, event);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventLoadedCopyWith<_$_EventLoaded> get copyWith =>
      __$$_EventLoadedCopyWithImpl<_$_EventLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Models.DocumentList events) eventsListLoaded,
    required TResult Function(Models.Document event) eventLoaded,
  }) {
    return eventLoaded(event);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Models.DocumentList events)? eventsListLoaded,
    TResult? Function(Models.Document event)? eventLoaded,
  }) {
    return eventLoaded?.call(event);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Models.DocumentList events)? eventsListLoaded,
    TResult Function(Models.Document event)? eventLoaded,
    required TResult orElse(),
  }) {
    if (eventLoaded != null) {
      return eventLoaded(event);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_EventsListLoaded value) eventsListLoaded,
    required TResult Function(_EventLoaded value) eventLoaded,
  }) {
    return eventLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_EventsListLoaded value)? eventsListLoaded,
    TResult? Function(_EventLoaded value)? eventLoaded,
  }) {
    return eventLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_EventsListLoaded value)? eventsListLoaded,
    TResult Function(_EventLoaded value)? eventLoaded,
    required TResult orElse(),
  }) {
    if (eventLoaded != null) {
      return eventLoaded(this);
    }
    return orElse();
  }
}

abstract class _EventLoaded implements EventsState {
  const factory _EventLoaded(final Models.Document event) = _$_EventLoaded;

  Models.Document get event;
  @JsonKey(ignore: true)
  _$$_EventLoadedCopyWith<_$_EventLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}
