import 'dart:math';
import 'view.dart';

class ClickEvent {
  final View view;

  final Point<num> offset;

  final int button;

  final DateTime time;

  ClickEvent(this.view, this.offset, this.button, {DateTime time})
      : time = time ?? DateTime.now();

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
