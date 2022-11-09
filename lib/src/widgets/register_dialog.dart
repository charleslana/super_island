import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_island/src/models/register_model.dart';
import 'package:super_island/src/providers/login_provider.dart';
import 'package:super_island/src/utils/app_image.dart';
import 'package:super_island/src/widgets/btn_1.dart';
import 'package:super_island/src/widgets/close_dialog.dart';

class RegisterDialog extends ConsumerWidget {
  const RegisterDialog({Key? key}) : super(key: key);

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
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context, ref),
    );
  }

  Widget _dialogContent(BuildContext context, WidgetRef ref) {
    final register = RegisterModel();
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 30,
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
                image: AssetImage(bgDialog1Image),
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
                      'Cadastre-se',
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
                          onChanged: register.setEmail,
                          validator: (value) => register.email.validate(),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'E-mail',
                            errorMaxLines: 2,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            _showFullScreenKeyboard(context, nameController),
                        child: TextFormField(
                          enabled: false,
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: register.setName,
                          validator: (value) => register.name.validate(),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Nome',
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
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: register.setPassword,
                          validator: (value) => register.password.validate(),
                          keyboardType: TextInputType.name,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Senha',
                            errorMaxLines: 2,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showFullScreenKeyboard(
                            context, confirmPasswordController),
                        child: TextFormField(
                          enabled: false,
                          controller: confirmPasswordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: register.setConfirmPassword,
                          validator: (value) => register.confirmPassword
                              .validate(register.password.value),
                          keyboardType: TextInputType.name,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Confirme a senha',
                            errorMaxLines: 3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Btn1(
                        text: 'Ok',
                        callback: () {
                          ref.read(loginProvider.notifier).toggleLogged();
                          Navigator.of(context).pop();
                        },
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
