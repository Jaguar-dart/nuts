import 'package:nuts/nuts.dart';

class Box extends Object with WidgetMixin implements Container {
  final String key;
  final RxList<View> children;
  final RxSet<String> classes;
  HAlign hAlign; // TODO convert to rx property
  VAlign vAlign; // TODO convert to rx property
  final onRemoved = StreamBackedEmitter<void>();
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
    /* String | Stream<String> | Reactive<String> */ color,
    /* String | Stream<String> | Reactive<String> */ backgroundColor,
    /* String | Stream<String> | Reactive<String> */ backgroundImage,
    EdgeInset padding,
    EdgeInset margin,
    /* Callback | ValueCallback */ onClick,
    this.hAlign,
    this.vAlign,
  })  : children = children is RxChildList
            ? children
            : RxList<View>.union(children, child),
        classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);
    if (children is RxChildList) children.addNonNull(child);
    widthProperty.bindOrSet(width);
    minWidthProperty.bindOrSet(minWidth);
    maxWidthProperty.bindOrSet(maxWidth);
    heightProperty.bindOrSet(height);
    minHeightProperty.bindOrSet(minHeight);
    maxHeightProperty.bindOrSet(maxHeight);
    marginLeftProperty.bindOrSet(marginLeft);
    marginTopProperty.bindOrSet(marginTop);
    marginRightProperty.bindOrSet(marginRight);
    marginBottomProperty.bindOrSet(marginBottom);
    paddingLeftProperty.bindOrSet(paddingLeft);
    paddingTopProperty.bindOrSet(paddingTop);
    paddingRightProperty.bindOrSet(paddingRight);
    paddingBottomProperty.bindOrSet(paddingBottom);
    leftProperty.bindOrSet(left);
    topProperty.bindOrSet(top);
    rightProperty.bindOrSet(right);
    bottomProperty.bindOrSet(bottom);
    boldProperty.bindOrSet(bold);
    fontFamilyProperty.bindOrSet(fontFamily);
    colorProperty.bindOrSet(color);
    backgroundColorProperty.bindOrSet(backgroundColor);
    backgroundImageProperty.bindOrSet(backgroundImage);
    if (padding != null) this.padding = padding;
    if (margin != null) this.margin = margin;
    if (onClick != null) this.onClick.on(onClick);
    onRemoved.listen(() {
      for (View c in this.children) {
        emitRemoved(c);
      }
    });
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
  final RxList<View> children;
  final RxSet<String> classes;
  HAlign hAlign; // TODO convert to rx property
  VAlign vAlign; // TODO convert to rx property
  final onRemoved = StreamBackedEmitter<void>();
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
    /* String | Stream<String> | Reactive<String> */ color,
    /* String | Stream<String> | Reactive<String> */ backgroundColor,
    /* String | Stream<String> | Reactive<String> */ backgroundImage,
    EdgeInset padding,
    EdgeInset margin,
    /* Callback | ValueCallback */ onClick,
    this.hAlign,
    this.vAlign: VAlign.middle,
  })  : children = children is RxChildList
            ? children
            : RxList<View>.union(children, child),
        classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);
    if (children is RxChildList) children.addNonNull(child);
    widthProperty.bindOrSet(width);
    minWidthProperty.bindOrSet(minWidth);
    maxWidthProperty.bindOrSet(maxWidth);
    heightProperty.bindOrSet(height);
    minHeightProperty.bindOrSet(minHeight);
    maxHeightProperty.bindOrSet(maxHeight);
    marginLeftProperty.bindOrSet(marginLeft);
    marginTopProperty.bindOrSet(marginTop);
    marginRightProperty.bindOrSet(marginRight);
    marginBottomProperty.bindOrSet(marginBottom);
    paddingLeftProperty.bindOrSet(paddingLeft);
    paddingTopProperty.bindOrSet(paddingTop);
    paddingRightProperty.bindOrSet(paddingRight);
    paddingBottomProperty.bindOrSet(paddingBottom);
    leftProperty.bindOrSet(left);
    topProperty.bindOrSet(top);
    rightProperty.bindOrSet(right);
    bottomProperty.bindOrSet(bottom);
    boldProperty.bindOrSet(bold);
    fontFamilyProperty.bindOrSet(fontFamily);
    colorProperty.bindOrSet(color);
    backgroundColorProperty.bindOrSet(backgroundColor);
    backgroundImageProperty.bindOrSet(backgroundImage);
    if (padding != null) this.padding = padding;
    if (margin != null) this.margin = margin;
    if (onClick != null) this.onClick.on(onClick);
    onRemoved.listen(() {
      for (View c in this.children) {
        emitRemoved(c);
      }
    });
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

