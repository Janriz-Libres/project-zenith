import 'dart:math';

import 'package:firedart/firedart.dart';

class Authenticator {
  /// Signs the user in using the provided email and password.
  ///
  /// Returns the User when sign in is successful.
  ///
  /// Throws AuthException when login credentials are invalid, else void.
  static Future<User> signIn(String email, String pw) async {
    await FirebaseAuth.instance.signIn(email, pw);

    var query = await Firestore.instance
        .collection('users')
        .where('auth_id', isEqualTo: FirebaseAuth.instance.userId)
        .get();

    var user = query.first;

    return User(
      id: user.id,
      email: await user['email'],
      password: await user['password'],
      authId: await user['auth_id'],
      username: await user['username'],
      timeStarted: await user['time_started'],
      hasCheckedIn: await user['has_checked_in'],
      totalMinutes: await user['total_minutes'],
    );
  }

  /// Signs up an unregistered user using the provided email, username and password.
  ///
  /// Returns the User when sign up is successful.
  ///
  /// Throws AuthException when user already exists, else void.
  static Future<User> signUp(String email, String username, String pw) async {
    await FirebaseAuth.instance.signUp(email, pw);

    var reference = Firestore.instance.collection('users');
    Document docReference = await reference.add({
      'id': '',
      'email': email,
      'password': pw,
      'auth_id': FirebaseAuth.instance.userId,
      'username': username,
      'time_started': DateTime.now(),
      'has_checked_in': false,
      'total_minutes': 0,
    });
    await docReference.reference.update({'id': docReference.id});

    return User(
      id: docReference.id,
      email: email,
      password: pw,
      authId: FirebaseAuth.instance.userId,
      username: '',
      timeStarted: DateTime.now(),
      hasCheckedIn: false,
      totalMinutes: 0,
    );
  }

  // Logs out the user.
  static Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    // await Future.delayed(const Duration(milliseconds: 100));
  }
}

Future<List<User>> getAllUsers() async {
  List<User> allUsers = <User>[];
  var temp = await Firestore.instance.collection('users').get();

  for (var element in temp) {
    if (element.id == "rISCknyu5dlIrfGrKyCp") {
      continue;
    }

    allUsers.add(User(
      authId: await element['auth_id'],
      email: await element['email'],
      hasCheckedIn: await element['has_checked_in'],
      id: await element['id'],
      password: await element['password'],
      timeStarted: await element['time_started'],
      totalMinutes: await element['total_minutes'],
      username: await element['username'],
    ));
  }

  return allUsers;
}

Future<List<Attendance>> getAllAttendances() async {
  List<Attendance> allAttendances = <Attendance>[];
  var temp = await Firestore.instance.collection('attendances').get();

  for (var element in temp) {
    DocumentReference ownerRef = await element['user'];
    Document ownerDoc = await ownerRef.get();

    allAttendances.add(Attendance(
        id: element.id,
        checkedin: await element['checked_in'],
        checkedout: await element['checked_out'],
        duration: await element['duration'],
        user: User(
          authId: await ownerDoc['auth_id'],
          email: await ownerDoc['email'],
          hasCheckedIn: await ownerDoc['has_checked_in'],
          id: await ownerDoc['id'],
          password: await ownerDoc['password'],
          timeStarted: await ownerDoc['time_started'],
          totalMinutes: await ownerDoc['total_minutes'],
          username: await ownerDoc['username'],
        )));
  }

  return allAttendances;
}

class User {
  final String id;
  final String authId;
  final String email;
  final String password;
  final String username;
  final DateTime timeStarted;
  final bool hasCheckedIn;
  final int totalMinutes;

  const User({
    required this.id,
    required this.email,
    required this.password,
    required this.authId,
    required this.username,
    required this.timeStarted,
    required this.hasCheckedIn,
    required this.totalMinutes,
  });

