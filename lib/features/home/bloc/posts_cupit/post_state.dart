import '../../../../models/post_model.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostsGetSuccess extends PostState {
  final List<PostModel> posts;
  PostsGetSuccess({required this.posts});
}

class PostAddSuccess extends PostState {}

class PostDeleteSuccess extends PostState {}

class PostError extends PostState {
  final String message;
  PostError(this.message);
}
