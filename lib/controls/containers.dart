import 'package:nuts/nuts.dart';

class Box implements Container, ViewWithClasses {
  final String key;
  final IfList<View> children;
  final IfSet<String> classes; // TODO: Make it, bi-directional
  HAlign hAlign;
  VAlign vAlign;
  final EdgeInset pad;
  final EdgeInset margin;
  Box(
      {View child,
      Iterable<View> children,
      this.key,
      String class_,
      Iterable<String> classes,
      /* Size | Stream<Size> | Reactive<Size> */ width,
      /* Size | Stream<Size> | Reactive<Size> */ height,
      /* String | Stream<String> | Reactive<String> */ backgroundColor,
      this.hAlign,
      this.vAlign,
      this.pad,
      this.margin})
      : children = children is RxChildList
            ? children
            : IfList<View>.union(children, child),
        classes = IfSet<String>.union(classes, class_) {
    if (children is RxChildList) children.addNonNull(child);
    widthProperty.setHowever(width);
    heightProperty.setHowever(height);
    backgroundColorProperty.setHowever(backgroundColor);
  }

  void addChild(View v) => children.add(v);
  void addChildren(Iterable<View> v) => children.addAll(v);

  final widthProperty = BackedReactive<Size>();
  Size get width => widthProperty.value;
  set width(Size value) => widthProperty.value = value;
  final heightProperty = BackedReactive<Size>();
  Size get height => heightProperty.value;
  set height(Size value) => heightProperty.value = value;

  final backgroundColorProperty = BackedReactive<String>();
  String get backgroundColor => backgroundColorProperty.value;
  set backgroundColor(String value) => backgroundColorProperty.value = value;

  T getByKey<T extends View>(String key) =>
      children.firstWhere((v) => v.key == key, orElse: () => null);
  T deepGetByKey<T extends View>(Iterable<String> keys) {
    if (key.length == 0) return null;
    View ret =
        children.firstWhere((v) => v.key == keys.first, orElse: () => null);
    if (ret == null) return null;
    if (keys.length == 1) return ret;
    if (ret is Container) {
      if (keys.length == 2) return ret.getByKey<T>(keys.last);
      return ret.deepGetByKey<T>(keys.skip(1));
    }
    return null;
  }
}

class HBox implements Container, ViewWithClasses {
  String key;
  final IfList<View> children;
  final IfSet<String> classes;
  HAlign hAlign;
  VAlign vAlign;
  final EdgeInset pad;
  final EdgeInset margin;
  HBox(
      {View child,
      Iterable<View> children,
      this.key,
      String class_,
      Iterable<String> classes,
      /* Size | Stream<Size> | Reactive<Size> */ width,
      /* Size | Stream<Size> | Reactive<Size> */ height,
      /* String | Stream<String> | Reactive<String> */ backgroundColor,
      this.hAlign,
      this.vAlign: VAlign.middle,
      this.pad,
      this.margin})
      : children = children is RxChildList
            ? children
            : IfList<View>.union(children, child),
        classes = IfSet<String>.union(classes, class_) {
    if (children is RxChildList) children.addNonNull(child);
    widthProperty.setHowever(width);
    heightProperty.setHowever(height);
    backgroundColorProperty.setHowever(backgroundColor);
  }

  void addChild(View v) => children.add(v);
  void addChildren(Iterable<View> v) => children.addAll(v);

  final widthProperty = BackedReactive<Size>();
  Size get width => widthProperty.value;
  set width(Size value) => widthProperty.value = value;
  final heightProperty = BackedReactive<Size>();
  Size get height => heightProperty.value;
  set height(Size value) => heightProperty.value = value;

  final backgroundColorProperty = BackedReactive<String>();
  String get backgroundColor => backgroundColorProperty.value;
  set backgroundColor(String value) => backgroundColorProperty.value = value;

  T getByKey<T extends View>(String key) =>
      children.firstWhere((v) => v.key == key, orElse: () => null);
  T deepGetByKey<T extends View>(Iterable<String> keys) {
    if (key.length == 0) return null;
    View ret =
        children.firstWhere((v) => v.key == keys.first, orElse: () => null);
    if (ret == null) return null;
    if (keys.length == 1) return ret;
    if (ret is Container) {
      if (keys.length == 2) return ret.getByKey<T>(keys.last);
      return ret.deepGetByKey<T>(keys.skip(1));
    }
    return null;
  }
}
