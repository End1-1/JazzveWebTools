part of 'screen.dart';

extension OrderRemovalRequestExt on OrderRemovalRequestScreen {
  void _refresh() async {
    BlocProvider.of<ABloc>(prefs.context()).add(AEWebQuery({
      'task': 'OrderRemovalRequest',
      'subtask': 'report',
      'date1': DateFormat('yyyy-MM-dd').format(date1),
      'date2': DateFormat('yyyy-MM-dd').format(date2),
    }, ASQueryOrderRemovalRequests()));
  }
}