  final chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  String _getRandomString(int length) {
    Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
    ));
  }

  /// Adds a workspace for the user.
  ///
  /// Returns the Workspace instance after successful creation.
  Future<Workspace> addWorkspace(String title, String desc) async {
    String code = _getRandomString(15);

    List<DocumentReference> initRoles = <DocumentReference>[];
    initRoles.add(Firestore.instance
        .collection('roles')
        .document('xojbQYX9dtYRxmY1K9KU'));

    var docReference = await Firestore.instance.collection('workspaces').add({
      'title': title,
      'description': desc,
      'owner': Firestore.instance.collection('users').document(id),
      'members': <DocumentReference>[],
      'code': code,
      'roles': initRoles,
    });

    await Firestore.instance.collection('lists').add({
      'name': "FINISH",
      'workspace':
          Firestore.instance.collection('workspaces').document(docReference.id),
    });
    await Firestore.instance.collection('lists').add({
      'name': "DOING",
      'workspace':
          Firestore.instance.collection('workspaces').document(docReference.id),
    });
    await Firestore.instance.collection('lists').add({
      'name': "TODO",
      'workspace':
          Firestore.instance.collection('workspaces').document(docReference.id),
    });

    List<Role> roles = <Role>[];

    for (DocumentReference ref in initRoles) {
      Document doc = await ref.get();
      roles.add(Role(
        changeRoles: await doc['change_roles'],
        id: ref.id,
        invite: await doc['invite'],
        listPerms: await doc['list_perms'],
        name: await doc['name'],
        spacePerms: await doc['space_perms'],
        taskPerms: await doc['task_perms'],
      ));
    }

    return Workspace(
      id: docReference.id,
      title: title,
      description: desc,
      owner: this,
      members: [],
      code: code,
      roles: roles,
    );
  }

  Future<Workspace?> addSharedWorkspace(String code) async {
    List<Document> query = await Firestore.instance
        .collection('workspaces')
        .where('code', isEqualTo: code)
        .get();

    Document spaceDoc = query.first;
    List<dynamic> members = await spaceDoc['members'];
    var thisUser = Firestore.instance.collection('users').document(id);

    if (query.isEmpty ||
        await spaceDoc['owner'] == thisUser ||
        members.contains(thisUser)) {
      return null;
    }

    List<dynamic> newMembers = <dynamic>[];
    newMembers.addAll(members);
    newMembers.add(thisUser);
    await spaceDoc.reference.update({'members': newMembers});

    List<User> users = <User>[];

    for (DocumentReference ref in newMembers) {
      var userDoc = await ref.get();
      users.add(User(
        authId: await userDoc['auth_id'],
        email: await userDoc['email'],
        hasCheckedIn: await userDoc['has_checked_in'],
        id: await userDoc['id'],
        password: await userDoc['password'],
        timeStarted: await userDoc['time_started'],
        totalMinutes: await userDoc['total_minutes'],
        username: await userDoc['username'],
      ));
    }

    List<dynamic> roleRefs = await spaceDoc['roles'];
    List<Role> roles = <Role>[];

    for (DocumentReference ref in roleRefs) {
      var roleDoc = await ref.get();
      roles.add(Role(
        id: ref.id,
        changeRoles: await roleDoc['change_roles'],
        invite: await roleDoc['invite'],
        listPerms: await roleDoc['list_perms'],
        name: await roleDoc['name'],
        spacePerms: await roleDoc['space_perms'],
        taskPerms: await roleDoc['task_perms'],
      ));
    }

    return Workspace(
      id: spaceDoc.id,
      title: await spaceDoc['title'],
      description: await spaceDoc['description'],
      owner: await spaceDoc['owner'],
      members: users,
      code: code,
      roles: roles,
    );
  }

  Future<List<Workspace>> _getWorkspaces(List<Document> docs) async {
    List<Workspace> workspaces = <Workspace>[];

    for (final Document workspace in docs) {
      List<User> members = [];
      List<dynamic> memberRefs = workspace['members'];

      for (DocumentReference ref in memberRefs) {
        Document userDoc = await ref.get();

        members.add(User(
          authId: await userDoc['auth_id'],
          email: await userDoc['email'],
          id: await userDoc['id'],
          password: await userDoc['password'],
          username: await userDoc['username'],
          timeStarted: await userDoc['time_started'],
          hasCheckedIn: await userDoc['has_checked_in'],
          totalMinutes: await userDoc['total_minutes'],
        ));
      }

      DocumentReference ownerRef = await workspace['owner'];
      Document ownerDoc = await ownerRef.get();

      List<dynamic> roleRefs = await workspace['roles'];
      List<Role> roles = <Role>[];

      for (DocumentReference ref in roleRefs) {
        var roleDoc = await ref.get();
        roles.add(Role(
          id: ref.id,
          changeRoles: await roleDoc['change_roles'],
          invite: await roleDoc['invite'],
          listPerms: await roleDoc['list_perms'],
          name: await roleDoc['name'],
          spacePerms: await roleDoc['space_perms'],
          taskPerms: await roleDoc['task_perms'],
        ));
      }

      Workspace newWorkspace = Workspace(
        id: workspace.id,
        title: await workspace['title'],
        description: await workspace['description'],
        owner: User(
          authId: await ownerDoc['auth_id'],
          email: await ownerDoc['email'],
          hasCheckedIn: await ownerDoc['has_checked_in'],
          id: await ownerDoc['id'],
          password: await ownerDoc['password'],
          timeStarted: await ownerDoc['time_started'],
          totalMinutes: await ownerDoc['total_minutes'],
          username: await ownerDoc['username'],
        ),
        members: members,
        code: await workspace['code'],
        roles: roles,
      );
      workspaces.add(newWorkspace);
    }

    return workspaces;
  }

  /// Returns a list of Workspace objects where the current user is an owner or a member of.
  Future<List<Workspace>> getOwnedWorkspaces() async {
    var userReference = Firestore.instance.collection('users').document(id);

    var userQuery = await Firestore.instance
        .collection('workspaces')
        .where('owner', isEqualTo: userReference)
        .get();

    return await _getWorkspaces(userQuery);
  }

  Future<List<Workspace>> getSharedWorkspaces() async {
    var userReference = Firestore.instance.collection('users').document(id);

    var userQuery = await Firestore.instance
        .collection('workspaces')
        .where('members', arrayContains: userReference)
        .get();

    return await _getWorkspaces(userQuery);
  }

  Future<void> deleteWorkspace(Workspace space) async {
    var reference =
        Firestore.instance.collection('workspaces').document(space.id);

    var lists = await Firestore.instance
        .collection('lists')
        .where('workspace', isEqualTo: reference)
        .get();

    for (final Document list in lists) {
      var listreference =
          Firestore.instance.collection('lists').document(list.id);
      var tasks = await Firestore.instance
          .collection('tasks')
          .where('list', isEqualTo: listreference)
          .get();

      for (final Document task in tasks) {
        var taskreference =
            Firestore.instance.collection('tasks').document(task.id);
        await taskreference.delete();
      }

      await listreference.delete();
    }

    await reference.delete();
  }

  Future<User> updateUsername(String newName) async {
    var reference = Firestore.instance.collection('users').document(id);
    await reference.update({'username': newName});

    Document userDoc = await reference.get();
    return User(
      authId: await userDoc['auth_id'],
      email: await userDoc['email'],
      id: await userDoc['id'],
      password: await userDoc['password'],
      username: await userDoc['username'],
      timeStarted: await userDoc['time_started'],
      hasCheckedIn: await userDoc['has_checked_in'],
      totalMinutes: await userDoc['total_minutes'],
    );
  }

  Future<Attendance> checkin(User user, DateTime date) async {
    var docReference = await Firestore.instance.collection('attendances').add({
      'checked_in': date,
      'checked_out': null,
      'duration': null,
      'user': Firestore.instance.collection('users').document(user.id)
    });

    DocumentReference ownerRef =
        Firestore.instance.collection('users').document(user.id);
    Document ownerDoc = await ownerRef.get();

    return Attendance(
        id: docReference.id,
        checkedin: docReference['checked_in'],
        checkedout: docReference['checked_out'],
        duration: docReference['duration'],
        user: User(
          authId: await ownerDoc['auth_id'],
          email: await ownerDoc['email'],
          hasCheckedIn: await ownerDoc['has_checked_in'],
          id: await ownerDoc['id'],
          password: await ownerDoc['password'],
          timeStarted: await ownerDoc['time_started'],
          totalMinutes: await ownerDoc['total_minutes'],
          username: await ownerDoc['username'],
        ));
  }

  Future<Attendance> checkout(Attendance attendance, DateTime date) async {
    print(attendance.id);
    var docReference =
        Firestore.instance.collection('attendances').document(attendance.id);
    await docReference.update({
      'checked_out': date,
      'duration': date.difference(attendance.checkedin!).inMinutes / 60
    });

    Document attendanceDoc = await docReference.get();
    return Attendance(
        id: attendance.id,
        checkedin: attendance.checkedin,
        checkedout: attendanceDoc['checked_out'],
        duration: attendanceDoc['duration'],
        user: attendance.user);
  }
}

