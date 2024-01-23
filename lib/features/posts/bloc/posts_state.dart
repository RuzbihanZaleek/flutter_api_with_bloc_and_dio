part of 'posts_bloc.dart';

@immutable
abstract class PostsState {} // for listeners

abstract class PostActionState extends PostsState {} //for builders

class PostsInitial extends PostsState {}

class PostFetchingLoadingState extends PostsState {}

class PostFetchingErrorState extends PostsState {}

class PostFetchingSuccess extends PostsState {
  final List<PostDataUiModel> posts;

  PostFetchingSuccess({required this.posts});
}

class PostAddSuccess extends PostActionState {}

class PostAddFailure extends PostActionState {}
