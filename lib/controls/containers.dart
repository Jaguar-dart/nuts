import 'package:nuts/nuts.dart';

class Box extends Object with WidgetMixin implements Container {
  final String key;
  final IfList<View> children;
  final IfSet<String> classes;
  HAlign hAlign; // TODO convert to rx property
  VAlign vAlign; // TODO convert to rx property
  Box({
    View child,
    Iterable<View> children,
    this.key,
    String class_,
    Iterable<String> classes,
    /* Distance | Stream<Distance> | Reactive<Distance> */ width,
    /* Distance | Stream<Distance> | Reactive<Distance> */ minWidth,
    /* Distance | Stream<Distance> | Reactive<Distance> */ maxWidth,
    /* Distance | Stream<Distance> | Reactive<Distance> */ height,
    /* Distance | Stream<Distance> | Reactive<Distance> */ minHeight,
    /* Distance | Stream<Distance> | Reactive<Distance> */ maxHeight,

    /* Distance | Stream<Distance> | Reactive<Distance> */ marginLeft,
    /* Distance | Stream<Distance> | Reactive<Distance> */ marginTop,
    /* Distance | Stream<Distance> | Reactive<Distance> */ marginRight,
    /* Distance | Stream<Distance> | Reactive<Distance> */ marginBottom,

    /* Distance | Stream<Distance> | Reactive<Distance> */ paddingLeft,
    /* Distance | Stream<Distance> | Reactive<Distance> */ paddingTop,
    /* Distance | Stream<Distance> | Reactive<Distance> */ paddingRight,
    /* Distance | Stream<Distance> | Reactive<Distance> */ paddingBottom,

    /* Distance | Stream<Distance> | Reactive<Distance> */ left,
    /* Distance | Stream<Distance> | Reactive<Distance> */ top,
    /* Distance | Stream<Distance> | Reactive<Distance> */ right,
    /* Distance | Stream<Distance> | Reactive<Distance> */ bottom,

    /* bool | Stream<bool> | Reactive<bool> */ bold,

    /* String | Stream<String> | Reactive<String> */ fontFamily,
    /* String | Stream<String> | Reactive<Stream> */ color,
    /* String | Stream<String> | Reactive<Stream> */ backgroundColor,
    EdgeInset padding,
    EdgeInset margin,
    this.hAlign,
    this.vAlign,
  })  : children = children is RxChildList
            ? children
            : IfList<View>.union(children, child),
        classes = classes is IfSet<String>
            ? classes
            : IfSet<String>.union(classes, class_) {
    if (classes is IfSet) this.classes.addNonNull(class_);
    if (children is RxChildList) children.addNonNull(child);
    widthProperty.setHowever(width);
    minWidthProperty.setHowever(minWidth);
    maxWidthProperty.setHowever(maxWidth);
    heightProperty.setHowever(height);
    minHeightProperty.setHowever(minHeight);
    maxHeightProperty.setHowever(maxHeight);
    marginLeftProperty.setHowever(marginLeft);
    marginTopProperty.setHowever(marginTop);
    marginRightProperty.setHowever(marginRight);
    marginBottomProperty.setHowever(marginBottom);
    paddingLeftProperty.setHowever(paddingLeft);
    paddingTopProperty.setHowever(paddingTop);
    paddingRightProperty.setHowever(paddingRight);
    paddingBottomProperty.setHowever(paddingBottom);
    leftProperty.setHowever(left);
    topProperty.setHowever(top);
    rightProperty.setHowever(right);
    bottomProperty.setHowever(bottom);
    boldProperty.setHowever(bold);
    fontFamilyProperty.setHowever(fontFamily);
    colorProperty.setHowever(color);
    backgroundColorProperty.setHowever(backgroundColor);
    if (padding != null) this.padding = padding;
    if (margin != null) this.margin = margin;
  }

