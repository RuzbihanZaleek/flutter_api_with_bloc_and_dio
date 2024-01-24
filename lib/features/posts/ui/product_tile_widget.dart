import 'package:flutter/material.dart';

import '../bloc/posts_bloc.dart';
import '../models/post_data_ui_model.dart';

class ProductTileWidget extends StatelessWidget {
  final PostDataUiModel postDataUiModel;
  final PostsBloc postsBloc;

  const ProductTileWidget(
      {super.key, required this.postDataUiModel, required this.postsBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.black),
          color: Colors.grey.shade200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(postDataUiModel.title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 10),
          Text(postDataUiModel.body, style: const TextStyle(fontSize: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  postsBloc.add(PostWishlistButtonClickedEvent(
                      clickedWishlist: postDataUiModel));
                },
                icon: const Icon(Icons.favorite_border_outlined),
              ),
              IconButton(
                onPressed: () {
                  postsBloc.add(PostCartButtonClickedEvent(
                      clickedCartItems: postDataUiModel));
                },
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
