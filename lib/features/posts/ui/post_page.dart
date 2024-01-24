import 'package:flutter/material.dart';
import 'package:flutter_api_request_with_bloc_and_dio/features/cart/ui/cart.dart';
import 'package:flutter_api_request_with_bloc_and_dio/features/posts/bloc/posts_bloc.dart';
import 'package:flutter_api_request_with_bloc_and_dio/features/posts/ui/product_tile_widget.dart';
import 'package:flutter_api_request_with_bloc_and_dio/features/wishlist/ui/wishlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Page", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              onPressed: () {
                postsBloc.add(PostWishlistButtonNavigateClickedEvent());
              },
              icon: const Icon(Icons.favorite_border_outlined),
              color: Colors.white),
          IconButton(
              onPressed: () {
                postsBloc.add(PostCartButtonNavigateClickedEvent());
              },
              icon: const Icon(Icons.shopping_bag_outlined),
              color: Colors.white),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          postsBloc.add(PostsAddEvent());
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        listener: (context, state) {
          if (state is PostAddSuccess) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Post Added Successfully"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'))
                ],
              ),
            );
          } else if (state is PostAddFailure) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Post Add Failed"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'))
                ],
              ),
            );
          } else if (state is PostNavigateToWishlistPageActionState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Wishlist()));
          } else if (state is PostNavigateToCartPageActionState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Cart()));
          } else if (state is PostWishListItemAddedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Item added to the wishlist")));
          } else if (state is PostCartItemAddedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Item added to the cart")));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostFetchingLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostFetchingSuccess:
              final successState = state as PostFetchingSuccess;
              return ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                        postDataUiModel: successState.posts[index],
                        postsBloc: postsBloc);
                  });
            case PostFetchingErrorState:
              return const Center(
                child: Text("Something Went Wrong",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
