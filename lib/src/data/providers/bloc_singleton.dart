import 'package:rxdart/rxdart.dart';

GlobalBloc globalBloc = GlobalBloc();

class GlobalBloc{

  // Streams related to this bloc
  BehaviorSubject<String> _controller = BehaviorSubject<String>();
  Function(String) get push => _controller.sink.add;
  Stream<String> get stream => _controller;

  // Singleton factory
  GlobalBloc._internal();
  static final GlobalBloc _bloc = GlobalBloc._internal();
  factory GlobalBloc(){
    return _bloc;
  }

  // Resource disposal
  void dispose(){
    _controller?.close();
  }
}