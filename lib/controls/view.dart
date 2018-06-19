import 'dart:async';
import 'package:nuts/nuts.dart';

export 'containers.dart';
export 'editable.dart';
export 'measure.dart';
export 'table.dart';
export 'text.dart';

abstract class View {
  String get key;
}

abstract class Component implements View {
  View makeView();
}

typedef View MakeViewFor<T>(T value);

/// A pseudo-component that can reactively render different views
class VariableView<T> implements View {
  final String key;
  final Stream<T> rebuildOn;
  final MakeViewFor<T> viewMaker;
  final T initial;
  VariableView(this.initial, this.rebuildOn, this.viewMaker, {this.key});
  View makeView(dynamic /* T */ v) => viewMaker(v as T);
}

// TODO
abstract class ConditionalComponent implements Component {}

// TODO
abstract class BoolComponent implements Component {}

typedef dynamic Callback();

enum VAlign { top, middle, bottom }
enum HAlign { left, center, right }

abstract class ViewWithClasses implements View {
  IfSet<String> get classes;
}

abstract class Container implements View {
  T getByKey<T extends View>(String key);
  T deepGetByKey<T extends View>(Iterable<String> keys);
}