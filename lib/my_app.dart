import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/bloc/posts_cupit/post_cupit.dart';
import 'features/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: BlocProvider(
        create: (context) => PostsCubit()..getPosts(),
        child: const HomePage(),
      ),
    );
  }
}
