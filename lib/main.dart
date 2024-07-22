import 'package:crud/bloc/field/field_bloc.dart';
import 'package:crud/bloc/search/search_bloc.dart';
import 'package:crud/bloc/user/user_bloc.dart';
import 'package:crud/repo/repo.dart';
import 'package:crud/view/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() {
  UserRepository _repository = UserRepository();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => UserBloc(_repository),
    ),
    BlocProvider(
      create: (context) => FieldBloc(),
    ),
    BlocProvider(
      create: (context) => SearchBloc(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const MainScreen(),
    );
  }
}
