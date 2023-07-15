import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'component.dart';
import 'logo.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

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
                      if (value !=
                          context.read<Component>().userFindByEmail?.email) {
                        return 'Không tồn tại email này trong hệ thống';
                      }
                      if (!value!.contains('@gmail.com')) {
                        return 'Email cần có dạng xxx@gmail.com';
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
                    obscureText: context.watch<Component>().watchPass,
                    controller: controllerPassword,
                    validator: (value) {
                      if (value == '') {
                        return 'Chưa nhập password muốn đổi';
                      }
                      if (value!.length < 6) {
                        return 'Mật khẩu không được bé hơn 6 kí tự';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password you want to change',
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
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        context.read<Component>().setWatchPassTrue();
                        await context
                            .read<Component>()
                            .findUserByEmail(controllerEmail.text);
                        if (keyForm.currentState!.validate()) {
                          // ignore: use_build_context_synchronously
                          await context.read<Component>().updateUser(
                              controllerEmail.text, controllerPassword.text);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                      child: const Text('Change'),
                    ),
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
