import 'package:super_island/src/utils/utils.dart';
import 'package:validators/validators.dart' as validator;

class RegisterModel {
  Email _email = Email('');
  void setEmail(String newEmail) => _email = Email(newEmail);
  Email get email => _email;

  Name _name = Name('');
  void setName(String newName) => _name = Name(newName);
  Name get name => _name;

  Password _password = Password('');
  void setPassword(String newPassword) => _password = Password(newPassword);
  Password get password => _password;

  ConfirmPassword _confirmPassword = ConfirmPassword('');
  void setConfirmPassword(String newConfirmPassword) =>
      _confirmPassword = ConfirmPassword(newConfirmPassword);
  ConfirmPassword get confirmPassword => _confirmPassword;

  String? validate() {
    String? validate = _email.validate();
    if (validate != null) {
      return validate;
    }
    validate = _name.validate();
    if (validate != null) {
      return validate;
    }
    validate = _password.validate();
    if (validate != null) {
      return validate;
    }
    validate = _confirmPassword.validate(_password.value);
    if (validate != null) {
      return validate;
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': _email.value,
      'password': _password.value,
      'name': _name.value,
    };
  }
}

class Email {
  Email(this.value);

  final String value;

  String? validate() {
    if (value.isEmpty) {
      return 'O campo email não pode ser vazio';
    }
    if (!validator.isEmail(value)) {
      return 'E-mail inválido';
    }
    return null;
  }
}

class Name {
  Name(this.value);

  final String value;

  String? validate() {
    if (value.isEmpty) {
      return 'O campo nome não pode ser vazio';
    }
    if (value.trim().length < 3 || value.trim().length > 20) {
      return 'O nome deve conter no mínimo 6 caracteres e no máximo 20 caracteres';
    }
    if (!isName(value)) {
      return 'O nome pode conter letras, números e caractere underscore separando a cada letra, o primeiro e último caractere deve ser alfanuméricos';
    }
    return null;
  }
}

class Password {
  Password(this.value);

  final String value;

  String? validate() {
    if (value.isEmpty) {
      return 'O campo Senha não pode ser vazio';
    }
    if (value.trim().length < 6) {
      return 'A senha deve conter no mínimo 6 caracteres';
    }
    return null;
  }
}

class ConfirmPassword {
  ConfirmPassword(this.value);

  final String value;

  String? validate(String confirmPassword) {
    if (value.isEmpty) {
      return 'O campo Confirmar senha não pode ser vazio';
    }
    if (value.trim().length < 6) {
      return 'A confirmação da senha deve conter no mínimo 6 caracteres';
    }
    if (value.trim() != confirmPassword.trim()) {
      return 'As senhas digitadas estão diferentes';
    }
    return null;
  }
}
