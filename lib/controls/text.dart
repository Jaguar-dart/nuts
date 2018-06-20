import 'package:nuts/nuts.dart';

class TextField extends Object with WidgetMixin implements Widget {
  String key;
  final IfSet<String> classes;
  final Callback onClick;

  TextField(
      {this.key,
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
      /* String | Stream<String> | Reactive<Stream> */ color,
        /* String | Stream<String> | Reactive<Stream> */ backgroundColor,
      String class_,
      Iterable<String> classes,
      this.onClick})
      : classes = classes is IfSet<String>
            ? classes
            : IfSet<String>.union(classes, class_) {
    if (classes is IfSet) this.classes.addNonNull(class_);
    textProperty.setHowever(text);
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
    boldProperty.setHowever(bold);
    fontFamilyProperty.setHowever(fontFamily);
    colorProperty.setHowever(color);
    backgroundColorProperty.setHowever(backgroundColor);
  }

  final textProperty = BackedReactive<String>();
  String get text => textProperty.value;
  set text(String value) => textProperty.value = value;
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
  final IfSet<String> classes;
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
        classes = classes is IfSet<String>
            ? classes
            : IfSet<String>.union(classes, class_) {
    if (classes is IfSet) this.classes.addNonNull(class_);
    this.labelField.classes.add('label'); // TODO remove
    this.height = height;
  }
}

class VLabeledField extends Object
    with WidgetMixin
    implements VLabeledView {
  String key;
  final IfSet<String> classes;
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
        classes = classes is IfSet<String>
            ? classes
            : IfSet<String>.union(classes, class_) {
    if (classes is IfSet) this.classes.addNonNull(class_);
    this.width = width;
    this.labelField.classes.add('label'); // TODO remove
  }
}

class IntField extends Object with WidgetMixin implements View {
  String key;
  final IfSet<String> classes;
  final int text;
  final bool bold;

  IntField(
    this.text, {
    this.bold,
    this.key,
    String class_,
    Iterable<String> classes,
  }) : classes = classes is IfSet<String>
            ? classes
            : IfSet<String>.union(classes, class_) {
    if (classes is IfSet) this.classes.addNonNull(class_);
  }
}

class Button extends Object with WidgetMixin implements Widget {
  String key;
  final IfSet<String> classes;

  final String icon;

  final String text;

  final Callback onClick;

  final String tip;

  final String color;

  final int fontSize;

  Button(
      {this.icon,
      this.text,
      this.onClick,
      this.tip,
      this.color: blue,
      this.fontSize,
      this.key,
      String class_,
      Iterable<String> classes})
      : classes = classes is IfSet<String>
            ? classes
            : IfSet<String>.union(classes, class_) {
    if (classes is IfSet) this.classes.addNonNull(class_);
  }

  static const String blue = '#2687c1';

  static const String red = 'rgb(208, 51, 51)';

  static const String green = '#19ac19';
}
