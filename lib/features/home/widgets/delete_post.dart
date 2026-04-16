import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/posts_cupit/post_cupit.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final int postId;

  const DeleteConfirmDialog({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Text("تأكيد الحذف"),
      content: const Text("هل أنت متأكد من أنك تريد حذف هذا المنشور؟"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("إلغاء", style: TextStyle(color: Colors.black)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 193, 21, 8),
          ),
          onPressed: () {
            context.read<PostsCubit>().deletePost(postId);
            Navigator.pop(context);
          },
          child: const Text("حذف", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
