import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc extends BlocBase {

  MainBloc();

  final _isLoadingController = BehaviorSubject<bool>();
  
  Stream<bool> get streamIsLoading => _isLoadingController.stream;
  StreamSink<bool> get sinkIsLoading => _isLoadingController.sink;



  @override
  void dispose() {
    _isLoadingController.close();
  }

}