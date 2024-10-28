import 'package:bookify/core/cubit_status.dart';
import 'package:bookify/live_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookify/src/page/login/login_cubit.dart';
import 'package:bookify/src/page/login/login_state.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/gradient_background.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;

  final emailController = TextEditingController(text: LiveData.email);
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  //final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  showPass() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == CubitStatus.success ||
              state.status == CubitStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: state.status == CubitStatus.error
                  ? Colors.redAccent
                  : const Color.fromARGB(255, 86, 224, 91),
              content: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ));
            if (LiveData.accessToken.isNotEmpty) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const DashboardScreen(),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: ListView(
              padding: EdgeInsets.zero,
              children: [
                GradientBackground(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey[900], shape: BoxShape.circle),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Sign in',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Sign in to your account',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppTextFormField(
                          controller: emailController,
                          labelText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Enter your email adress'
                                : null;
                          },
                        ),
                        AppTextFormField(
                          obscureText: _isObscure,
                          controller: passwordController,
                          labelText: 'Password',
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Enter your password'
                                : null;
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              showPass();
                            },
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: FilledButton(
                            onPressed: () {
                              context.read<LoginCubit>().login(
                                    emailController.text,
                                    passwordController.text,
                                  );
                            },
                            child: state.status == CubitStatus.loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  )
                                : const Text('Login'),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account",
                      // style: AppTheme.bodySmall.copyWith(color: Colors.black),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        'RegisterScreen',
                      ),
                      child: const Text(
                        'Register',
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
