import 'package:validators/validators.dart' as validator;

class LoginModel {
  Email _email = Email('');
  void setEmail(String newEmail) => _email = Email(newEmail);
  Email get email => _email;

  Password _password = Password('');
  void setPassword(String newPassword) => _password = Password(newPassword);
  Password get password => _password;

  String? validate() {
    String? validate = _email.validate();
    if (validate != null) {
      return validate;
    }
    validate = _password.validate();
    if (validate != null) {
      return validate;
    }
    return null;
  }

  void fromMap(Map<String, dynamic> map) {
    setEmail(map['email'] as String);
    setPassword(map['password'] as String);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': _email.value,
      'password': _password.value,
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

class Password {
  Password(this.value);

  final String value;

  String? validate() {
    if (value.isEmpty) {
      return 'O campo Senha não pode ser vazio';
    }
    return null;
  }
}
