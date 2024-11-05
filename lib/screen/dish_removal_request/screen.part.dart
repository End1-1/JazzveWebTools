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

  void _openOrder(String id, int cafeid) {

  }

  void _accept(int id, int cafeid) {
    showDialog(
      context: prefs.context(),
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('JazzveWebTools'),
          content: Text(locale().confirmToCancelOrder),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Close dialog and return false
              },
              child: Text(locale().no),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(locale().yes),
            ),
          ],
        );
      },
    ).then((result) {
      if (result == true) {
        BlocProvider.of<ABloc>(prefs.context()).add(AEWebQuery({
          'task': 'DishRemovalRequest',
          'subtask': 'change-status',
          'date1': DateFormat('yyyy-MM-dd').format(date1),
          'date2': DateFormat('yyyy-MM-dd').format(date2),
          'id': id.toString(),
          'cafe': cafeid.toString()
        }, ASQueryOrderRemovalRequests()));
      } else {}
    });
  }
}