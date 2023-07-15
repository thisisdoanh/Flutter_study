import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_1/logo.dart';
import 'package:news_1/sign_in.dart';
import 'package:provider/provider.dart';
import 'component.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'update_later.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  final GlobalKey<FormState> key1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: key1,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Logo(),
                  TextFormField(
                    controller: controllerUsername,
                    validator: (value) {
                      if (value == '') {
                        return 'Chưa nhập username';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: controllerEmail,
                    validator: (value) {
                      if (value == '') {
                        return 'Chưa nhập Email';
                      }
                      if (!value!.contains('@gmail.com')) {
                        return 'Email cần có dạng xxx@gmail.com';
                      }
                      if (value ==
                          context.read<Component>().userFindByEmail?.email) {
                        return 'Đã tồn tại email này';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: controllerPhone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value != null) {
                        if (value == '') {
                          return 'Chưa nhập số điện thoại';
                        }
                        if (value.length < 10 || value.length > 14) {
                          return 'Số điện thoại không hợp lệ';
                        }
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Phonenumber',
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: controllerPassword,
                    obscureText: context.read<Component>().watchPass,
                    validator: (value) {
                      if (value == '') {
                        return 'Chưa nhập password';
                      }

                      if (value!.length < 6) {
                        return 'Mật khẩu không được bé hơn 6 kí tự';
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
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "I am a",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text(
                            'Media Reporter',
                            style: TextStyle(fontSize: 13),
                          ),
                          leading: Radio(
                            value: 1,
                            groupValue: context.watch<Component>().type,
                            onChanged: (value) {
                              context.read<Component>().setType(value!);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text(
                            'Visitor',
                            style: TextStyle(fontSize: 13),
                          ),
                          leading: Radio(
                            value: 2,
                            groupValue: context.watch<Component>().type,
                            onChanged: (value) {
                              context.read<Component>().setType(value!);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
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

                            if (key1.currentState!.validate()) {
                              // ignore: use_build_context_synchronously
                              await context.read<Component>().addToSql(
                                    controllerUsername.text,
                                    controllerEmail.text,
                                    controllerPhone.text,
                                    controllerPassword.text,
                                  );
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
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
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<Component>().setWatchPassTrue();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          );
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: SvgPicture.asset('assets/icons/email.svg'),
                        ),
                      ),
                      const UpdateLaterNotify(nameIcon: 'google.svg'),
                      const UpdateLaterNotify(nameIcon: 'facebook.svg'),
                      const UpdateLaterNotify(nameIcon: 'twitter.svg'),
                      const UpdateLaterNotify(nameIcon: 'apple.svg'),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Center(
                    child: Text(
                      'Developed by DoanhTran',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
