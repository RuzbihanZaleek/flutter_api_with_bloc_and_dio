import 'package:flutter/material.dart';
import 'package:flutter_api_request_with_bloc_and_dio/features/posts/bloc/posts_bloc.dart';
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
        title: const Text("Post Page"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          postsBloc.add(PostsAddEvent());
        },
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        listener: (context, state) {
          // TODO: implement listener
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
                    return Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      color: Colors.grey.shade200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(successState.posts[index].title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(successState.posts[index].body),
                        ],
                      ),
                    );
                  });
            case PostFetchingErrorState:
              return const Center(
                child: Text("Something Went Wrong",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              );
            // case PostAddSuccess:
            //   return AlertDialog(
            //     title: const Text("Post Added Successfully"),
            //     actions: [
            //       TextButton(
            //           onPressed: () => Navigator.pop(context),
            //           child: const Text('OK'))
            //     ],
            //   );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
