part of 'screen.dart';


extension LoginScreenExt on LoginScreen {
  void _enter() async {
    BlocProvider.of<ABloc>(prefs.context()).add(AEWebQuery({
      'task': 'Login',
      'username': _loginController.text.trim(),
      'password': _passwordController.text.trim()
    }, ASQueryDone()));
  }

  void _enter2(String s) async {
    _enter();
  }

  void _checkRememberMe(bool? v) {
    _rememberMeCheck = v??false;
  }
}