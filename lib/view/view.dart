import 'dart:async';
import 'package:nuts/nuts.dart';

export 'containers.dart';
export 'editable.dart';
export 'event.dart';
export 'measure.dart';
export 'table.dart';
export 'text.dart';

abstract class View {
  String get key;
}

abstract class RemoveProcessor implements View {
  Emitter<void> get onRemoved;
}

void emitRemoved(View view) {
  if (view is RemoveProcessor) view.onRemoved.emitOne(null);
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
  VariableView.rx(RxValue<T> rx, this.viewMaker, {this.key})
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
  RxSet<String> get classes;
  ProxyValue<dynamic /* Distance | num */ > get widthProperty;
  dynamic /* Distance | num */ width;
  ProxyValue<Distance> get minWidthProperty;
  Distance minWidth;
  ProxyValue<Distance> get maxWidthProperty;
  Distance maxWidth;
  ProxyValue<dynamic /* Distance | num */ > get heightProperty;
  dynamic /* Distance | num */ height;
  ProxyValue<Distance> get minHeightProperty;
  Distance minHeight;
  ProxyValue<Distance> get maxHeightProperty;
  Distance maxHeight;
  ProxyValue<Distance> get marginLeftProperty;
  Distance marginLeft;
  ProxyValue<Distance> get marginTopProperty;
  Distance marginTop;
  ProxyValue<Distance> get marginRightProperty;
  Distance marginRight;
  ProxyValue<Distance> get marginBottomProperty;
  Distance marginBottom;
  ProxyValue<Distance> get paddingLeftProperty;
  Distance paddingLeft;
  ProxyValue<Distance> get paddingTopProperty;
  Distance paddingTop;
  ProxyValue<Distance> get paddingRightProperty;
  Distance paddingRight;
  ProxyValue<Distance> get paddingBottomProperty;
  Distance paddingBottom;
  ProxyValue<dynamic /* Distance | num */ > get leftProperty;
  dynamic /* Distance | num */ left;
  ProxyValue<dynamic /* Distance | num */ > get topProperty;
  dynamic /* Distance | num */ top;
  ProxyValue<dynamic /* Distance | num */ > get rightProperty;
  dynamic /* Distance | num */ right;
  ProxyValue<dynamic /* Distance | num */> get bottomProperty;
  dynamic /* Distance | num */ bottom;
  ProxyValue<bool> get boldProperty;
  bool bold;
  ProxyValue<String> get fontFamilyProperty;
  String fontFamily;
  ProxyValue<Distance> get fontSizeProperty;
  Distance fontSize;
  ProxyValue<String> get colorProperty;
  String color;
  ProxyValue<String> get backgroundColorProperty;
  String backgroundColor;
  ProxyValue<String> get backgroundImageProperty;
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
  RxList<View> get children;
}

abstract class WidgetMixin implements Widget {
  final widthProperty = ProxyValue<dynamic>();
  dynamic get width => widthProperty.value;
  set width(dynamic value) => widthProperty.value = value;

  final minWidthProperty = ProxyValue<Distance>();
  Distance get minWidth => minWidthProperty.value;
  set minWidth(Distance value) => minWidthProperty.value = value;

  final maxWidthProperty = ProxyValue<Distance>();
  Distance get maxWidth => maxWidthProperty.value;
  set maxWidth(Distance value) => maxWidthProperty.value = value;

  final heightProperty = ProxyValue<dynamic>();
  dynamic get height => heightProperty.value;
  set height(dynamic value) => heightProperty.value = value;

  final minHeightProperty = ProxyValue<Distance>();
  Distance get minHeight => minHeightProperty.value;
  set minHeight(Distance value) => minHeightProperty.value = value;

  final maxHeightProperty = ProxyValue<Distance>();
  Distance get maxHeight => maxHeightProperty.value;
  set maxHeight(Distance value) => maxHeightProperty.value = value;

  final marginLeftProperty = ProxyValue<Distance>();
  Distance get marginLeft => marginLeftProperty.value;
  set marginLeft(Distance value) => marginLeftProperty.value = value;

  final marginTopProperty = ProxyValue<Distance>();
  Distance get marginTop => marginTopProperty.value;
  set marginTop(Distance value) => marginTopProperty.value = value;

  final marginRightProperty = ProxyValue<Distance>();
  Distance get marginRight => marginRightProperty.value;
  set marginRight(Distance value) => marginRightProperty.value = value;

  final marginBottomProperty = ProxyValue<Distance>();
  Distance get marginBottom => marginBottomProperty.value;
  set marginBottom(Distance value) => marginBottomProperty.value = value;

  final paddingLeftProperty = ProxyValue<Distance>();
  Distance get paddingLeft => paddingLeftProperty.value;
  set paddingLeft(Distance value) => paddingLeftProperty.value = value;

  final paddingTopProperty = ProxyValue<Distance>();
  Distance get paddingTop => paddingTopProperty.value;
  set paddingTop(Distance value) => paddingTopProperty.value = value;

  final paddingRightProperty = ProxyValue<Distance>();
  Distance get paddingRight => paddingRightProperty.value;
  set paddingRight(Distance value) => paddingRightProperty.value = value;

  final paddingBottomProperty = ProxyValue<Distance>();
  Distance get paddingBottom => paddingBottomProperty.value;
  set paddingBottom(Distance value) => paddingBottomProperty.value = value;

  final leftProperty = ProxyValue<dynamic>();
  dynamic get left => leftProperty.value;
  set left(dynamic value) => leftProperty.value = value;

  final topProperty = ProxyValue<dynamic>();
  dynamic get top => topProperty.value;
  set top(dynamic value) => topProperty.value = value;

  final rightProperty = ProxyValue<dynamic>();
  dynamic get right => rightProperty.value;
  set right(dynamic value) => rightProperty.value = value;

  final bottomProperty = ProxyValue<dynamic>();
  dynamic get bottom => bottomProperty.value;
  set bottom(dynamic value) => bottomProperty.value = value;

  final boldProperty = ProxyValue<bool>();
  bool get bold => boldProperty.value;
  set bold(bool value) => boldProperty.value = value;

  final fontFamilyProperty = ProxyValue<String>();
  String get fontFamily => fontFamilyProperty.value;
  set fontFamily(String value) => fontFamilyProperty.value = value;

  final fontSizeProperty = ProxyValue<Distance>();
  Distance get fontSize => fontSizeProperty.value;
  set fontSize(Distance value) => fontSizeProperty.value = value;

  final colorProperty = ProxyValue<String>();
  String get color => colorProperty.value;
  set color(String value) => colorProperty.value = value;

  final backgroundColorProperty = ProxyValue<String>();
  String get backgroundColor => backgroundColorProperty.value;
  set backgroundColor(String value) => backgroundColorProperty.value = value;

  final backgroundImageProperty = ProxyValue<String>();
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

class RxChildList<S> extends BoundList<S, View> {
  RxChildList(RxList<S> binding, ChildrenListComposer<S, View> composer)
      : super(binding, composer);
}
