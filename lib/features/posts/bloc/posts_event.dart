part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class PostsInitialFetchEvent extends PostsEvent {}

class PostsAddEvent extends PostsEvent {}

class PostWishlistButtonClickedEvent extends PostsEvent {
  //passing data to the bloc through events
  final PostDataUiModel clickedWishlist;

  PostWishlistButtonClickedEvent({required this.clickedWishlist});
}

class PostCartButtonClickedEvent extends PostsEvent {
  //passing data to the bloc through events
  final PostDataUiModel clickedCartItems;

  PostCartButtonClickedEvent({required this.clickedCartItems});
}

class PostWishlistButtonNavigateClickedEvent extends PostsEvent {}

class PostCartButtonNavigateClickedEvent extends PostsEvent {}
