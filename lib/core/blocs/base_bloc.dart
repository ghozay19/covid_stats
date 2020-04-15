

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BaseBloc {
  final _isLoadingSubject = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get isLoading => _isLoadingSubject.stream;

  void setBusy(){
    _isLoadingSubject.add(true);
  }

  void setIdle(){
    _isLoadingSubject.add(false);
  }

  void dispose(){
    _isLoadingSubject.close();
  }
}