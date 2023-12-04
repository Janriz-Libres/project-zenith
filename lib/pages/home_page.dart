import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/globals.dart';
import 'package:project_zenith/pages/attendance_page.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/pages/fresh_page.dart';
import 'package:project_zenith/pages/profile_page.dart';
import 'package:project_zenith/pages/workspace_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final workspaceNameController = TextEditingController();
  final workspaceDescriptionController = TextEditingController();
  final codeController = TextEditingController();

  Widget initAdminPage = FreshPage();
  Widget initUserPage = const ProfilePage();

  final ContextMenuController _cmController = ContextMenuController();

  Future<void> logoutFunc() async {
    await Authenticator.logout();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    gOwnedSpaces.clear();
    gSharedSpaces.clear();
    // lists.clear();
    // tasks.clear();
    gUser = null;

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ),
      );
    }
  }

  Future<void> updateWorkspaces() async {
    Workspace? space = await gUser?.addWorkspace(
        workspaceNameController.text, workspaceDescriptionController.text);

    setState(() {
      gOwnedSpaces.add(space!);
    });
  }

  void reflectDeletedSpaces(Workspace space, bool owned) {
    setState(() {
      if (owned) {
        gOwnedSpaces.remove(space);
        return;
      }

      gSharedSpaces.remove(space);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: Row(
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(minWidth: 330, maxWidth: 385),
              padding: const EdgeInsets.only(top: 25),
              decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(2, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 29),
                      child: Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: const ShapeDecoration(
                              color: Color(0xFF313638),
                              shape: OvalBorder(),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 18,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  gUser!.username,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                Text(
                                  gUser!.email,
                                  style: const TextStyle(
                                    color: Color(0xFF636769),
                                    fontSize: 15,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    LayoutBuilder(builder: (context, constraints) {
                      if (gUser?.id == 'rISCknyu5dlIrfGrKyCp') {
                        return SidebarList(
                          children: [
                            SizedBox(
                              child: Column(children: [
                                const Divider(),
                                DrawOption(
                                  imgPath: "assets/white_logo.png",
                                  text: "Logout",
                                  func: () async {
                                    await logoutFunc();
                                  },
                                ),
                                DrawOption(
                                  imgPath: 'assets/join_icon.png',
                                  text: "Home",
                                  func: () {
                                    setState(() {
                                      initAdminPage = FreshPage();
                                    });
                                  },
                                ),
                                DrawOption(
                                  imgPath: 'assets/later_icon.png',
                                  text: "Attendance",
                                  func: () {
                                    setState(() {
                                      initAdminPage = const AttendancePage();
                                      checkedInUsers.forEach((key, value) {
                                        Duration interval = DateTime.now()
                                            .toUtc()
                                            .difference(
                                                key.timeStarted.toUtc());
                                        checkedInUsers[key] = interval;
                                      });
                                    });
                                  },
                                )
                              ]),
                            ),
                          ],
                        );
                      }

                      return SidebarList(children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DrawOption(
                                imgPath: "assets/white_logo.png",
                                text: "Logout",
                                func: () async => await logoutFunc(),
                              ),
                              DrawOption(
                                imgPath: "assets/build_icon.png",
                                text: "Profile",
                                func: () {
                                  setState(
                                    () {
                                      initUserPage = const ProfilePage();
                                    },
                                  );
                                },
                              ),
                              DrawOption(
                                imgPath: 'assets/join_icon.png',
                                text: "Attendance",
                                func: () {
                                  setState(
                                    () {
                                      initAdminPage = const AttendancePage();
                                      initUserPage = const AttendancePage();
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(children: [
                            const Text(
                              'WORKSPACE',
                              style: TextStyle(
                                color: Color(0xFF959A9C),
                                fontSize: 16,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () async {
                                await showDialog(
                                  useSafeArea: false,
                                  context: context,
                                  builder: (context) {
                                    return CreateWorkspaceDialog(
                                      workspaceNameController:
                                          workspaceNameController,
                                      workspaceDescriptionController:
                                          workspaceDescriptionController,
                                      func: updateWorkspaces,
                                    );
                                  },
                                );
                              },
                            )
                          ]),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxHeight: 150),
                          child: gOwnedSpaces.isEmpty
                              ? const Column(
                                  mainAxisSize: MainAxisSize.min,
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: gOwnedSpaces.length,
                                  itemBuilder: (context, index) {
                                    Workspace thisSpace =
                                        gOwnedSpaces.elementAt(index);

                                    return WorkspaceTile(
                                      space: thisSpace,
                                      controller: _cmController,
                                      owned: true,
                                      func: reflectDeletedSpaces,
                                    );
                                  }),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            children: [
                              const Text('SHARED',
                                  style: TextStyle(
                                    color: Color(0xFF959A9C),
                                    fontSize: 16,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  )),
                              const SizedBox(width: 10),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () async {
                                  await showDialog(
                                    useSafeArea: false,
                                    context: context,
                                    builder: (context) {
                                      return JoinWorkspaceDialog(
                                        codeController: workspaceNameController,
                                      );
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxHeight: 150),
                          child: gSharedSpaces.isEmpty
                              ? const Column(
                                  mainAxisSize: MainAxisSize.min,
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: gSharedSpaces.length,
                                  itemBuilder: (context, index) {
                                    Workspace thisSpace =
                                        gSharedSpaces.elementAt(index);

                                    return WorkspaceTile(
                                      space: thisSpace,
                                      controller: _cmController,
                                      owned: false,
                                      func: reflectDeletedSpaces,
                                    );
                                  },
                                ),
                        ),
                      ]);
                    }),
                  ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: LayoutBuilder(builder: (context, constraints) {
              if (gUser?.id == 'rISCknyu5dlIrfGrKyCp') {
                return initAdminPage;
              }

              return initUserPage;
            }),
          ),
        ],
      ),
    );
  }
}

class WorkspaceTile extends StatelessWidget {
  final ContextMenuController controller;
  final Workspace space;
  final bool owned;
  final Function(Workspace, bool) func;

  const WorkspaceTile({
    super.key,
    required this.space,
    required this.controller,
    required this.owned,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (details) => controller.show(
        context: context,
        contextMenuBuilder: (context) {
          return AdaptiveTextSelectionToolbar.buttonItems(
            anchors: TextSelectionToolbarAnchors(
              primaryAnchor: details.globalPosition,
            ),
            buttonItems: <ContextMenuButtonItem>[
              ContextMenuButtonItem(
                onPressed: () async {
                  ContextMenuController.removeAny();
                  await gUser?.deleteWorkspace(space);
                  func(space, owned);
                },
                label: 'Delete',
              ),
            ],
          );
        },
      ),
      child: DrawOption(
        imgPath: "assets/later_icon.png",
        text: space.title.toString(),
        func: () async {
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkspacePage(workspace: space),
              ),
            );
          }
        },
      ),
    );
  }
}