class Absolute extends Object with WidgetMixin implements Container {
  String key;
  final RxList<View> children;
  final RxSet<String> classes;
  final onRemoved = StreamBackedEmitter<void>();
  Absolute({
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
    /* String | Stream<String> | Reactive<String> */ color,
    /* String | Stream<String> | Reactive<String> */ backgroundColor,
    /* String | Stream<String> | Reactive<String> */ backgroundImage,
    EdgeInset padding,
    EdgeInset margin,
    /* Callback | ValueCallback */ onClick,
  })  : children = children is RxChildList
            ? children
            : RxList<View>.union(children, child),
        classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);
    if (children is RxChildList) children.addNonNull(child);
    widthProperty.bindOrSet(width);
    minWidthProperty.bindOrSet(minWidth);
    maxWidthProperty.bindOrSet(maxWidth);
    heightProperty.bindOrSet(height);
    minHeightProperty.bindOrSet(minHeight);
    maxHeightProperty.bindOrSet(maxHeight);
    marginLeftProperty.bindOrSet(marginLeft);
    marginTopProperty.bindOrSet(marginTop);
    marginRightProperty.bindOrSet(marginRight);
    marginBottomProperty.bindOrSet(marginBottom);
    paddingLeftProperty.bindOrSet(paddingLeft);
    paddingTopProperty.bindOrSet(paddingTop);
    paddingRightProperty.bindOrSet(paddingRight);
    paddingBottomProperty.bindOrSet(paddingBottom);
    leftProperty.bindOrSet(left);
    topProperty.bindOrSet(top);
    rightProperty.bindOrSet(right);
    bottomProperty.bindOrSet(bottom);
    boldProperty.bindOrSet(bold);
    fontFamilyProperty.bindOrSet(fontFamily);
    colorProperty.bindOrSet(color);
    backgroundColorProperty.bindOrSet(backgroundColor);
    backgroundImageProperty.bindOrSet(backgroundImage);
    if (padding != null) this.padding = padding;
    if (margin != null) this.margin = margin;
    if (onClick != null) this.onClick.on(onClick);
    onRemoved.listen(() {
      for (View c in this.children) {
        emitRemoved(c);
      }
    });
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

class Relative extends Object with WidgetMixin implements Container {
  String key;
  final RxList<View> children;
  final RxSet<String> classes;
  final onRemoved = StreamBackedEmitter<void>();
  Relative({
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
    /* String | Stream<String> | Reactive<String> */ color,
    /* String | Stream<String> | Reactive<String> */ backgroundColor,
    /* String | Stream<String> | Reactive<String> */ backgroundImage,
    EdgeInset padding,
    EdgeInset margin,
    /* Callback | ValueCallback */ onClick,
  })  : children = children is RxChildList
            ? children
            : RxList<View>.union(children, child),
        classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);
    if (children is RxChildList) children.addNonNull(child);
    widthProperty.bindOrSet(width);
    minWidthProperty.bindOrSet(minWidth);
    maxWidthProperty.bindOrSet(maxWidth);
    heightProperty.bindOrSet(height);
    minHeightProperty.bindOrSet(minHeight);
    maxHeightProperty.bindOrSet(maxHeight);
    marginLeftProperty.bindOrSet(marginLeft);
    marginTopProperty.bindOrSet(marginTop);
    marginRightProperty.bindOrSet(marginRight);
    marginBottomProperty.bindOrSet(marginBottom);
    paddingLeftProperty.bindOrSet(paddingLeft);
    paddingTopProperty.bindOrSet(paddingTop);
    paddingRightProperty.bindOrSet(paddingRight);
    paddingBottomProperty.bindOrSet(paddingBottom);
    leftProperty.bindOrSet(left);
    topProperty.bindOrSet(top);
    rightProperty.bindOrSet(right);
    bottomProperty.bindOrSet(bottom);
    boldProperty.bindOrSet(bold);
    fontFamilyProperty.bindOrSet(fontFamily);
    colorProperty.bindOrSet(color);
    backgroundColorProperty.bindOrSet(backgroundColor);
    backgroundImageProperty.bindOrSet(backgroundImage);
    if (padding != null) this.padding = padding;
    if (margin != null) this.margin = margin;
    if (onClick != null) this.onClick.on(onClick);
    onRemoved.listen(() {
      for (View c in this.children) {
        emitRemoved(c);
      }
    });
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

class Tin extends Object with WidgetMixin implements Container {
  String key;
  final RxList<View> children;
  final RxSet<String> classes;
  final onRemoved = StreamBackedEmitter<void>();
  Tin({
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
    /* String | Stream<String> | Reactive<String> */ color,
    /* String | Stream<String> | Reactive<String> */ backgroundColor,
    /* String | Stream<String> | Reactive<String> */ backgroundImage,
    EdgeInset padding,
    EdgeInset margin,
    /* Callback | ValueCallback */ onClick,
  })  : children = children is RxChildList
            ? children
            : RxList<View>.union(children, child),
        classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);
    if (children is RxChildList) children.addNonNull(child);
    widthProperty.bindOrSet(width);
    minWidthProperty.bindOrSet(minWidth);
    maxWidthProperty.bindOrSet(maxWidth);
    heightProperty.bindOrSet(height);
    minHeightProperty.bindOrSet(minHeight);
    maxHeightProperty.bindOrSet(maxHeight);
    marginLeftProperty.bindOrSet(marginLeft);
    marginTopProperty.bindOrSet(marginTop);
    marginRightProperty.bindOrSet(marginRight);
    marginBottomProperty.bindOrSet(marginBottom);
    paddingLeftProperty.bindOrSet(paddingLeft);
    paddingTopProperty.bindOrSet(paddingTop);
    paddingRightProperty.bindOrSet(paddingRight);
    paddingBottomProperty.bindOrSet(paddingBottom);
    leftProperty.bindOrSet(left);
    topProperty.bindOrSet(top);
    rightProperty.bindOrSet(right);
    bottomProperty.bindOrSet(bottom);
    boldProperty.bindOrSet(bold);
    fontFamilyProperty.bindOrSet(fontFamily);
    colorProperty.bindOrSet(color);
    backgroundColorProperty.bindOrSet(backgroundColor);
    backgroundImageProperty.bindOrSet(backgroundImage);
    if (padding != null) this.padding = padding;
    if (margin != null) this.margin = margin;
    if (onClick != null) this.onClick.on(onClick);
    onRemoved.listen(() {
      for (View c in this.children) {
        emitRemoved(c);
      }
    });
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
