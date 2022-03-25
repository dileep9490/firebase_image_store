mixin InputValidators {
  bool isEmailValid(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(value);
  }

  bool isPasswordValid(String value) {
    return RegExp(r'^.{6,}$').hasMatch(value);
  }

  bool isNameValid(String value) {
    return RegExp(r'^.{3,}$').hasMatch(value);
  }
}
