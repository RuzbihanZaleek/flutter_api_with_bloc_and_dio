part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistRemoveEvent extends WishlistEvent {
  final PostDataUiModel wishlistItemToDelete;

  WishlistRemoveEvent({required this.wishlistItemToDelete});
}
