import 'package:flutter/material.dart';

///Provide some field to use in a Widget that contains form
mixin SkadiFormMixin<T extends StatefulWidget> on State<T> {
  final formKey = GlobalKey<FormState>();
  final loadingNotifier = ValueNotifier<bool>(false);
  final passwordObscureNotifier = ValueNotifier<bool>(true);

  void toggleLoading() {
    loadingNotifier.value = !loadingNotifier.value;
  }

  void togglePasswordObscure() {
    passwordObscureNotifier.value = !passwordObscureNotifier.value;
  }

  bool get isFormValidated => formKey.currentState?.validate() ?? true;

  @override
  void dispose() {
    loadingNotifier.dispose();
    passwordObscureNotifier.dispose();
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  Widget PasswordTextFieldBuilder({required Widget Function(bool) builder}) {
    return ValueListenableBuilder<bool>(
      valueListenable: passwordObscureNotifier,
      builder: (context, obscure, child) {
        return builder(obscure);
      },
    );
  }
}
