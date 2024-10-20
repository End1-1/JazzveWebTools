part of 'screen.dart';

extension HomeScreenExt on HomeScreen {
  DateTime _getDate1() {
    return _date1;
  }

  DateTime _getDate2() {
    return _date2;
  }

  Function(DateTime) _getDateFunc() {
    return _setDate1;
  }

  void _openDate1() {
    _getDateFunction = _getDate1;
    _setDateFunction = _setDate1;
    BlocProvider.of<AnimBloc>(prefs.context()).add(AEAnimGo(ASAnimForward()));
  }

  void _openDate2() {
    _getDateFunction = _getDate2;
    _setDateFunction = _setDate2;
    BlocProvider.of<AnimBloc>(prefs.context()).add(AEAnimGo(ASAnimForward()));
  }

  void _setDate1(DateTime d) {
    _date1 = d;
  }

  void _setDate2(DateTime d) {
    _date2 = d;
  }

  void _previousDay() {
    _date1 = _date1.add(const Duration(days: -1));
    _date2 = _date2.add(const Duration(days: -1));
    BlocProvider.of<AnimBloc>(prefs.context()).add(AEAnimGo(ASAnimBackward()));
  }

  void _nextDay() {
    _date1 = _date1.add(const Duration(days: 1));
    _date2 = _date2.add(const Duration(days: 1));
    BlocProvider.of<AnimBloc>(prefs.context()).add(AEAnimGo(ASAnimBackward()));
  }

  void _changeOpenOrderState(bool? v) {
    _includeOpenOrders = v ?? false;
  }

  void _refresh() async {
    _totalAmount = 0;
    _totalQtn = 0;
    _avgOrder = 0;
    _totalAmountp = 0;
    _totalQtnp = 0;
    _avgOrderp = 0;
    _totalAmounto = 0;
    _totalQtno = 0;
    _avgOrdero = 0;
    BlocProvider.of<ABloc>(prefs.context()).add(AEWebQuery({
      'task': 'Report1',
      'date1': DateFormat('yyyy-MM-dd').format(_date1),
      'date2': DateFormat('yyyy-MM-dd').format(_date2),
      'date1p':
          DateFormat('yyyy-MM-dd').format(_date1.add(const Duration(days: -1))),
      'openorder': (_includeOpenOrders ? 1 : 0).toString()
    }, ASQueryCafeList()));
  }
}
