import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:jazzve_web/screen/tools/prefs.dart';

class ASBase {
  var loading = false;
  var message = '';
  var body = '';
}

class ASQueryDone extends ASBase {}

class ASQueryCafeList extends ASBase{}

class ASQueryCafeTotal extends ASBase {
  final int cafe;
  ASQueryCafeTotal(this.cafe);
}

class AEBase {}

class AEWebQuery<T extends ASBase> extends AEBase {
  final Map<String, String> data;
  T state;
  AEWebQuery(this.data, this.state) ;
}

class ABloc extends Bloc<AEBase, ASBase> {
  ABloc(super.initialState) {
    on<AEBase>((event, emit) => emit(ASBase()));
    on<AEWebQuery>((event, emit) => webQuery(event));
  }

  void webQuery(AEWebQuery e) async {
    emit(ASBase()..loading = true);

    final response = await http
        .post(Uri.https(prefs.webHost(), 'engine/index.php'),
            headers: {
              HttpHeaders.authorizationHeader:
                  'Bearer ${prefs.getString('bearer') ?? ''}',
            },
            body: e.data)
        .timeout(const Duration(seconds: 20), onTimeout: () {
      return http.Response('Timeout', 408);
    });

    final bodyStr = utf8.decode(response.bodyBytes);
    if (kDebugMode) {
      print('request ${e.data}');
      print('response ${response.statusCode} ${bodyStr}');
    }
    if (response.statusCode > 299) {
      emit(ASQueryDone()
        ..loading = false
        ..message = bodyStr);
      return;
    }
    emit(e.state
      ..loading = false
      ..body = bodyStr);
  }
}

class ASAnim {}

class ASAnimForward extends ASAnim {}

class ASAnimBackward extends ASAnim {}

class ASAnimMenuClose extends ASAnim {}

class ASAnimMenuOpen extends ASAnim {}

class AEAnim {}

class AEAnimGo extends AEAnim {
  final ASAnim anim;

  AEAnimGo(this.anim);
}

class AnimBloc extends Bloc<AEAnim, ASAnim> {
  AnimBloc(super.initialState) {
    on<AEAnimGo>((event, emit) => emit(event.anim));
  }
}
