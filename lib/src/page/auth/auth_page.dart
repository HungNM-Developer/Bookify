import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookify/src/page/auth/auth_cubit.dart';
import 'package:bookify/src/page/auth/auth_state.dart';

import '../../../config/color.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AuthCubit screenCubit;
  bool _isObscure = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    screenCubit = context.read<AuthCubit>();
    screenCubit.loadInitialData();
    super.initState();
  }

  showPass() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
          child: Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: TextFormField(
            cursorColor: AppColors.primaryColor,
            controller: emailController,
            autovalidateMode: AutovalidateMode.always,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black26,
                    width: 2.0,
                  ),
                ),
                suffixIcon: const Icon(
                  Icons.person,
                  color: AppColors.primaryColor,
                ),
                fillColor: AppColors.primaryColor,
                focusColor: AppColors.primaryColor,
                hoverColor: AppColors.primaryColor,
                //icon: Icon(Icons.person),
                //border: OutlineInputBorder(),
                floatingLabelStyle:
                    const TextStyle(color: AppColors.primaryColor),
                labelText: 'Email',
                hintText: 'Enter email'),
          ),
        ),
        Container(),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 0,
            left: 20,
            right: 20,
          ),
          child: TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black26,
                  width: 2.0,
                ),
              ),
              fillColor: AppColors.primaryColor,
              focusColor: AppColors.primaryColor,
              hoverColor: AppColors.primaryColor,
              floatingLabelStyle:
                  const TextStyle(color: AppColors.primaryColor),
              labelText: 'Password',
              hintText: 'Enter password',
              suffixIcon: const Icon(
                Icons.password,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CircularProgressIndicator();
              }
              return InkWell(
                onTap: () async {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Bạn phải điền tài khoản và mật khẩu'),
                    ));
                    return;
                  }
                  await screenCubit.login(
                    emailController.text,
                    passwordController.text,
                  );
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 4,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.login,
                        size: 25,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildBody(AuthState state) {
    return ListView(
      children: const [
        // TODO your code here
      ],
    );
  }
}
