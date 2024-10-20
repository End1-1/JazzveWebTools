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
}