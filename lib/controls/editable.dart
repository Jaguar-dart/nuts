import 'package:nuts/nuts.dart';

abstract class EditView<T> implements View {
  BackedReactive<T> get valueProperty;
  T value;
  void setCastValue(v);
}

class TextEdit extends Object
    with WidgetMixin
    implements EditView<String>, Widget {
  String key;
  final IfSet<String> classes;
  String placeholder;
  TextEdit({
    this.placeholder,
    this.key,
    /* String | Stream<String> | Reactive<String> */ value,
    /* Distance | Stream<Distance> | Reactive<Distance> */ width,
    /* Distance | Stream<Distance> | Reactive<Distance> */ minWidth,
    /* Distance | Stream<Distance> | Reactive<Distance> */ maxWidth,
    String class_,
    Iterable<String> classes,
  }) : classes = classes is IfSet<String>
            ? classes
            : IfSet<String>.union(classes, class_) {
    if (classes is IfSet) this.classes.addNonNull(class_);
    valueProperty.setHowever(value);
    widthProperty.setHowever(width);
    minWidthProperty.setHowever(minWidth);
    maxWidthProperty.setHowever(maxWidth);
  }

  final valueProperty = BackedReactive<String>();
  String get value => valueProperty.value;
  set value(String value) => valueProperty.value = value;
  void setCastValue(v) => valueProperty.value = value;
}

class IntEdit extends Object with WidgetMixin implements EditView<int>, Widget {
  String key;
  final IfSet<String> classes;
  String placeholder;
  IntEdit({
    this.placeholder,
    this.key,
    /* int | Stream<int> | Reactive<int> */ value,
    /* Distance | Stream<Distance> | Reactive<Distance> */ width,
    /* Distance | Stream<Distance> | Reactive<Distance> */ minWidth,
    /* Distance | Stream<Distance> | Reactive<Distance> */ maxWidth,
    String class_,
    Iterable<String> classes,
  }) : classes = classes is IfSet<String>
            ? classes
            : IfSet<String>.union(classes, class_) {
    if (classes is IfSet) this.classes.addNonNull(class_);
    valueProperty.setHowever(value);
    widthProperty.setHowever(width);
    minWidthProperty.setHowever(minWidth);
    maxWidthProperty.setHowever(maxWidth);
  }

  final valueProperty = BackedReactive<int>();
  int get value => valueProperty.value;
  set value(int value) => valueProperty.value = value;
  void setCastValue(v) => valueProperty.value = value;
}

class LabeledEdit<T> extends Object
    with WidgetMixin
    implements EditView<T>, HLabeledView, Widget {
  String key;
  final IfSet<String> classes;
  final TextField labelField;
  final EditView<T> labelled;
  final VAlign vAlign;
  LabeledEdit(
    this.labelled, {
    String label,
    Distance height,
    TextField labelField,
    this.vAlign,
    this.key,
    String class_,
    Iterable<String> classes,
  })  : labelField = labelField ?? TextField(text: label),
        classes = classes is IfSet<String>
            ? classes
            : IfSet<String>.union(classes, class_) {
    if (classes is IfSet) this.classes.addNonNull(class_);
    this.height = height;
    this.labelField.classes.add('label');
  }

  BackedReactive<T> get valueProperty => labelled.valueProperty;
  T get value => labelled.value;
  set value(T value) => valueProperty.value = value;
  void setCastValue(v) => valueProperty.value = value;
}

class Form extends Object
    with WidgetMixin
    implements EditView<Map<String, dynamic>>, Widget {
  @override
  String key;
  final IfSet<String> classes;
  final IfList<View> children;
  Distance hLabelWidth; // TODO
  Distance hLabelMinWidth;
  Distance hLabelMaxWidth;

  Form({
    this.key,
    Iterable<View> children,
    View child,
    this.hLabelWidth,
    Distance hLabelMinWidth,
    this.hLabelMaxWidth,
    String class_,
    Iterable<String> classes,
  })  : children = IfList<View>.union(children, child),
        hLabelMinWidth = hLabelMinWidth ?? FixedDistance(100),
        classes = classes is IfSet<String>
            ? classes
            : IfSet<String>.union(classes, class_) {
    if (classes is IfSet) this.classes.addNonNull(class_);

    valueProperty.getter = _normalGetter;
    valueProperty.values.listen(_normalSetter);

    for (View v in this.children) {
      if (v is HLabeledView) {
        if (v.labelField is Widget) {
          final Widget lab = v.labelField as Widget;
          lab.width ??= hLabelWidth;
          lab.minWidth ??= this.hLabelMinWidth;
          lab.maxWidth ??= hLabelMaxWidth;
        }
      }
    }
  }

  final valueProperty = BackedReactive<Map<String, dynamic>>();
  Map<String, dynamic> get value => valueProperty.value;
  set value(Map<String, dynamic> value) => valueProperty.value = value;
  void setCastValue(v) => valueProperty.value = value;

  Map<String, dynamic> _normalGetter() {
    var ret = <String, dynamic>{};
    for (View child in children) {
      if (child is EditView) {
        if (child.key != null) ret[child.key] = child.value;
      }
    }
    return ret;
  }

  void _normalSetter(Map<String, dynamic> values) {
    for (View child in children) {
      if (child is EditView) {
        if (child.key != null && values.containsKey(child.key)) {
          child.setCastValue(values[child.key]);
        }
      }
    }
  }
}
