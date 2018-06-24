import 'dart:async';
import 'package:nuts/nuts.dart';

export 'containers.dart';
export 'editable.dart';
export 'event.dart';
export 'measure.dart';
export 'table.dart';
export 'text.dart';

export 'package:nuts/collection/collection.dart';

abstract class View {
  String get key;
}

abstract class RemoveProcessor implements View {
  EmitableEmitter<void> get onRemoved;
}

void emitRemoved(View view) {
  if (view is RemoveProcessor) view.onRemoved.emit(null);
  if (view is Component) emitRemoved(view.view);
}

abstract class Component implements View {
  View get view;
}

typedef View MakeViewFor<T>(T value);

/// A pseudo-component that can reactively render different views
class VariableView<T> implements View, RemoveProcessor {
  final String key;
  final Stream<T> rebuildOn;
  final MakeViewFor<T> viewMaker;
  final T initial;
  final onRemoved = StreamBackedEmitter<void>();
  VariableView(this.initial, this.rebuildOn, this.viewMaker, {this.key});
  VariableView.rx(Reactive<T> rx, this.viewMaker, {this.key})
      : initial = rx.value,
        rebuildOn = rx.values;
  View makeView(dynamic /* T */ v) => viewMaker(v as T);
}

// TODO
abstract class ConditionalComponent implements Component {}

// TODO
abstract class BoolComponent implements Component {}

enum VAlign { top, middle, bottom }
enum HAlign { left, center, right }

abstract class Widget implements View {
  IfSet<String> get classes;
  BackedReactive<Distance> get widthProperty;
  Distance width;
  BackedReactive<Distance> get minWidthProperty;
  Distance minWidth;
  BackedReactive<Distance> get maxWidthProperty;
  Distance maxWidth;
  BackedReactive<Distance> get heightProperty;
  Distance height;
  BackedReactive<Distance> get minHeightProperty;
  Distance minHeight;
  BackedReactive<Distance> get maxHeightProperty;
  Distance maxHeight;
  BackedReactive<Distance> get marginLeftProperty;
  Distance marginLeft;
  BackedReactive<Distance> get marginTopProperty;
  Distance marginTop;
  BackedReactive<Distance> get marginRightProperty;
  Distance marginRight;
  BackedReactive<Distance> get marginBottomProperty;
  Distance marginBottom;
  BackedReactive<Distance> get paddingLeftProperty;
  Distance paddingLeft;
  BackedReactive<Distance> get paddingTopProperty;
  Distance paddingTop;
  BackedReactive<Distance> get paddingRightProperty;
  Distance paddingRight;
  BackedReactive<Distance> get paddingBottomProperty;
  Distance paddingBottom;
  BackedReactive<Distance> get leftProperty;
  Distance left;
  BackedReactive<Distance> get topProperty;
  Distance top;
  BackedReactive<Distance> get rightProperty;
  Distance right;
  BackedReactive<Distance> get bottomProperty;
  Distance bottom;
  BackedReactive<bool> get boldProperty;
  bool bold;
  BackedReactive<String> get fontFamilyProperty;
  String fontFamily;
  BackedReactive<String> get colorProperty;
  String color;
  BackedReactive<String> get backgroundColorProperty;
  String backgroundColor;
  BackedReactive<String> get backgroundImageProperty;
  String backgroundImage;

  // TODO padding property
  EdgeInset padding;
  // TODO margin property
  EdgeInset margin;

  StreamBackedEmitter<ClickEvent> get onClick;
  StreamBackedEmitter<ClickEvent> get onMouseDown;
  StreamBackedEmitter<ClickEvent> get onMouseMove;
  StreamBackedEmitter<ClickEvent> get onMouseUp;
}

abstract class Container implements Widget, RemoveProcessor {
  T getByKey<T extends View>(String key);
  T deepGetByKey<T extends View>(Iterable<String> keys);
  IfList<View> get children;
}

abstract class WidgetMixin implements Widget {
  final widthProperty = BackedReactive<Distance>();
  Distance get width => widthProperty.value;
  set width(Distance value) => widthProperty.value = value;

  final minWidthProperty = BackedReactive<Distance>();
  Distance get minWidth => minWidthProperty.value;
  set minWidth(Distance value) => minWidthProperty.value = value;

  final maxWidthProperty = BackedReactive<Distance>();
  Distance get maxWidth => maxWidthProperty.value;
  set maxWidth(Distance value) => maxWidthProperty.value = value;

