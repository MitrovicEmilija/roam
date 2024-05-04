import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roam/core/common/google_signin_button.dart';
import 'package:roam/core/common/loader.dart';
import 'package:roam/features/auth/controller/auth_controller.dart';
import 'package:roam/theme/pallete.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  var isLogin = true;

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.green,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const GoogleSignInButton(),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'or',
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          color: Pallete.greyText,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'emilija@gmail.com',
                          hintStyle: const TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 12,
                            color: Pallete.greyText,
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(18),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (!isLogin)
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Username',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 18,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (!isLogin)
                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintText: 'ema',
                            hintStyle: const TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 12,
                              color: Pallete.greyText,
                            ),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.all(18),
                          ),
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: passController,
                        decoration: InputDecoration(
                          hintText: 'password',
                          hintStyle: const TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 12,
                            color: Pallete.greyText,
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(18),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (isLogin)
                        ElevatedButton(
                          onPressed: () {
                            final email = emailController.text.trim();
                            final password = passController.text.trim();
                            final username = usernameController.text.trim();
                            ref
                                .read(authControllerProvider.notifier)
                                .signInWithEmailPassword(
                                  context,
                                  email,
                                  password,
                                  username,
                                  true,
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Pallete.blue,
                            minimumSize: const Size(double.infinity, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      if (!isLogin)
                        ElevatedButton(
                          onPressed: () {
                            final email = emailController.text.trim();
                            final password = passController.text.trim();
                            final username = usernameController.text.trim();
                            ref
                                .read(authControllerProvider.notifier)
                                .signInWithEmailPassword(
                                  context,
                                  email,
                                  password,
                                  username,
                                  false,
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Pallete.blue,
                            minimumSize: const Size(double.infinity, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(
                          isLogin
                              ? 'Do not have an account? Sign up.'
                              : 'Already have an account? Log in.',
                          style: const TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 13,
                            color: Colors.green,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.green,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
