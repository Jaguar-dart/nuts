import 'dart:async';
import 'package:collection/collection.dart';
import 'collection.dart';

class IfList<E> extends DelegatingList<E> implements List<E> {
  IfList([int length]) : super(length != null ? List<E>(length) : List<E>());

  IfList.filled(int length, E fill, {bool growable: false})
      : super(List<E>.filled(length, fill, growable: growable));

  IfList.from(Iterable<E> elements, {bool growable: true})
      : super(List<E>.from(elements, growable: growable));

  IfList.union(Iterable<E> elements, [E element])
      : super(elements?.toList() ?? <E>[]) {
    if (element != null) add(element);
  }

  IfList.of(Iterable<E> elements, {bool growable: true})
      : super(List<E>.of(elements, growable: growable));

  IfList.generate(int length, E generator(int index), {bool growable: true})
      : super(List<E>.generate(length, generator, growable: growable));

  void addIf(/* bool | Condition */ condition, E element) {
    if (condition is Condition) condition = condition();
    if (condition is bool && condition) add(element);
  }

  void addAllIf(/* bool | Condition */ condition, Iterable<E> elements) {
    if (condition is Condition) condition = condition();
    if (condition is bool && condition) addAll(elements);
  }

  operator []=(int index, E value) {
    super[index] = value;
    if (_changes.hasListener) {
      _changes.add(ListChangeNotification<E>.set(value, index));
    }
  }

  void add(E element) {
    super.add(element);
    if (_changes.hasListener) {
      _changes.add(ListChangeNotification<E>.add(element, length - 1));
    }
  }

  bool remove(Object element) {
    int pos = indexOf(element);
    bool hasRemoved = super.remove(element);
    if (hasRemoved) {
      if (_changes.hasListener) {
        _changes.add(ListChangeNotification<E>.remove(element, pos));
      }
    }
    return hasRemoved;
  }

  void clear() {
    super.clear();
    if (_changes.hasListener) {
      _changes.add(ListChangeNotification<E>.clear());
    }
  }

  void assign(E element) {
    clear();
    add(element);
  }

  void assignAll(Iterable<E> elements) {
    clear();
    addAll(elements);
  }

  Stream<ListChangeNotification<E>> get onChange =>
      _changesStream.skipWhile((c) => c.time.isBefore(DateTime.now()));

  Stream<ListChangeNotification<E>> __changesStream;

  Stream<ListChangeNotification<E>> get _changesStream =>
      __changesStream ??= _changes.stream.asBroadcastStream();

  final _changes = StreamController<ListChangeNotification<E>>();
}

enum ListChangeOp { add, remove, clear, set }

typedef dynamic ListChangeCallBack<E>(E element, ListChangeOp isAdd, int pos);

class ListChangeNotification<E> {
  final E element;

  final ListChangeOp op;

  final int pos;

  final DateTime time;

  ListChangeNotification(this.element, this.op, this.pos, {DateTime time})
      : time = time ?? new DateTime.now();

  ListChangeNotification.add(this.element, this.pos, {DateTime time})
      : op = ListChangeOp.add,
        time = time ?? new DateTime.now();

  ListChangeNotification.set(this.element, this.pos, {DateTime time})
      : op = ListChangeOp.set,
        time = time ?? new DateTime.now();

  ListChangeNotification.remove(this.element, this.pos, {DateTime time})
      : op = ListChangeOp.remove,
        time = time ?? new DateTime.now();

  ListChangeNotification.clear({DateTime time})
      : op = ListChangeOp.clear,
        pos = null,
        element = null,
        time = time ?? new DateTime.now();
}
