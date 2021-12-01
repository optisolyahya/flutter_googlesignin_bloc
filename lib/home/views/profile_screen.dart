import 'package:authentication/authenticaiton/bloc/authentication_bloc.dart';
import 'package:authentication/login/views/login_main_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'drawer_screen.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        drawer:  NavigatedDrawer(),
        appBar: AppBar(
        title: Text('Profile Page'),
          backgroundColor: Colors.red,
          centerTitle: true,
          actions: <Widget>[
           IconButton(onPressed: (){
             showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('App Title'),
               content: const Text('Do You Want to Logout!!!'),
              actions: <Widget>[
             TextButton(
               onPressed: () {
                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                     LoginMainView()), (Route<dynamic> route) => false);

                 BlocProvider.of<AuthenticationBloc>(context).add(
                     AuthenticationExited());
               },
              child: const Text('Ok'),
            ),
               TextButton(
               onPressed: () => Navigator.pop(context, 'Cancel'),
               child: const Text('Cancel'),
                ),
                 ],
            ),
              );
        },
               icon: Icon(Icons.logout))
           ]
        ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
               backgroundImage: NetworkImage(user.photoURL!),
            ),
            SizedBox(height: 8),
            Text('Name: ' + user.displayName!,
            style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text('Email: ' + user.email!,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
