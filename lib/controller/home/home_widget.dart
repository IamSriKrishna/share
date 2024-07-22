import 'package:crud/bloc/field/field_bloc.dart';
import 'package:crud/bloc/field/field_event.dart';
import 'package:crud/bloc/field/field_state.dart';
import 'package:crud/bloc/search/search_bloc.dart';
import 'package:crud/bloc/search/search_event.dart';
import 'package:crud/bloc/search/search_state.dart';
import 'package:crud/bloc/user/user_bloc.dart';
import 'package:crud/bloc/user/user_event.dart';
import 'package:crud/bloc/user/user_state.dart';
import 'package:crud/core/constrains/content.dart';
import 'package:crud/core/constrains/theme.dart';
import 'package:crud/core/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeWidget {
  //Home App bar
  static SliverAppBar homeAppBar() {
    return const SliverAppBar(
      floating: true,
      backgroundColor: AppTheme.theme,
      centerTitle: true,
      title: Text(
        Content.title,
        style: TextStyle(color: AppTheme.white),
      ),
    );
  }

  //Display Title Appointment text widget in home screen
  static SliverToBoxAdapter titleAppointment() {
    return SliverToBoxAdapter(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: const Text(
            Content.bookAppointment,
            style: TextStyle(color: AppTheme.theme, fontSize: 24),
          )),
    );
  }

  //Display name textfield to create a user by name in home screen
  static SliverToBoxAdapter nameTextField({required BuildContext context}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: BlocBuilder<FieldBloc, FieldState>(
          bloc: fieldBloc,
          builder: (context, state) {
            return TextField(
              onChanged: (value) => fieldBloc.add(ReadTextEvent(text: value)),
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  hintText: Content.name,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: AppTheme.theme)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: AppTheme.theme))),
            );
          },
        ),
      ),
    );
  }

  //Display date and time widget in home screen
  static SliverPadding displayDateandTime() {
    return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        sliver: SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    Content.date,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      DateFormat("dd-MM-yyyy").format(DateTime.now()),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    Content.time,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      DateFormat("hh:mm").format(DateTime.now()),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  //display book elevatedbutton widget in homescreen
  static SliverToBoxAdapter bookElevatedBtn({required BuildContext context}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocBuilder<FieldBloc, FieldState>(
          bloc: fieldBloc,
          builder: (context, state) {
            return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    fixedSize: const Size(240, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.5)),
                    backgroundColor: AppTheme.theme,
                    foregroundColor: AppTheme.white),
                onPressed: () {
                  if (state.text.isNotEmpty) {
                    context
                        .read<UserBloc>()
                        .add(CreateUserEvent(name: state.text));
                  } else {
                    debugPrint("Field is empty");
                  }
                },
                child: const Text(Content.book));
          },
        ),
      ),
    );
  }

  //display search Field widget to find users in home screen
  static SliverToBoxAdapter searchUser() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Row(
          children: [
            Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
              bloc: searchBloc,
              builder: (context, state) {
                return TextField(
                  onChanged: (value) => context
                      .read<SearchBloc>()
                      .add(SearchTextEvent(text: value)),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: Content.search,
                      contentPadding: const EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: AppTheme.theme)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: AppTheme.theme))),
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 40),
                      backgroundColor: AppTheme.theme,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {},
                  child: const Text(Content.search)),
            )
          ],
        ),
      ),
    );
  }

  static BlocBuilder<UserBloc, UserState> displayUsers(
      {required BuildContext context}) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoadingState) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (userState is UserErrorState) {
          return SliverToBoxAdapter(
            child: Center(child: Text(userState.error)),
          );
        }
        if (userState is ReadUserState) {
          return BlocBuilder<SearchBloc, SearchState>(
            builder: (context, fieldState) {
              final filteredUsers = userState.userModel.data
                  .where((user) => user.name
                      .toLowerCase()
                      .contains(fieldState.text.toLowerCase()))
                  .toList();

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: index == 0 ? 0 : 10, left: 10, right: 10),
                      child: InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (_) => CupertinoAlertDialog(
                              title: const Text("Warning!"),
                              content: const Text(
                                  "Do you want to delete this booking?"),
                              actions: [
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    context.read<UserBloc>().add(
                                          DeleteUserEvent(
                                            name: filteredUsers[index].name,
                                          ),
                                        );
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text("OK"),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text("Cancel"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 2),
                                blurRadius: 1,
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("$index"),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(filteredUsers[index].name),
                                  Text(filteredUsers[index].email),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text("${filteredUsers[index].age}"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: filteredUsers.length,
                ),
              );
            },
          );
        }
        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }
}
