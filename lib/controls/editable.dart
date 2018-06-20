import 'package:nuts/nuts.dart';

abstract class EditView<T> implements View {
  // TODO convert [value] to reactive property
  ValueGetter<T> readValue;
  ValueSetter<T> setValue;
  void setCastValue(v);
}

class TextEdit extends Object
    with WidgetMixin
    implements EditView<String>, Widget {
  String key;
  final IfSet<String> classes;
  String initial;
  String placeholder;
  bool bold;
  Distance width;
  Distance minWidth;
  Distance maxWidth;
  TextEdit({
    this.initial,
    this.placeholder,
    this.bold: false,
    this.key,
    this.width,
    this.minWidth,
    this.maxWidth,
    String class_,
    Iterable<String> classes,
  }) : classes = classes is IfSet<String>
            ? classes
            : IfSet<String>.union(classes, class_) {
    if (classes is IfSet) this.classes.addNonNull(class_);
  }

  ValueGetter<String> readValue;
  ValueSetter<String> setValue;
  void setCastValue(v) => setValue(v as String);
}

class IntEdit extends Object with WidgetMixin implements EditView<int>, Widget {
  String key;
  final IfSet<String> classes;
  int initial;
  String placeholder;
  bool bold;
  Distance width;
  Distance minWidth;
  Distance maxWidth;
  IntEdit({
    this.initial,
    this.placeholder,
    this.bold: false,
    this.key,
    this.width,
    this.minWidth,
    this.maxWidth,
    String class_,
    Iterable<String> classes,
  }) : classes = classes is IfSet<String>
            ? classes
            : IfSet<String>.union(classes, class_) {
    if (classes is IfSet) this.classes.addNonNull(class_);
  }

  ValueGetter<int> readValue;
  ValueSetter<int> setValue;
  void setCastValue(v) => setValue(v as int);
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

  ValueGetter<T> get readValue => labelled.readValue;

  set readValue(ValueGetter<T> value) => labelled.readValue = value;

  ValueSetter<T> get setValue => labelled.setValue;

  set setValue(ValueSetter<T> value) => labelled.setValue = value;
  void setCastValue(v) => setValue(v as T);
}

class Form extends Object
    with WidgetMixin
    implements EditView<Map<String, dynamic>>, Widget {
  @override
  String key;
  final IfSet<String> classes;
  IfList<View> children;
  Distance hLabelWidth;
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
    readValue = _normalGetter;
    setValue = _normalSetter;

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
  void setCastValue(v) => setValue(v as Map<String, dynamic>);

  ValueGetter<Map<String, dynamic>> readValue;

  ValueSetter<Map<String, dynamic>> setValue;

  Map<String, dynamic> _normalGetter() {
    var ret = <String, dynamic>{};
    for (View child in children) {
      if (child is EditView) {
        if (child.key != null) ret[child.key] = child.readValue();
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
