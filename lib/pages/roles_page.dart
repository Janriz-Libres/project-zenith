import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';

enum RolesWidget { view, edit }

class RolesPage extends StatefulWidget {
  final Workspace space;

  const RolesPage({
    super.key,
    required this.space,
  });

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  RolesWidget rolesWidget = RolesWidget.view;
  Role? roleToEdit;

  void toEditMode(Role role) {
    setState(() {
      rolesWidget = RolesWidget.edit;
      roleToEdit = role;
    });
  }

  void toViewMode(Role oldRole, Role newRole) {
    setState(() {
      rolesWidget = RolesWidget.view;
      widget.space.roles.remove(oldRole);
      widget.space.roles.add(newRole);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (rolesWidget) {
          case RolesWidget.view:
            return ViewRolesPage(
              space: widget.space,
              toEditModeCopy: toEditMode,
            );
          case RolesWidget.edit:
            return EditRolePage(
              role: roleToEdit!,
              toViewModeFunc: toViewMode,
            );
          default:
            throw Exception();
        }
      },
    );
  }
}

class ViewRolesPage extends StatefulWidget {
  final Workspace space;
  final Function(Role) toEditModeCopy;

  const ViewRolesPage({
    super.key,
    required this.space,
    required this.toEditModeCopy,
  });

  @override
  State<ViewRolesPage> createState() => _ViewRolesPageState();
}

class _ViewRolesPageState extends State<ViewRolesPage> {
  var nameController = TextEditingController();
  var descController = TextEditingController();

  Future<void> addRole() async {
    Role newRole =
        await widget.space.addRole(nameController.text, descController.text);

    if (context.mounted) {
      Navigator.pop(context);
    }

    setState(() {
      widget.space.roles.add(newRole);
    });
  }

  Future<void> removeRole(Role role) async {
    await widget.space.removeRole(role);

    setState(() {
      widget.space.roles.remove(role);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: () async {
            await showDialog(
              useSafeArea: false,
              context: context,
              builder: (context) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: AlertDialog(
                    content: SizedBox(
                      width: 350,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          const Text("Name:"),
                          TextFormField(controller: nameController),
                          const Text("Description:"),
                          TextFormField(controller: descController),
                          ElevatedButton(
                            child: const Text("Enter"),
                            onPressed: () async {
                              await addRole();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Text("Add Role"),
        ),
      ),
      Column(
        children: widget.space.roles.map((e) {
          if (e.name == 'owner' || e.name == 'member') {
            return Container();
          }

          return Card(
            color: const Color(0xFFD4515D),
            child: Row(
              children: [
                Text(e.name),
                const SizedBox(width: 20),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    widget.toEditModeCopy(e);
                  },
                  child: const Text("Edit Permissions"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await removeRole(e);
                  },
                  child: const Text("Delete"),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ]);
  }
}

class EditRolePage extends StatefulWidget {
  final Role role;
  final Function(Role, Role) toViewModeFunc;

  const EditRolePage({
    super.key,
    required this.role,
    required this.toViewModeFunc,
  });

  @override
  State<EditRolePage> createState() => _EditRolePageState();
}

class _EditRolePageState extends State<EditRolePage> {
  String? spacePerms;
  String? listPerms;
  String? taskPerms;
  bool? invite;
  bool? changeRoles;

  Future<void> updateRole() async {
    Role newRole = await widget.role
        .update(invite!, changeRoles!, spacePerms!, listPerms!, taskPerms!);

    widget.toViewModeFunc(widget.role, newRole);
  }

  @override
  Widget build(BuildContext context) {
    spacePerms ??= widget.role.spacePerms;
    listPerms ??= widget.role.listPerms;
    taskPerms ??= widget.role.taskPerms;
    invite ??= widget.role.invite;
    changeRoles ??= widget.role.changeRoles;

    return Column(
      children: [
        Text('Role Name: ${widget.role.name}'),
        const Divider(),
        Container(
          decoration: const ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: spacePerms?.contains('u'),
                    onChanged: (value) {
                      setState(() {
                        if (spacePerms!.contains('u')) {
                          spacePerms = spacePerms?.replaceAll(RegExp(r'u'), '');
                        } else {
                          spacePerms = '${spacePerms}u';
                        }
                      });
                    },
                  ),
                  const Text("Edit Workspace Details"),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Checkbox(
                    value: spacePerms?.contains('d'),
                    onChanged: (value) {
                      setState(() {
                        if (spacePerms!.contains('d')) {
                          spacePerms = spacePerms?.replaceAll(RegExp(r'd'), '');
                        } else {
                          spacePerms = '${spacePerms}d';
                        }
                      });
                    },
                  ),
                  const Text("Delete Workspace"),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Checkbox(
                    value: listPerms?.contains('cu'),
                    onChanged: (value) {
                      setState(() {
                        if (listPerms!.contains('cu')) {
                          listPerms = listPerms?.replaceAll(RegExp(r'cu'), '');
                        } else {
                          listPerms = '${listPerms}cu';
                        }
                      });
                    },
                  ),
                  const Text("Create and Edit Lists"),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Checkbox(
                    value: listPerms?.contains('d'),
                    onChanged: (value) {
                      setState(() {
                        if (listPerms!.contains('d')) {
                          listPerms = listPerms?.replaceAll(RegExp(r'd'), '');
                        } else {
                          listPerms = '${listPerms}d';
                        }
                      });
                    },
                  ),
                  const Text("Delete Lists"),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Checkbox(
                    value: taskPerms?.contains('cu'),
                    onChanged: (value) {
                      setState(() {
                        if (taskPerms!.contains('cu')) {
                          taskPerms = taskPerms?.replaceAll(RegExp(r'cu'), '');
                        } else {
                          taskPerms = '${taskPerms}cu';
                        }
                      });
                    },
                  ),
                  const Text("Create and Edit Tasks"),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Checkbox(
                    value: taskPerms?.contains('d'),
                    onChanged: (value) {
                      setState(() {
                        if (taskPerms!.contains('d')) {
                          taskPerms = taskPerms?.replaceAll(RegExp(r'd'), '');
                        } else {
                          taskPerms = '${taskPerms}d';
                        }
                      });
                    },
                  ),
                  const Text("Delete Tasks"),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Checkbox(
                    value: invite,
                    onChanged: (value) {
                      setState(() {
                        invite = value;
                      });
                    },
                  ),
                  const Text("Invite Members"),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Checkbox(
                    value: changeRoles,
                    onChanged: (value) {
                      setState(() {
                        changeRoles = value;
                      });
                    },
                  ),
                  const Text("Change Member Roles"),
                ],
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await updateRole();
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
