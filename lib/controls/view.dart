import 'dart:async';
import 'package:nuts/nuts.dart';

export 'table.dart';
export 'editable.dart';
export 'measure.dart';
export 'containers.dart';
export 'text.dart';

abstract class View {
  String get key;
}

abstract class Component implements View {
  View makeView();
}

typedef dynamic Callback();

enum VAlign { top, middle, bottom }
enum HAlign { left, center, right }

abstract class ViewWithClasses implements View {
  IfSet<String> get classes;
  void bindClass(String class_, Stream<bool> changes);
}

abstract class Container implements View {
  T getByKey<T extends View>(String key);
  T deepGetByKey<T extends View>(Iterable<String> keys);
}

typedef T ValueGetter<T>();

typedef void ValueSetter<T>(T value);

abstract class Value<T> {
  ValueGetter<T> get getter;
  ValueSetter<T> get setter;
}

class DummyValue<T> implements Value<T> {
  T value;
  ValueGetter<T> get getter => () => value;
  ValueSetter<T> get setter => _setter;
  void _setter(T v) => value = v;
}

class ValueFunc<T> implements Value<T> {
  final ValueGetter<T> getter;
  final ValueSetter<T> setter;
  ValueFunc({this.getter, this.setter});
}

class Change<T> {
  final T old;
  final T neu;
  Change(this.neu, this.old);
}

class Bindable<T> {
  T _value;

  final _changes = new StreamController<Change<T>>();

  T get get => _value;

  Bindable() {
    _onChanges = _changes.stream.asBroadcastStream();
  }

  set set(T value) {
    if (_value == value) return;
    T old = _value;
    _value = value;
    _changes.add(Change<T>(value, old));
  }

  Stream<Change<T>> _onChanges;

  Stream<Change<T>> get onChanges => _onChanges;
}