  void addChild(View v) => children.add(v);
  void addChildren(Iterable<View> v) => children.addAll(v);

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

class HBox extends Object with WidgetMixin implements Container {
  String key;
  final IfList<View> children;
  final IfSet<String> classes;
  HAlign hAlign; // TODO convert to rx property
  VAlign vAlign; // TODO convert to rx property
  HBox({
    View child,
    Iterable<View> children,
    this.key,
    String class_,
    Iterable<String> classes,
    /* Distance | Stream<Distance> | Reactive<Distance> */ width,
    /* Distance | Stream<Distance> | Reactive<Distance> */ minWidth,
    /* Distance | Stream<Distance> | Reactive<Distance> */ maxWidth,
    /* Distance | Stream<Distance> | Reactive<Distance> */ height,
    /* Distance | Stream<Distance> | Reactive<Distance> */ minHeight,
    /* Distance | Stream<Distance> | Reactive<Distance> */ maxHeight,

    /* Distance | Stream<Distance> | Reactive<Distance> */ marginLeft,
    /* Distance | Stream<Distance> | Reactive<Distance> */ marginTop,
    /* Distance | Stream<Distance> | Reactive<Distance> */ marginRight,
    /* Distance | Stream<Distance> | Reactive<Distance> */ marginBottom,

    /* Distance | Stream<Distance> | Reactive<Distance> */ paddingLeft,
    /* Distance | Stream<Distance> | Reactive<Distance> */ paddingTop,
    /* Distance | Stream<Distance> | Reactive<Distance> */ paddingRight,
    /* Distance | Stream<Distance> | Reactive<Distance> */ paddingBottom,

    /* Distance | Stream<Distance> | Reactive<Distance> */ left,
    /* Distance | Stream<Distance> | Reactive<Distance> */ top,
    /* Distance | Stream<Distance> | Reactive<Distance> */ right,
    /* Distance | Stream<Distance> | Reactive<Distance> */ bottom,

    /* bool | Stream<bool> | Reactive<bool> */ bold,

    /* String | Stream<String> | Reactive<String> */ fontFamily,
    /* String | Stream<String> | Reactive<Stream> */ color,
    /* String | Stream<String> | Reactive<Stream> */ backgroundColor,
    EdgeInset padding,
    EdgeInset margin,
    this.hAlign,
    this.vAlign: VAlign.middle,
  })  : children = children is RxChildList
            ? children
            : IfList<View>.union(children, child),
        classes = classes is IfSet<String>
            ? classes
            : IfSet<String>.union(classes, class_) {
    if (classes is IfSet) this.classes.addNonNull(class_);
    if (children is RxChildList) children.addNonNull(child);
    widthProperty.setHowever(width);
    minWidthProperty.setHowever(minWidth);
    maxWidthProperty.setHowever(maxWidth);
    heightProperty.setHowever(height);
    minHeightProperty.setHowever(minHeight);
    maxHeightProperty.setHowever(maxHeight);
    marginLeftProperty.setHowever(marginLeft);
    marginTopProperty.setHowever(marginTop);
    marginRightProperty.setHowever(marginRight);
    marginBottomProperty.setHowever(marginBottom);
    paddingLeftProperty.setHowever(paddingLeft);
    paddingTopProperty.setHowever(paddingTop);
    paddingRightProperty.setHowever(paddingRight);
    paddingBottomProperty.setHowever(paddingBottom);
    leftProperty.setHowever(left);
    topProperty.setHowever(top);
    rightProperty.setHowever(right);
    bottomProperty.setHowever(bottom);
    boldProperty.setHowever(bold);
    fontFamilyProperty.setHowever(fontFamily);
    colorProperty.setHowever(color);
    backgroundColorProperty.setHowever(backgroundColor);
    if (padding != null) this.padding = padding;
    if (margin != null) this.margin = margin;
  }

  void addChild(View v) => children.add(v);
  void addChildren(Iterable<View> v) => children.addAll(v);

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
