import 'package:bookify/src/page/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/cubit_status.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/gradient_background.dart';
import 'register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isObscurePass = true;
  bool _isObscurePassConfirm = true;

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  void initializeControllers() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  showPass() {
    setState(() {
      _isObscurePass = !_isObscurePass;
    });
  }

  showPassConfirm() {
    setState(() {
      _isObscurePassConfirm = !_isObscurePassConfirm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
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
          }
          if (state.status == CubitStatus.success) {
            Navigator.of(context).pop();
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
                        onTap: () => Navigator.of(context).pop(),
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
                      'Register',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Create your account',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppTextFormField(
                          autofocus: true,
                          labelText: 'Username',
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) =>
                              _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty ? 'Enter your name' : null;
                          },
                          controller: nameController,
                        ),
                        AppTextFormField(
                          labelText: 'Email',
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Enter your email adress'
                                : null;
                          },
                        ),
                        AppTextFormField(
                          obscureText: _isObscurePass,
                          controller: passwordController,
                          labelText: 'Password',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Enter your password'
                                : null;
                          },
                          suffixIcon: Focus(
                            descendantsAreFocusable: false,
                            child: IconButton(
                              onPressed: () {
                                showPass();
                              },
                              style: IconButton.styleFrom(
                                minimumSize: const Size.square(48),
                              ),
                              icon: Icon(
                                _isObscurePass
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        AppTextFormField(
                          labelText: 'Confirm Password',
                          controller: confirmPasswordController,
                          obscureText: _isObscurePassConfirm,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Enter confirm password'
                                : passwordController.text ==
                                        confirmPasswordController.text
                                    ? null
                                    : 'Password not matched';
                          },
                          suffixIcon: Focus(
                            descendantsAreFocusable: false,
                            child: IconButton(
                              onPressed: () {
                                showPassConfirm();
                              },
                              style: IconButton.styleFrom(
                                minimumSize: const Size.square(48),
                              ),
                              icon: Icon(
                                _isObscurePassConfirm
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: FilledButton(
                            onPressed: () {
                              context.read<RegisterCubit>().signUp(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    confirmPasswordController.text,
                                  );
                            },
                            child: state.status == CubitStatus.loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  )
                                : const Text('Register'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'I have an account?',
                      //style: AppTheme.bodySmall.copyWith(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Login',
                      ),
                    ),
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
