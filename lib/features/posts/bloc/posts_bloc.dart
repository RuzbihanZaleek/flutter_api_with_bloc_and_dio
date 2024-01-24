import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_api_request_with_bloc_and_dio/data/cart_items.dart';
import 'package:flutter_api_request_with_bloc_and_dio/data/wishlist_items.dart';
import 'package:flutter_api_request_with_bloc_and_dio/features/posts/models/post_data_ui_model.dart';
import 'package:meta/meta.dart';

import '../repos/post_repo.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(_postsInitialFetchEvent);
    on<PostsAddEvent>(_postsAddEvent);
    on<PostWishlistButtonNavigateClickedEvent>(
        _postWishlistButtonNavigateClickedEvent);
    on<PostCartButtonNavigateClickedEvent>(_postCartButtonNavigateClickedEvent);
    on<PostWishlistButtonClickedEvent>(_postWishlistButtonClickedEvent);
    on<PostCartButtonClickedEvent>(_postCartButtonClickedEvent);
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
    emit(success ? PostAddSuccess() : PostAddFailure());
  }

  FutureOr<void> _postWishlistButtonNavigateClickedEvent(
      PostWishlistButtonNavigateClickedEvent event, Emitter<PostsState> emit) {
    print("Wish list navigate button clicked");
    emit(PostNavigateToWishlistPageActionState());
  }

  FutureOr<void> _postCartButtonNavigateClickedEvent(
      PostCartButtonNavigateClickedEvent event, Emitter<PostsState> emit) {
    print("Cart navigate button clicked");
    emit(PostNavigateToCartPageActionState());
  }

  FutureOr<void> _postWishlistButtonClickedEvent(
      PostWishlistButtonClickedEvent event, Emitter<PostsState> emit) {
    print("Wishlist post button clicked");
    wishlistItems.add(event.clickedWishlist);
    emit(PostWishListItemAddedActionState());
  }

  FutureOr<void> _postCartButtonClickedEvent(
      PostCartButtonClickedEvent event, Emitter<PostsState> emit) {
    print("Cart post button clicked");
    cartItems.add(event.clickedCartItems);
    emit(PostCartItemAddedActionState());
  }
}
