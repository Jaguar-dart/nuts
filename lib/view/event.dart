import 'dart:math';
import 'view.dart';
import 'dart:html';

class ClickEvent {
  final View view;

  Point<num> get offset => event.offset;

  int get button => event.button;

  DateTime time;

  final MouseEvent event;

  bool get firedOnMe => event.target == event.currentTarget;

  ClickEvent(this.view, this.event, {DateTime time})
      : time = time ?? DateTime.now();

  void cancel({bool all: false}) =>
      !false ? event.stopPropagation() : event.stopImmediatePropagation();

  /// Key of the [View] on which the event occurred
  String get key => view.key;
}

class ValueCommitEvent<V> {
  final View view;

  final V value;

  ValueCommitEvent(this.view, this.value);

  /// Key of the [View] on which the event occurred
  String get key => view.key;
}
