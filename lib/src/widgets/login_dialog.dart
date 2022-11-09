import 'package:flutter/material.dart';
import 'package:super_island/src/models/login_model.dart';
import 'package:super_island/src/utils/app_image.dart';
import 'package:super_island/src/widgets/btn_1.dart';
import 'package:super_island/src/widgets/close_dialog.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({Key? key}) : super(key: key);

  void _showFullScreenKeyboard(
      BuildContext context, TextEditingController textEditingController) {
    showDialog<dynamic>(
      context: context,
      builder: (context) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(child: Container()),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      maxLines: null,
                      autofocus: true,
                      controller: textEditingController,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'),
                  ),
                  const SizedBox(width: 200),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  Widget _dialogContent(BuildContext context) {
    final login = LoginModel();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 18,
              left: 20,
              right: 20,
              bottom: 30,
            ),
            margin: const EdgeInsets.only(
              top: 13,
              right: 8,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgDialog2Image),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            _showFullScreenKeyboard(context, emailController),
                        child: TextFormField(
                          enabled: false,
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: login.setEmail,
                          validator: (value) => login.email.validate(),
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'E-mail',
                            errorMaxLines: 2,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showFullScreenKeyboard(
                            context, passwordController),
                        child: TextFormField(
                          enabled: false,
                          controller: passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: login.setPassword,
                          validator: (value) => login.password.validate(),
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Senha',
                            errorMaxLines: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Btn1(
                        text: 'Ok',
                        callback: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CloseDialog(() => Navigator.of(context).pop()),
        ],
      ),
    );
  }
}
