import 'package:flutter/material.dart';
import 'package:flutter_api_request_with_bloc_and_dio/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_api_request_with_bloc_and_dio/features/wishlist/ui/wishlist_tile_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Wishlist Page", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                itemCount: successState.addedWishlistItems.length,
                itemBuilder: (context, index) {
                  return WishlistTileWidget(
                      postDataUiModel: successState.addedWishlistItems[index],
                      wishlistBloc: wishlistBloc);
                },
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
