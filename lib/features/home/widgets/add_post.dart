import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trcnova_api_project/features/home/bloc/posts_cupit/post_cupit.dart';
import '../../../models/post_model.dart';

class PostDialog extends StatefulWidget {
  const PostDialog({super.key});

  @override
  State<PostDialog> createState() => _PostDialogState();
}

class _PostDialogState extends State<PostDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text("إضافة منشور جديد", textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                _titleController,
                "* عنوان المنشور",
                (value) => (value == null || value.trim().isEmpty)
                    ? "يجب تعبئة عنوان المنشور"
                    : null,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                _bodyController,
                "* نص المنشور",
                (value) => (value == null || value.trim().isEmpty)
                    ? "يجب تعبئة نص المنشور"
                    : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("إلغاء", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xfffac638),
          ),
          onPressed: () => _submitData(context),
          child: Text(
            "إضافة منشور",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String? Function(String?)? validator, {
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
      keyboardType: isNumber
          ? const TextInputType.numberWithOptions(decimal: true)
          : null,
      inputFormatters: isNumber
          ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))]
          : null,
      validator: validator,
    );
  }

  void _submitData(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final post = PostModel(
        title: _titleController.text,
        body: _bodyController.text,
      );
      context.read<PostsCubit>().addPost(post);
      Navigator.pop(context);
    }
  }
}
