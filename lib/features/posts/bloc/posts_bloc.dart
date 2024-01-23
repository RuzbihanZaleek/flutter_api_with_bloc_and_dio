import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_api_request_with_bloc_and_dio/features/posts/models/post_data_ui_model.dart';
import 'package:meta/meta.dart';

import '../repos/post_repo.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(_postsInitialFetchEvent);
    on<PostsAddEvent>(_postsAddEvent);
  }

  FutureOr<void> _postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostFetchingLoadingState());
    List<PostDataUiModel> posts = await PostRepo.fetchPosts();
    emit(PostFetchingSuccess(posts: posts));
  }

  FutureOr<void> _postsAddEvent(
      PostsAddEvent event, Emitter<PostsState> emit) async {
    bool success = await PostRepo.postData();
    print(success);
    // emit(success ? PostAddSuccess() : PostAddFailure());
    if (success) {
      emit(PostAddSuccess());
    } else {
      emit(PostAddFailure());
    }
  }
}
