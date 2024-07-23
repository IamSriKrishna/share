import 'dart:async';

import 'package:crud/bloc/user/user_bloc.dart';
import 'package:crud/bloc/user/user_event.dart';
import 'package:crud/controller/home/home_widget.dart';
import 'package:crud/core/util/net.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  final ConnectivityService _connectivityService = ConnectivityService();

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(ReadUserEvent());

    // Listen to connectivity changes
    connectivitySubscription = _connectivityService.connectivityStream.listen((result) {
      if (result == ConnectivityResult.none) {
        showSnackbar('You are offline', Colors.red);
      } else {
        showSnackbar('You are online', Colors.green);
        context.read<UserBloc>().add(ReadUserEvent()); // Sync data when online
      }
    });
  }

  void showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
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
