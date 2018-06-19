import 'dart:async';

export 'list.dart';
export 'set.dart';
export 'map.dart';

typedef bool Condition();

typedef T ValueGetter<T>();

typedef void ValueSetter<T>(T value);

class Change<T> {
  final T old;
  final T neu;
  Change(this.neu, this.old);
}

abstract class Reactive<T> {
  T get get;

  set set(T value);

  void setCast(dynamic /* T */ value);

  Stream<Change<T>> get onChange;

  Stream<T> get values;

  factory Reactive({T initial}) => StoredReactive<T>(initial: initial);

  void setHowever(/* T | Stream<T> | Reactive<T> */ other);

  void bind(Reactive<T> reactive);

  void bindStream(Stream<T> stream);
}

class StoredReactive<T> implements Reactive<T> {
  T _value;
  T get get => _value;
  final _change = new StreamController<Change<T>>();
  set set(T value) {
    if (_value == value) return;
    T old = _value;
    _value = value;
    _change.add(Change<T>(value, old));
  }

  StoredReactive({T initial}) : _value = initial {
    _onChange = _change.stream.asBroadcastStream();
  }

  void setCast(dynamic /* T */ value) => set = value;

  Stream<Change<T>> _onChange;

  Stream<Change<T>> get onChange => _onChange;

  Stream<T> get values => _onChange.map((c) => c.neu);

  void bind(Reactive<T> reactive) {
    reactive.values.listen((v) => set = v);
  }

  void bindStream(Stream<T> stream) {
    stream.listen((v) => set = v);
  }

  void setHowever(/* T | Stream<T> | Reactive<T> */ other) {
    if (other is Reactive<T>) {
      bind(other);
    } else if (other is Stream<T>) {
      bindStream(other.cast<T>());
    } else {
      set = other;
    }
  }
}

class BackedReactive<T> implements Reactive<T> {
  ValueGetter<T> getter = _defGetter;
  final _change = new StreamController<Change<T>>();
  BackedReactive({this.getter: _defGetter}) {
    _onChange = _change.stream.asBroadcastStream();
  }

  static T _defGetter<T>() => null;

  T get get => getter();
  set set(T value) {
    T old = get;
    if (old == value) return;
    _change.add(Change<T>(value, old));
  }

  void setCast(dynamic /* T */ value) => set = value;

  Stream<Change<T>> _onChange;

  Stream<Change<T>> get onChange => _onChange;

  Stream<T> get values => _onChange.map((c) => c.neu);

  void bind(Reactive<T> reactive) {
    reactive.values.listen((v) {
      set = v;
    });
  }

  void bindStream(Stream<T> stream) {
    stream.listen((v) => set = v);
  }

  void setHowever(/* T | Stream<T> | Reactive<T> */ other) {
    if (other is Reactive<T>) {
      bind(other);
    } else if (other is Stream<T>) {
      bindStream(other.cast<T>());
    } else {
      set = other;
    }
  }
}