class Attendance {
  final String id;
  final DateTime? checkedin;
  final DateTime? checkedout;
  final double? duration;
  final User user;

  const Attendance({
    required this.id,
    required this.checkedin,
    required this.checkedout,
    required this.duration,
    required this.user,
  });
}

class Role {
  final String id;
  final String name;
  final bool invite;
  final bool changeRoles;
  final String spacePerms;
  final String listPerms;
  final String taskPerms;

  const Role({
    required this.id,
    required this.name,
    required this.invite,
    required this.changeRoles,
    required this.spacePerms,
    required this.listPerms,
    required this.taskPerms,
  });

  Future<Role> update(bool invite, bool changeRoles, String spacePerms,
      String listPerms, String taskPerms) async {
    var ref = Firestore.instance.collection('roles').document(id);
    await ref.update({
      'invite': invite,
      'change_roles': changeRoles,
      'space_perms': spacePerms,
      'list_perms': listPerms,
      'task_perms': taskPerms,
    });

    var doc = await ref.get();

    return Role(
      changeRoles: await doc['change_roles'],
      id: ref.id,
      invite: await doc['invite'],
      listPerms: await doc['list_perms'],
      name: await doc['name'],
      spacePerms: await doc['space_perms'],
      taskPerms: await doc['task_perms'],
    );
  }
}

