part of 'screen.dart';

extension ScreenDateExt on Screen {
  DateTime getDate1() {
    return date1;
  }

  DateTime getDate2() {
    return date2;
  }

  void openDate1() {
    getDateFunction = getDate1;
    setDateFunction = setDate1;
    BlocProvider.of<AnimBloc>(prefs.context()).add(AEAnimGo(ASAnimForward()));
  }

  void openDate2() {
    getDateFunction = getDate2;
    setDateFunction = setDate2;
    BlocProvider.of<AnimBloc>(prefs.context()).add(AEAnimGo(ASAnimForward()));
  }

  void setDate1(DateTime d) {
    date1 = d;
    BlocProvider.of<AnimBloc>(prefs.context()).add(AEAnimGo(ASAnimBackward()));
  }

  void setDate2(DateTime d) {
    date2 = d;
    BlocProvider.of<AnimBloc>(prefs.context()).add(AEAnimGo(ASAnimBackward()));
  }

  void previousDay() {
    date1 = date1.add(const Duration(days: -1));
    date2 = date2.add(const Duration(days: -1));
    BlocProvider.of<AnimBloc>(prefs.context()).add(AEAnimGo(ASAnimBackward()));
  }

  void nextDay() {
    date1 = date1.add(const Duration(days: 1));
    date2 = date2.add(const Duration(days: 1));
    BlocProvider.of<AnimBloc>(prefs.context()).add(AEAnimGo(ASAnimBackward()));
  }
}
