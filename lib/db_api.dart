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
      email: user['email'],
      password: user['password'],
      authId: user['auth_id'],
      username: user['username'],
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
    });
    await docReference.reference.update({'id': docReference.id});

    return User(
      id: docReference.id,
      email: email,
      password: pw,
      authId: FirebaseAuth.instance.userId,
      username: '',
    );
  }

  // Logs out the user.
  static Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    FirebaseAuth.instance.close();

    await Future.delayed(const Duration(milliseconds: 100));

    Firestore.instance.close();
  }
}

class User {
  final String id;
  final String authId;
  final String email;
  final String password;
  final String username;

  const User({
    required this.id,
    required this.email,
    required this.password,
    required this.authId,
    required this.username,
  });

  /// Adds a workspace for the user.
  ///
  /// Returns the Workspace instance after successful creation.
  Future<Workspace> addWorkspace(String title, String desc) async {
    var docReference = await Firestore.instance.collection('workspaces').add({
      'title': title,
      'description': desc,
      'owner': Firestore.instance.collection('users').document(id),
      'members': [],
    });

    return Workspace(
      id: docReference.id,
      title: title,
      description: desc,
      owner: this,
      members: [],
    );
  }

  /// Returns a list of Workspace objects where the current user is an owner or a member of.
  Future<List<Workspace>> getWorkspaces() async {
    var userIsOwnerQuery = await Firestore.instance
        .collection('workspaces')
        .where('owner', isEqualTo: this)
        .get();

    var userIsMemberQuery = await Firestore.instance
        .collection('workspaces')
        .where('members', arrayContains: this)
        .get();

    List<Document> allQueries = [];
    allQueries.addAll(userIsOwnerQuery);
    allQueries.addAll(userIsMemberQuery);

    List<Workspace> workspaces = [];

    for (final Document workspace in allQueries) {
      Workspace newWorkspace = Workspace(
        id: workspace.id,
        title: workspace['title'],
        description: workspace['description'],
        owner: workspace['owner'],
        members: workspace['members'],
      );
      workspaces.add(newWorkspace);
    }

    return workspaces;
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
      'workspace': this,
    });

    return WorkList(
      id: docReference.id,
      name: name,
      workspace: this,
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
      'assigned': [],
      'deadline': null,
      'list': this
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
