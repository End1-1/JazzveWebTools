part of 'screen.dart';

extension DishRemovalRequestScreenExt on DishRemovalRequestScreen {
  void _refresh() {
    BlocProvider.of<ABloc>(prefs.context()).add(AEWebQuery({
      'task': 'DishRemovalRequest',
      'subtask': 'report',
      'date1': DateFormat('yyyy-MM-dd').format(date1),
      'date2': DateFormat('yyyy-MM-dd').format(date2),
    }, ASQueryDishRemovalRequests()));
  }
}