class Workspace {
  final String id;
  String title;
  String description;
  final User owner;
  final List<User> members;
  final String code;
  final List<Role> roles;

  Workspace({
    required this.id,
    required this.title,
    required this.description,
    required this.owner,
    required this.members,
    required this.code,
    required this.roles,
  });

  Future<void> updateDescription(String desc) async {
    var reference = Firestore.instance.collection('workspaces').document(id);
    await reference.update({'description': desc});
  }

  Future<void> updateWorkspaceDetails(String title, String desc) async {
    var reference = Firestore.instance.collection('workspaces').document(id);
    await reference.update({'title': title, 'description': desc});
  }

  Future<WorkList> addList(String name) async {
    var docReference = await Firestore.instance.collection('lists').add({
      'name': name,
      'workspace': Firestore.instance.collection('workspaces').document(id),
    });

    return WorkList(
      id: docReference.id,
      name: name,
      workspace: this,
    );
  }

  Future<Role> addRole(String name, String desc) async {
    var doc = await Firestore.instance.collection('roles').add({
      'name': name,
      'change_roles': false,
      'invite': false,
      'list_perms': "",
      'space_perms': "",
      'task_perms': "",
    });

    DocumentReference thisSpace =
        Firestore.instance.collection('workspaces').document(id);
    Document spaceDoc = await thisSpace.get();
    List<dynamic> roles = await spaceDoc['roles'];

    List<dynamic> newRoles = <dynamic>[];
    newRoles.addAll(roles);
    newRoles.add(doc.reference);

    await thisSpace.update({
      'roles': newRoles,
    });

    return Role(
      changeRoles: await doc['change_roles'],
      id: doc.id,
      invite: await doc['invite'],
      listPerms: await doc['list_perms'],
      name: await doc['name'],
      spacePerms: await doc['space_perms'],
      taskPerms: await doc['task_perms'],
    );
  }

