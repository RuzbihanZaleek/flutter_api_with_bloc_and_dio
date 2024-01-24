part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

abstract class WishlistActionState {}

class WishlistInitial extends WishlistState {}

class WishlistSuccessState extends WishlistState {
  final List<PostDataUiModel> addedWishlistItems;

  WishlistSuccessState({required this.addedWishlistItems});
}

