import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_island/src/models/register_model.dart';
import 'package:super_island/src/providers/login_provider.dart';
import 'package:super_island/src/utils/app_image.dart';
import 'package:super_island/src/widgets/btn_1.dart';
import 'package:super_island/src/widgets/close_dialog.dart';

class RegisterDialog extends ConsumerWidget {
  const RegisterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, ref),
    );
  }

  Widget dialogContent(BuildContext context, WidgetRef ref) {
    final register = RegisterModel();

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
                      TextFormField(
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
                      TextFormField(
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
                      TextFormField(
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
                      TextFormField(
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
