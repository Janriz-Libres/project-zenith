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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (rolesWidget) {
          case RolesWidget.view:
            return ViewRolesPage(space: widget.space);
          case RolesWidget.edit:
            return const EditRolesPage();
          default:
            throw Exception();
        }
      },
    );
  }
}

class ViewRolesPage extends StatefulWidget {
  final Workspace space;

  const ViewRolesPage({
    super.key,
    required this.space,
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
                  onPressed: () {},
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

class EditRolesPage extends StatelessWidget {
  const EditRolesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