  Future<void> removeRole(Role role) async {
    var roleDoc = Firestore.instance.collection('roles').document(role.id);
    await roleDoc.delete();

    var thisSpace = Firestore.instance.collection('workspaces').document(id);
    var spaceDoc = await thisSpace.get();
    List<dynamic> roles = await spaceDoc['roles'];

    List<DocumentReference> newRoles = <DocumentReference>[];

    for (DocumentReference ref in roles) {
      if (ref.id == role.id) {
        continue;
      }
      newRoles.add(ref);
    }

    await thisSpace.update({
      'roles': newRoles,
    });
  }

  Future<List<WorkList>> getLists() async {
    var reference = Firestore.instance.collection('workspaces').document(id);

    var query = await Firestore.instance
        .collection('lists')
        .where('workspace', isEqualTo: reference)
        .get();

    List<WorkList> lists = [];

    for (final Document list in query) {
      WorkList newWorkspace = WorkList(
        id: list.id,
        name: await list['name'],
        workspace: this,
      );
      lists.add(newWorkspace);
    }

    return lists;
  }

  Future<void> deleteList(WorkList list) async {
    var reference = Firestore.instance.collection('lists').document(list.id);
    await reference.delete();
  }

  Future<WorkList> updateListName(WorkList list, String name) async {
    var reference = Firestore.instance.collection('lists').document(list.id);
    await reference.update({'name': name});

    Document userDoc = await reference.get();
    return WorkList(
      id: list.id,
      name: userDoc['name'],
      workspace: list.workspace,
    );
  }
}

class WorkList {
  final String id;
  final String name;
  final Workspace workspace;

  const WorkList({
    required this.id,
    required this.name,
    required this.workspace,
  });

  Future<Task> addTask(String title, String desc) async {
    var docReference = await Firestore.instance.collection('tasks').add({
      'title': title,
      'description': desc,
      'assigned': <DocumentReference>[],
      'deadline': null,
      'list': Firestore.instance.collection('lists').document(id),
    });
    await docReference.reference.update({
      'id': docReference.id,
    });

    return Task(
      id: docReference.id,
      title: title,
      description: desc,
      assigned: [],
      deadline: null,
      list: this,
    );
  }

  Future<List<Task>> getTasks() async {
    var reference = Firestore.instance.collection('lists').document(id);

    var query = await Firestore.instance
        .collection('tasks')
        .where('list', isEqualTo: reference)
        .get();

    List<Task> tasks = [];

    for (final Document task in query) {
      List<User> assignedUsers = <User>[];
      List<dynamic> refs = task['assigned'];

      for (DocumentReference ref in refs) {
        Document realDoc = await ref.get();
        assignedUsers.add(User(
          authId: await realDoc['auth_id'],
          email: await realDoc['email'],
          id: await realDoc['id'],
          password: await realDoc['password'],
          username: await realDoc['username'],
          timeStarted: await realDoc['time_started'],
          hasCheckedIn: await realDoc['has_checked_in'],
          totalMinutes: await realDoc['total_minutes'],
        ));
      }

      Task newWorkspace = Task(
        id: task.id,
        assigned: assignedUsers,
        deadline: task['deadline'],
        description: task['description'],
        list: this,
        title: task['title'],
      );
      tasks.add(newWorkspace);
    }

    return tasks;
  }

  Future<void> deleteTask(Task task) async {
    var reference = Firestore.instance.collection('tasks').document(task.id);
    await reference.delete();
  }
}

class Task {
  final String id;
  final String title;
  final String description;
  final List<User> assigned;
  final DateTime? deadline;
  WorkList list;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assigned,
    required this.deadline,
    required this.list,
  });

  Future<void> changeParentList(WorkList list) async {
    var reference = Firestore.instance.collection('tasks').document(id);
    await reference.update({
      'list': Firestore.instance.collection('lists').document(list.id),
    });
    this.list = list;
  }
}
