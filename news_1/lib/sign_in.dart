import 'package:flutter/material.dart';
import 'package:news_1/forgot_password.dart';
import 'package:news_1/sign_up.dart';
import 'package:provider/provider.dart';
import 'component.dart';
import 'home.dart';
import 'logo.dart';
import 'update_later.dart';
import 'package:flutter/cupertino.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController controllerEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: keyForm,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Logo(),
                  TextFormField(
                    controller: controllerEmail,
                    validator: (value) {
                      if (value == '') {
                        return 'Chưa nhập Email';
                      }
                      if (!value!.contains('@gmail.com')) {
                        return 'Email cần có dạng xxx@gmail.com';
                      }
                      if (value !=
                          context.read<Component>().userFindByEmail?.email) {
                        return 'Không tồn tại email này trong hệ thống';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: context.read<Component>().watchPass,
                    validator: (value) {
                      if (value == '') {
                        return 'Chưa nhập password';
                      }
                      if (value!.length < 6) {
                        return 'Mật khẩu không được bé hơn 6 kí tự';
                      }
                      if (value !=
                          context.read<Component>().userFindByEmail?.password) {
                        return 'Mật khẩu không đúng';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: CupertinoButton(
                        onPressed: () {
                          context.read<Component>().setWatchPass();
                          context.read<Component>().changeIconWatchPass();
                        },
                        child: Icon(
                          context.read<Component>().iconWatchPass,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            context.read<Component>().setWatchPassTrue();
                            if (context.read<Component>().listUser.isNotEmpty) {
                              await context
                                  .read<Component>()
                                  .findUserByEmail(controllerEmail.text);
                            }
                            if (keyForm.currentState!.validate()) {
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 8),
                              backgroundColor: Colors.blue[500],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.black,
                                indent: 5,
                                endIndent: 5,
                              ),
                            ),
                            Text(
                              'or sign in with',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.black,
                                indent: 5,
                                endIndent: 5,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UpdateLaterNotify(nameIcon: 'google.svg'),
                      UpdateLaterNotify(nameIcon: 'facebook.svg'),
                      UpdateLaterNotify(nameIcon: 'twitter.svg'),
                      UpdateLaterNotify(nameIcon: 'apple.svg'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account? ',
                        style: TextStyle(fontSize: 13),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