  final heightProperty = BackedReactive<Distance>();
  Distance get height => heightProperty.value;
  set height(Distance value) => heightProperty.value = value;

  final minHeightProperty = BackedReactive<Distance>();
  Distance get minHeight => minHeightProperty.value;
  set minHeight(Distance value) => minHeightProperty.value = value;

  final maxHeightProperty = BackedReactive<Distance>();
  Distance get maxHeight => maxHeightProperty.value;
  set maxHeight(Distance value) => maxHeightProperty.value = value;

  final marginLeftProperty = BackedReactive<Distance>();
  Distance get marginLeft => marginLeftProperty.value;
  set marginLeft(Distance value) => marginLeftProperty.value = value;

  final marginTopProperty = BackedReactive<Distance>();
  Distance get marginTop => marginTopProperty.value;
  set marginTop(Distance value) => marginTopProperty.value = value;

  final marginRightProperty = BackedReactive<Distance>();
  Distance get marginRight => marginRightProperty.value;
  set marginRight(Distance value) => marginRightProperty.value = value;

  final marginBottomProperty = BackedReactive<Distance>();
  Distance get marginBottom => marginBottomProperty.value;
  set marginBottom(Distance value) => marginBottomProperty.value = value;

  final paddingLeftProperty = BackedReactive<Distance>();
  Distance get paddingLeft => paddingLeftProperty.value;
  set paddingLeft(Distance value) => paddingLeftProperty.value = value;

  final paddingTopProperty = BackedReactive<Distance>();
  Distance get paddingTop => paddingTopProperty.value;
  set paddingTop(Distance value) => paddingTopProperty.value = value;

  final paddingRightProperty = BackedReactive<Distance>();
  Distance get paddingRight => paddingRightProperty.value;
  set paddingRight(Distance value) => paddingRightProperty.value = value;

  final paddingBottomProperty = BackedReactive<Distance>();
  Distance get paddingBottom => paddingBottomProperty.value;
  set paddingBottom(Distance value) => paddingBottomProperty.value = value;

  final leftProperty = BackedReactive<Distance>();
  Distance get left => leftProperty.value;
  set left(Distance value) => leftProperty.value = value;

  final topProperty = BackedReactive<Distance>();
  Distance get top => topProperty.value;
  set top(Distance value) => topProperty.value = value;

  final rightProperty = BackedReactive<Distance>();
  Distance get right => rightProperty.value;
  set right(Distance value) => rightProperty.value = value;

  final bottomProperty = BackedReactive<Distance>();
  Distance get bottom => bottomProperty.value;
  set bottom(Distance value) => bottomProperty.value = value;

  final boldProperty = BackedReactive<bool>();
  bool get bold => boldProperty.value;
  set bold(bool value) => boldProperty.value = value;

  final fontFamilyProperty = BackedReactive<String>();
  String get fontFamily => fontFamilyProperty.value;
  set fontFamily(String value) => fontFamilyProperty.value = value;

  final colorProperty = BackedReactive<String>();
  String get color => colorProperty.value;
  set color(String value) => colorProperty.value = value;

  final backgroundColorProperty = BackedReactive<String>();
  String get backgroundColor => backgroundColorProperty.value;
  set backgroundColor(String value) => backgroundColorProperty.value = value;

  final backgroundImageProperty = BackedReactive<String>();
  String get backgroundImage => backgroundImageProperty.value;
  set backgroundImage(String value) => backgroundImageProperty.value = value;

  EdgeInset get padding => EdgeInset(
      left: paddingLeft,
      top: paddingTop,
      right: paddingRight,
      bottom: paddingBottom);

  set padding(EdgeInset value) {
    paddingLeft = value.left;
    paddingTop = value.top;
    paddingRight = value.right;
    paddingBottom = value.bottom;
  }

  EdgeInset get margin => EdgeInset(
      left: marginLeft,
      top: marginTop,
      right: marginRight,
      bottom: marginBottom);

  set margin(EdgeInset value) {
    marginLeft = value.left;
    marginTop = value.top;
    marginRight = value.right;
    marginBottom = value.bottom;
  }

  final onClick = StreamBackedEmitter<ClickEvent>();
  final onMouseDown = StreamBackedEmitter<ClickEvent>();
  final onMouseMove = StreamBackedEmitter<ClickEvent>();
  final onMouseUp = StreamBackedEmitter<ClickEvent>();
}
