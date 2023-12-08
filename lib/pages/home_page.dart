import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/globals.dart';
import 'package:project_zenith/pages/attendance_page.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/pages/duties_page.dart';
import 'package:project_zenith/pages/fresh_page.dart';
import 'package:project_zenith/pages/profile_page.dart';
import 'package:project_zenith/pages/rendertime_page.dart';
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
  late Widget initUserPage = ProfilePage(func: updateUsername,);

  final _cmController = ContextMenuController();

  late String name;

  Future<void> logoutFunc() async {
    await Authenticator.logout();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    clearAllData();

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
    if (workspaceNameController.text.length > 30) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title must not exceed 30 chars.")),
      );
      return;
    }

    Workspace? space = await gUser?.addWorkspace(
        workspaceNameController.text, workspaceDescriptionController.text);

    setState(() {
      gOwnedSpaces.add(space!);
    });

    
    for (Workspace workspace in gOwnedSpaces) {
      gLists.addAll(await workspace.getLists());
    }
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

  void updateUsername(String name) async {
    await gUser?.updateUsername(name);
    var newName = gUser!.username;
    setState(() {
      name = newName;
    });
  }

  Future<void> updateSharedWorkspaces(String code) async {
    Workspace? space = await gUser?.addSharedWorkspace(code);

    if (space == null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Workspace does not exist.")),
      );
      return;
    }

    setState(() => gSharedSpaces.add(space!));
  }

  @override
  Widget build(BuildContext context) {
    name = gUser!.username;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 330, maxWidth: 385),
            child: Container(
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
                                  name.toUpperCase(),
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
                                  imgPath: 'assets/build_icon.png',
                                  text: "Home",
                                  func: () {
                                    setState(() {
                                      initAdminPage = FreshPage();
                                    });
                                  },
                                ),
                                DrawOption(
                                  imgPath: 'assets/join_icon.png',
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
                                ),
                                DrawOption(
                                  imgPath: 'assets/later_icon.png',
                                  text: "Render Times",
                                  func: () {
                                    setState(() {
                                      initAdminPage = const RenderTimePage();
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
                                      initUserPage = ProfilePage(func: updateUsername,);
                                    },
                                  );
                                },
                              ),
                              DrawOption(
                                imgPath: "assets/join_icon.png",
                                text: "Duties",
                                func: () {
                                  setState(
                                    () {
                                      initUserPage = const DutiesPage();
                                    },
                                  );
                                },
                              ),
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
                                    workspaceNameController.clear();
                                    workspaceDescriptionController.clear();
                                    
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
                                      callback: (Workspace space) {
                                        gOwnedSpaces[index] = space;
                                        setState(() {
                                          thisSpace = gOwnedSpaces[index];
                                        });
                                        return thisSpace;
                                      }
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
                                      workspaceNameController.clear();
                                      
                                      return JoinWorkspaceDialog(
                                        codeController: workspaceNameController,
                                        updateFunc: updateSharedWorkspaces,
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
                                      callback: (Workspace space) {
                                        gSharedSpaces[index] = space;
                                        setState(() {
                                          thisSpace = gSharedSpaces[index];
                                        });
                                      }
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
            child: SelectionArea(
              child: LayoutBuilder(builder: (context, constraints) {
                if (gUser?.id == 'rISCknyu5dlIrfGrKyCp') {
                  return initAdminPage;
                }
              
                return initUserPage;
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkspaceTile extends StatefulWidget {
  final ContextMenuController controller;
  Workspace space;
  final bool owned;
  final Function(Workspace, bool) func;
  final Function(Workspace) callback;

  WorkspaceTile({
    super.key,
    required this.space,
    required this.controller,
    required this.owned,
    required this.func, 
    required this.callback,
  });

  @override
  State<WorkspaceTile> createState() => _WorkspaceTileState();
}

class _WorkspaceTileState extends State<WorkspaceTile> {
  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        DrawOption(
          imgPath: "assets/later_icon.png",
          text: widget.space.title,
          func: () async {
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkspacePage(workspace: widget.space),
                ),
              );
            }
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Transform.translate(
            offset: const Offset(-20, 5),
            child: MenuAnchor(
              builder: (BuildContext context, MenuController controller,
                  Widget? child) {
                return IconButton(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'Show menu',
                );
              },
              menuChildren: [
                MenuItemButton(
                  onPressed: () async {
                    await showDialog(
                      useSafeArea: false,
                      context: context,
                      builder: (context) {
                        return EditWorkspaceDialog(
                          workspace: widget.space,
                          func: (String name, String desc) async {
                            int index = gOwnedSpaces.indexWhere((element) => widget.space.id == element.id);
                            await gOwnedSpaces[index].updateWorkspaceDetails(name, desc);
                            setState(() {
                              widget.space = gOwnedSpaces[index];
                            });
                          },
                        );
                      },
                    );
                  },
                  child: const Text('Edit Workspace'),
                ),
                gUser!.id == widget.space.owner.id ? MenuItemButton(
                  onPressed: () async {
                    await gUser?.deleteWorkspace(widget.space);
                    widget.func(widget.space, widget.owned);
                  },
                  child: const Text('Delete'),
                ) : MenuItemButton(
                  onPressed: () async {
                    await gUser?.leaveWorkspace(widget.space);
                    widget.func(widget.space, widget.owned);
                  },
                  child: const Text('Leave'),
                )
              ]
            ),
          ),
        ),
      ],
    );

    // GestureDetector(
    //   onSecondaryTapDown: (details) => controller.show(
    //     context: context,
    //     contextMenuBuilder: (context) {
    //       return AdaptiveTextSelectionToolbar.buttonItems(
    //         anchors: TextSelectionToolbarAnchors(
    //           primaryAnchor: details.globalPosition,
    //         ),
    //         buttonItems: <ContextMenuButtonItem>[
    //           ContextMenuButtonItem(
    //             onPressed: () async {
    //               ContextMenuController.removeAny();
    //               await gUser?.deleteWorkspace(space);
    //               func(space, owned);
    //             },
    //             label: 'Delete',
    //           ),
    //         ],
    //       );
    //     },
    //   ),
    // );
  }
}
