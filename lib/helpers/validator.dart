import 'package:flutter/material.dart';

String? validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter a Valid Email';
  else
    return null;
}

String? emailValidator(String? value) {
  return value == null ? "Email is required" : validateEmail(value.trim());
}

String? validatePassword(String value) {
  if (value.length < 8) {
    return "Password must be at least 8 characters length";
  } else
    return null;
}

String? passwordValidator(String? value) {
  return value == null ? "Password is required" : validatePassword(value);
}

String? confirmPassword(String? password, String? passwordConfirm) {
  if (passwordConfirm == null) {
    return "Password is required";
  }
  if (password != passwordConfirm) {
    return "Password does not match";
  }
  return null;
}

String? usernameValidator(String? value) {
  value = value == null ? value : value.trim();
  if (value == null || value == "") {
    return "Username is required";
  } else
    return null;
}

bool checkFields(GlobalKey<FormState> formKey) {
  final form = formKey.currentState;
  if (form != null) {
    if (form.validate()) {
      form.save();
      return true;
    }
  }
  return false;
}
