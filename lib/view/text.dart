import 'package:nuts/nuts.dart';

class TextField extends Object with WidgetMixin implements Widget {
  String key;
  final RxSet<String> classes;
  TextField({
    this.key,
    /* String | Stream<String> | Reactive<String> */ text,
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
    /* Distance | Stream<Distance> | Reactive<Distance> */ fontSize,
    /* String | Stream<String> | Reactive<Stream> */ color,
    /* String | Stream<String> | Reactive<Stream> */ backgroundColor,
    String class_,
    Iterable<String> classes,
    /* Callback | ValueCallback */ onClick,
  }) : classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);
    textProperty.bindOrSet(text);
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
    fontSizeProperty.bindOrSet(fontSize);
    colorProperty.bindOrSet(color);
    backgroundColorProperty.bindOrSet(backgroundColor);

    if (onClick != null) this.onClick.on(onClick);
  }

  final textProperty = ProxyValue<String>();
  String get text => textProperty.value;
  set text(String value) => textProperty.value = value;
}

class IntField extends Object with WidgetMixin implements View {
  String key;
  final RxSet<String> classes;
  IntField({
    this.key,
    /* int | Stream<int> | Reactive<int> */ text,
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
    String class_,
    Iterable<String> classes,
    /* Callback | ValueCallback */ onClick,
  }) : classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);
    textProperty.bindOrSet(text);
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

    if (onClick != null) this.onClick.on(onClick);
  }

  final textProperty = ProxyValue<int>();
  int get text => textProperty.value;
  set text(int value) => textProperty.value = value;
}

abstract class LabeledView implements View {
  View get labelField;
}

abstract class VLabeledView implements LabeledView {}

abstract class HLabeledView implements LabeledView {}

class LabeledField extends Object
    with WidgetMixin
    implements HLabeledView, Widget {
  String key;
  final RxSet<String> classes;
  TextField labelField;
  View labelled;
  Distance height;
  VAlign vAlign;

  LabeledField(
    this.labelled, {
    String label,
    TextField labelField,
    Distance height,
    this.vAlign,
    this.key,
    String class_,
    Iterable<String> classes,
  })  : labelField = labelField ?? TextField(text: label),
        classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);
    this.labelField.classes.add('label'); // TODO remove
    this.height = height;
  }
}

class VLabeledField extends Object with WidgetMixin implements VLabeledView {
  String key;
  final RxSet<String> classes;
  TextField labelField;
  View labelled;
  HAlign hAlign;

  VLabeledField(
    this.labelled, {
    String label,
    TextField labelField,
    String text,
    Distance width,
    this.hAlign,
    this.key,
    String class_,
    Iterable<String> classes,
  })  : labelField = labelField ?? TextField(text: label),
        classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);
    this.width = width;
    this.labelField.classes.add('label'); // TODO remove
  }
}

class Button extends Object with WidgetMixin implements Widget {
  String key;
  final RxSet<String> classes;

  final String icon;

  final String text;

  final String tip;

  Button(
      {this.icon,
      this.text,
      /* Callback | ValueCallback */ onClick,
      this.tip,
      /* String | Stream<String> | Reactive<String> */ color,
      /* Distance | Stream<Distance> | Reactive<Distance> */ fontSize,
      this.key,
      String class_,
      Iterable<String> classes})
      : classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);

    fontSizeProperty.bindOrSet(fontSize);
    colorProperty.bindOrSet(color);

    if (onClick != null) this.onClick.on(onClick);
  }

  static const String blue = '#2687c1';

  static const String red = 'rgb(208, 51, 51)';

  static const String green = '#19ac19';
}
