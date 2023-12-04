import 'package:project_zenith/db_api.dart';

User? gUser;
List<Workspace> gOwnedSpaces = <Workspace>[];
List<Workspace> gSharedSpaces = <Workspace>[];
List<WorkList> gLists = <WorkList>[];
List<Task> gTasks = <Task>[];

Future<void> initWorkspaceModels() async {
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
