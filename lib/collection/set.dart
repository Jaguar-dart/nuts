import 'dart:async';
import 'package:collection/collection.dart';
import 'collection.dart';

class IfSet<E> extends DelegatingSet<E> implements Set<E> {
  IfSet() : super(new Set<E>());

  IfSet.from(Iterable elements) : super(Set<E>.from(elements));

  IfSet.union(Iterable<E> elements, [E element])
      : super(Set<E>.from(elements ?? <E>[])) {
    if (element != null) add(element);
  }

  IfSet.of(Iterable<E> elements) : super(Set<E>.of(elements));

  void addIf(/* bool | Condition */ condition, E element) {
    if (condition is Condition) condition = condition();
    if (condition is bool && condition) add(element);
  }

  void addAllIf(/* bool | Condition */ condition, Iterable<E> elements) {
    if (condition is Condition) condition = condition();
    if (condition is bool && condition) addAll(elements);
  }

  bool add(E element) {
    bool ret = super.add(element);
    if (ret) {
      if (_changes.hasListener) {
        _changes.add(SetChangeNotification<E>.add(element));
      }
    }
    return ret;
  }

  bool remove(Object element) {
    bool hasRemoved = super.remove(element);
    if (hasRemoved) {
      if (_changes.hasListener) {
        _changes.add(SetChangeNotification<E>.remove(element));
      }
    }
    return hasRemoved;
  }

  void clear() {
    Iterable<E> removed = toList();
    super.clear();
    if (_changes.hasListener) {
      for (E el in removed) {
        _changes.add(SetChangeNotification<E>.remove(el));
      }
    }
  }

  Stream<SetChangeNotification<E>> get onChange =>
      _changes.stream.asBroadcastStream();

  final _changes = StreamController<SetChangeNotification<E>>();
}

class Classes extends IfSet<String> {
  Classes() : super();

  Classes.from(Iterable elements) : super.from(elements);

  Classes.union(Iterable<String> elements, [String element])
      : super.union(elements, element);

  Classes.of(Iterable<String> elements) : super.of(elements);

  void bind(String class_, Stream<bool> changes) {
    changes.listen((bool has) {
      if (has)
        add(class_);
      else
        remove(class_);
    });
  }
}

enum SetChangeOp { add, remove }

typedef dynamic SetChangeCallBack<E>(E element, SetChangeOp isAdd, int pos);

class SetChangeNotification<E> {
  final E element;

  final SetChangeOp op;

  SetChangeNotification(this.element, this.op);

  SetChangeNotification.add(this.element) : op = SetChangeOp.add;

  SetChangeNotification.remove(this.element) : op = SetChangeOp.remove;
}
