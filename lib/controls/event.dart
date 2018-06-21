import 'dart:math';
import 'view.dart';

class ClickEvent {
  final View view;

  final Point<num> offset;

  ClickEvent(this.view, this.offset);

  /// Key of the [View] on which the event occurred
  String get key => view.key;
}