import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manilab_coquito/db/fabula_model.dart';

class HomeController {
  BuildContext? context;
  Function? refreshView;
  List<FabulaModel> listFabula = [];
  Future init(BuildContext context, Function refreshView) async {
    this.context = context;
    this.refreshView = refreshView;
    AppVisible();
  }

  void AppVisible() async {
    try {
      listFabula = await loadFabulas();
      refreshView!();
    } catch (e) {
      showErrorInConsole(e);
    }
  }

  showErrorInConsole(e) {
    print('###################### ERROR ##################################');
    print('ERROR___HOME!');
    print(e);
    print('###################### ERROR ##################################');
  }
}