import 'package:flutter/material.dart';
import 'package:flutter_api_request_with_bloc_and_dio/features/wishlist/bloc/wishlist_bloc.dart';

import '../../posts/models/post_data_ui_model.dart';

class WishlistTileWidget extends StatelessWidget {
  final PostDataUiModel postDataUiModel;
  final WishlistBloc wishlistBloc;

  const WishlistTileWidget(
      {super.key, required this.postDataUiModel, required this.wishlistBloc});

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
                  wishlistBloc.add(WishlistRemoveEvent(
                      wishlistItemToDelete: postDataUiModel));
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
