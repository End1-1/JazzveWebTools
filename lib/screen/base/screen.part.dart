part of 'screen.dart';

extension ScreenExt on Screen {

  AppLocalizations locale() {
    return AppLocalizations.of(prefs.context())!;
  }

  void openLoading() {

  }

  void dialogOk() {
    BlocProvider.of<ABloc>(prefs.context()).add(AEBase());
  }

  void _showMenu() {
      BlocProvider.of<AnimBloc>(prefs.context()).add(AEAnimGo(ASAnimMenuOpen()));
  }

  void _logout() {
    BlocProvider.of<ABloc>(prefs.context()).add(AEBase());
    Navigator.pushAndRemoveUntil(prefs.context(), MaterialPageRoute(builder: (builder) => LoginScreen()), (_) => false);
  }
}