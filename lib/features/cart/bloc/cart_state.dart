part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<PostDataUiModel> cartItems;

  CartSuccessState({required this.cartItems});
}
