import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trcnova_api_project/features/home/widgets/add_post.dart';
import 'bloc/posts_cupit/post_cupit.dart';
import 'bloc/posts_cupit/post_state.dart';
import 'widgets/post_cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showDeleteConfirmation(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("تأكيد الحذف"),
          content: const Text("هل أنت متأكد من أنك تريد حذف هذا المنشور؟"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("إلغاء", style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 193, 21, 8),
              ),
              onPressed: () {
                context.read<PostsCubit>().deletePost(postId);
                Navigator.pop(dialogContext);
              },
              child: const Text("حذف", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Posts Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: BlocConsumer<PostsCubit, PostState>(
        listener: (context, state) {
          if (state is PostDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم الحذف بنجاح'),
                backgroundColor: Color.fromARGB(255, 193, 21, 8),
              ),
            );
          } else if (state is PostAddSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تمت إضافة المنشور بنجاح!'),
                backgroundColor: Color(0xfffac638),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is PostError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Color.fromARGB(255, 193, 21, 8),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsGetSuccess) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return PostCart(
                  title: post.title,
                  body: post.body,
                  onDelete: () {
                    _showDeleteConfirmation(context, post.id!);
                  },
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text('لا توجد بيانات حالياً'));
        },
      ),
      floatingActionButton: Builder(
        builder: (fabContext) => FloatingActionButton(
          onPressed: () {
            final postsCubit = context.read<PostsCubit>();

            showDialog(
              context: context,
              builder: (dialogContext) {
                return BlocProvider.value(
                  value: postsCubit,
                  child: const PostDialog(),
                );
              },
            );
          },
          backgroundColor: const Color(0xfffac638),
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
