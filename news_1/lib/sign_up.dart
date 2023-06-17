import 'package:flutter/material.dart';
import 'package:news_1/sign_in.dart';
import 'package:provider/provider.dart';
import 'component.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'string.dart';

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/banner.png'),
                        fit: BoxFit.fitHeight),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
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
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: controllerEmail,
                  validator: (value) {
                    if (value == '') {
                      return 'Chưa nhập email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: controllerPhone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phonenumber',
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: controllerPassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == '') {
                      return 'Chưa nhập password';
                    }
                    if (value!.length < 6) {
                      return 'Mật khẩu không được bé hơn 6 kí tự';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
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
                          value: 0,
                          groupValue: context.watch<Component>().gioiTinh,
                          onChanged: (value) {
                            context.read<Component>().setGioiTinh(value!);
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
                          value: 1,
                          groupValue: context.watch<Component>().gioiTinh,
                          onChanged: (value) {
                            context.read<Component>().setGioiTinh(value!);
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
                        onPressed: () {
                          if (key1.currentState!.validate()) {
                            context.read<Component>().addToSql(
                                controllerUsername.text,
                                controllerEmail.text,
                                controllerPhone.text,
                                controllerPassword.text,
                                context.read<Component>().gioiTinh);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen(),),);
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
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.black,
                              indent: 5,
                              endIndent: 5,
                            ),
                          ),
                          Text(
                            'or sign up with',
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
                    buttonSignIn('email.svg'),
                    buttonSignIn('google.svg'),
                    buttonSignIn('facebook.svg'),
                    buttonSignIn('twitter.svg'),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        height: 50,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: AssetImage(ListString.urlAppleIcon),
                          ),
                        ),
                        // child: Image.asset(ListString.urlAppleIcon),
                      ),
                    ),
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
    );
  }

  IconButton buttonSignIn(String nameIcon) {
    return IconButton(
      onPressed: () {},
      icon: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(4),
          ),
          child: SvgPicture.asset('assets/icons/$nameIcon')),
    );
  }
}
