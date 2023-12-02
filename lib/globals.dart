import 'package:project_zenith/db_api.dart';

User? currentUser;
List<Workspace> ownedWorkspaces = <Workspace>[];
List<Workspace> sharedWorkspaces = <Workspace>[];
List<WorkList> lists = <WorkList>[];
List<Task> tasks = <Task>[];

Future<void> initializeModels() async {
  ownedWorkspaces = await currentUser!.getOwnedWorkspaces();
  sharedWorkspaces = await currentUser!.getSharedWorkspaces();

  for (Workspace space in ownedWorkspaces) {
    lists.addAll(await space.getLists());
  }

  for (Workspace space in sharedWorkspaces) {
    lists.addAll(await space.getLists());
  }

  for (WorkList list in lists) {
    tasks.addAll(await list.getTasks());
  }
}
