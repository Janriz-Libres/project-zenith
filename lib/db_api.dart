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

  /// Adds a workspace for the user.
  ///
  /// Returns the Workspace instance after successful creation.
  Future<Workspace> addWorkspace(String title, String desc) async {
    var docReference = await Firestore.instance.collection('workspaces').add({
      'title': title,
      'description': desc,
      'owner': Firestore.instance.collection('users').document(id),
      'members': <DocumentReference>[],
    });

    return Workspace(
      id: docReference.id,
      title: title,
      description: desc,
      owner: this,
      members: [],
    );
  }

  Future<List<Workspace>> _getWorkspaces(List<Document> docs) async {
    List<Workspace> workspaces = [];

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

      Workspace newWorkspace = Workspace(
        id: workspace.id,
        title: workspace['title'],
        description: workspace['description'],
        owner: this,
        members: members,
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
    await reference.delete();
  }
}

class Workspace {
  final String id;
  final String title;
  final String description;
  final User owner;
  final List<User> members;

  const Workspace({
    required this.id,
    required this.title,
    required this.description,
    required this.owner,
    required this.members,
  });

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
  final WorkList list;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assigned,
    required this.deadline,
    required this.list,
  });
}
