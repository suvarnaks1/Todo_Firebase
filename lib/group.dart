import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    if (_user == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      // Extract the name from the email (assuming the email is in the correct format)
      String userName = _user?.email?.split('@').first ?? '';

      return ListView.builder(
        itemCount: 1, // Only one user in this example
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Name: $userName'),
            subtitle: Text('Email: ${_user?.email}'),
          );
        },
      );
    }
  }
}
