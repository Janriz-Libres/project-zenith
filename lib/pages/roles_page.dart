import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';

class RolesPage extends StatelessWidget {
  final Workspace space;

  const RolesPage({
    super.key,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: space.roles.map((e) => Text(e.name)).toList(),
    );
  }
}
