import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_api_request_with_bloc_and_dio/data/wishlist_items.dart';
import 'package:meta/meta.dart';

import '../../posts/models/post_data_ui_model.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(_wishlistInitialEvent);
    on<WishlistRemoveEvent>(_wishlistRemoveEvent);
  }

  FutureOr<void> _wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(addedWishlistItems: wishlistItems));
  }

  FutureOr<void> _wishlistRemoveEvent(
      WishlistRemoveEvent event, Emitter<WishlistState> emit) {
    wishlistItems.remove(event.wishlistItemToDelete);
    emit(WishlistSuccessState(addedWishlistItems: wishlistItems));
  }
}
