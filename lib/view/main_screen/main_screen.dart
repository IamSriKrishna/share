import 'package:crud/bloc/user/user_bloc.dart';
import 'package:crud/bloc/user/user_event.dart';
import 'package:crud/controller/home/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    context.read<UserBloc>().add(ReadUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          HomeWidget.homeAppBar(),
          HomeWidget.titleAppointment(),
          HomeWidget.nameTextField(context: context),
          HomeWidget.displayDateandTime(),
          HomeWidget.bookElevatedBtn(context: context),
          HomeWidget.searchUser(),
          HomeWidget.displayUsers(context: context)
        ],
      ),
    );
  }
}
