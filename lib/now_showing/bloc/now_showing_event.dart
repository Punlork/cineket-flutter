part of 'now_showing_bloc.dart';

@immutable
sealed class NowShowingEvent {}

final class NowShowingRequested extends NowShowingEvent {}
