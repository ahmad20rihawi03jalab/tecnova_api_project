import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../helper/api.dart';
import '../../../../models/post_model.dart';
import 'post_state.dart';

class PostsCubit extends Cubit<PostState> {
  final Api api = Api();
  String url = "https://jsonplaceholder.typicode.com/posts";

  PostsCubit() : super(PostInitial());

  Future<void> getPosts() async {
    emit(PostLoading());
    try {
      final data = await api.get(url: url);
      List<PostModel> posts = (data as List)
          .map((item) => PostModel.fromJson(item))
          .toList();
      emit(PostsGetSuccess(posts: posts));
    } catch (e) {
      emit(PostError("$e.toString()"));
    }
  }

  Future<void> addPost(PostModel post) async {
    try {
      await api.post(url: url, body: post.toJson());
      emit(PostAddSuccess());
      await getPosts();
    } catch (e) {
      emit(PostError("فشل في إضافة العنصر: $e.toString()"));
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await api.delete(url: "$url/$id");

      emit(PostDeleteSuccess());
      await getPosts();
    } catch (e) {
      emit(PostError("فشل في حذف العنصر: $e"));
    }
  }
}
