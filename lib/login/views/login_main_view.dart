import 'package:authentication/authenticaiton/bloc/authentication_bloc.dart';
import 'package:authentication/home/views/home_main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Google Sign-In'),
              backgroundColor: Colors.red,
              centerTitle: true,
            ),
            body: SafeArea(
              child:Center(
                child: Column(
                  children:[
                    Container(
                    child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                      listener: (context, state) {
                        if (state is AuthenticationSuccess) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => HomeMainView()));
                        } else if (state is AuthenticationFailiure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
                      buildWhen: (current, next) {
                        if (next is AuthenticationSuccess) {
                          return false;
                        }
                        return true;
                      },
                      builder: (context, state) {
                        if (state is AuthenticationInitial ||
                            state is AuthenticationFailiure) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 260),
                                FlatButton(
                                  color: Colors.red,
                                  child: Text('Login with Google'),
                                  onPressed: () =>
                                      BlocProvider.of<AuthenticationBloc>(context).add(
                                        AuthenticationGoogleStarted(),
                                      ),
                                )
                              ],
                            ),
                          );
                        }
                        return Center(
                            child: Text(''));
                      },
                    ),
                ),
                    Builder(
                      builder: (context) {
                        return BlocConsumer<AuthenticationBloc, AuthenticationState>(
                          listener: (context, state) {
                            if (state is AuthenticationFailiure) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) => LoginMainView()));
                            }
                          },
                          builder: (context, state) {
                            if (state is AuthenticationInitial) {
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(AuthenticationStarted());
                              return Center(child: CircularProgressIndicator());
                            } else if (state is AuthenticationLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is AuthenticationSuccess) {
                              return Text('Welcome :${state.authenticationDetail.uid}');
                            }
                            return Text('');
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
        ),
    );
  }
}
