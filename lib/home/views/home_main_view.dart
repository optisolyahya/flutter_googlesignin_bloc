import 'package:authentication/authenticaiton/bloc/authentication_bloc.dart';
import 'package:authentication/home/views/drawer_screen.dart';
import 'package:authentication/login/views/login_main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavigatedDrawer(),
        appBar: AppBar(
            title: Text('Home Page'),
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
        // body: Center(
        //   child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        //     listener: (context, state) {
        //       if (state is AuthenticationFailiure) {
        //         Navigator.pushReplacement(context,
        //             MaterialPageRoute(builder: (_) => LoginMainView()));
        //       }
        //     },
        //     builder: (context, state) {
        //       if (state is AuthenticationInitial) {
        //         BlocProvider.of<AuthenticationBloc>(context)
        //             .add(AuthenticationStarted());
        //         return CircularProgressIndicator();
        //       } else if (state is AuthenticationLoading) {
        //         return CircularProgressIndicator();
        //       } else if (state is AuthenticationSuccess) {
        //         return Text('Welcome :${state.authenticationDetail.uid}');
        //       }
        //       return Text('Undefined state : ${state.runtimeType}');
        //     },
        //   ),
        // ),
      ),
    );
  }
}

