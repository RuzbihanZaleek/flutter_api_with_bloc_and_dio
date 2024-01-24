import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_api_request_with_bloc_and_dio/data/cart_items.dart';
import 'package:meta/meta.dart';

import '../../posts/models/post_data_ui_model.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(_cartInitialEvent);
    on<CartRemoveFromCartEvent>(_cartRemoveFromCartEvent);
  }

  FutureOr<void> _cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> _cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.cartItemToRemove);
    emit(CartSuccessState(cartItems: cartItems));
  }
}
