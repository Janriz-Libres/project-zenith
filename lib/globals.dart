import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';

User? gUser;
List<User> gAllUsers = <User>[];
List<Workspace> gOwnedSpaces = <Workspace>[];
List<Workspace> gSharedSpaces = <Workspace>[];
List<WorkList> gLists = <WorkList>[];
List<Task> gTasks = <Task>[];

Future<void> initDataModels() async {
  gAllUsers = await getAllUsers();
  gOwnedSpaces = await gUser!.getOwnedWorkspaces();
  gSharedSpaces = await gUser!.getSharedWorkspaces();

  for (Workspace space in gOwnedSpaces) {
    gLists.addAll(await space.getLists());
  }

  for (Workspace space in gSharedSpaces) {
    gLists.addAll(await space.getLists());
  }

  for (WorkList list in gLists) {
    gTasks.addAll(await list.getTasks());
  }
}

void clearAllData() {
  gUser = null;
  gAllUsers.clear();
  gOwnedSpaces.clear();
  gSharedSpaces.clear();
  gLists.clear();
  gTasks.clear();
}

enum CustomIcon<String> {
  cyan("assets/build_icon.png"),
  magenta("assets/join_icon.png"),
  yellow("assets/later_icon.png"),
  black("assets/extra_icon.png"),
  white("assets/white_logo.png");

  const CustomIcon(this.asset);
  final String asset;
}

extension IconOptions<String> on CustomIcon<String> {
  static CustomIcon generateRandomIcon() {
    var rnd = Random();
    return CustomIcon.values[rnd.nextInt(CustomIcon.values.length)];
  }
}

enum CustomColors<Colors> {
  cyan(Color(0xFF06BCC1)),
  magenta(Color(0xFFD4515D)),
  yellow(Color(0xFFFFE66D)),
  black(Color(0xFF313638));

  const CustomColors(this.color);
  final Color color;
}

extension ColorsOption<Colors> on CustomColors<Colors> {
  static CustomColors generateRandomColor() {
    var rnd = Random();
    return CustomColors.values[rnd.nextInt(CustomColors.values.length)];
  }
}
