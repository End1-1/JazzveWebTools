part of 'screen.dart';

extension HomeScreenExt on HomeScreen {


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
      'date1': DateFormat('yyyy-MM-dd').format(date1),
      'date2': DateFormat('yyyy-MM-dd').format(date2),
      'date1p':
          DateFormat('yyyy-MM-dd').format(date1.add(const Duration(days: -1))),
      'openorder': (_includeOpenOrders ? 1 : 0).toString()
    }, ASQueryCafeList()));
  }
}
