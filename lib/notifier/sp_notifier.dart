import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_salon/model/sp_model.dart';

class SPNotifier with ChangeNotifier {
  List<SPModel> _spList = [];
  SPModel? _currentSp;

  UnmodifiableListView<SPModel> get spList => UnmodifiableListView(_spList);

  SPModel get currentSp => _currentSp!;

  set spList(List<SPModel> spList) {
    _spList = spList;
    notifyListeners();
  }

  set currentSp(SPModel spModel) {
    _currentSp = spModel;
    notifyListeners();
  }
}

getSps(SPNotifier spNotifier) async {
  var snapshot = await FirebaseFirestore.instance.collection('Artists').get();

  List<SPModel> _spList = [];

  snapshot.docs.forEach((element) {
    SPModel spModel = SPModel.fromJson(element.data());
    _spList.add(spModel);
  });

  spNotifier.spList = _spList;
}
