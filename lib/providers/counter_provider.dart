import 'package:flutter/cupertino.dart';

class CounterState{
  int _value = 1;

  increment(){
    _value++;
  }
  decrement(){
    _value--;
  } 

  int get value => _value;

  bool diff(CounterState old){
    return old == null || old.value != this.value;
  }
}

class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  CounterProvider({Widget child}) : super(child:child);

  static CounterProvider of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

}