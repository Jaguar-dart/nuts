import 'package:nuts/nuts.dart';

abstract class EditView<T> implements View {
  ValueGetter<T> readValue;
  ValueSetter<T> setValue;
  void setCastValue(v);
}

class TextEdit implements EditView<String>, ViewWithWidth {
  String key;
  String initial;
  String placeholder;
  bool bold;
  Size width;
  Size minWidth;
  Size maxWidth;
  TextEdit(
      {this.initial,
      this.placeholder,
      this.bold: false,
      this.key,
      this.width,
      this.minWidth,
      this.maxWidth});

  ValueGetter<String> readValue;
  ValueSetter<String> setValue;
  void setCastValue(v) => setValue(v as String);
}

class IntEdit implements EditView<int>, ViewWithWidth {
  String key;
  int initial;
  String placeholder;
  bool bold;
  Size width;
  Size minWidth;
  Size maxWidth;
  IntEdit(
      {this.initial,
      this.placeholder,
      this.bold: false,
      this.key,
      this.width,
      this.minWidth,
      this.maxWidth});

  ValueGetter<int> readValue;
  ValueSetter<int> setValue;
  void setCastValue(v) => setValue(v as int);
}

class LabeledTextEdit implements EditView<String>, HLabeledView {
  String key;
  final TextField labelField;
  final TextEdit editField;
  final int height;
  final VAlign vAlign;
  LabeledTextEdit(
      {String label,
      TextField labelField,
      TextEdit editField,
      String initial,
      String placeholder,
      this.height,
      this.vAlign,
      this.key})
      : editField =
            editField ?? TextEdit(initial: initial, placeholder: placeholder),
        labelField = labelField ?? TextField(label) {
    this.labelField.classes.add('label');
  }

  ValueGetter<String> get readValue => editField.readValue;

  set readValue(ValueGetter<String> value) => editField.readValue = value;

  ValueSetter<String> get setValue => editField.setValue;

  set setValue(ValueSetter<String> value) => editField.setValue = value;
  void setCastValue(v) => setValue(v as String);
}

class LabeledIntEdit implements EditView<int>, HLabeledView {
  String key;
  final TextField labelField;
  final IntEdit editField;
  final int height;
  final VAlign vAlign;
  LabeledIntEdit(
      {String label,
      TextField labelField,
      IntEdit editField,
      int initial,
      String placeholder,
      this.height,
      this.vAlign,
      this.key})
      : editField =
            editField ?? IntEdit(initial: initial, placeholder: placeholder),
        labelField = labelField ?? TextField(label) {
    this.labelField.classes.add('label');
  }

  ValueGetter<int> get readValue => editField.readValue;

  set readValue(ValueGetter<int> value) => editField.readValue = value;

  ValueSetter<int> get setValue => editField.setValue;

  set setValue(ValueSetter<int> value) => editField.setValue = value;
  void setCastValue(v) => setValue(v as int);
}

class Form implements EditView<Map<String, dynamic>>, ViewWithWidth {
  @override
  String key;
  IfList<View> children;
  Size hLabelWidth;
  Size hLabelMinWidth;
  Size hLabelMaxWidth;
  Size width;
  Size minWidth;
  Size maxWidth;

  Form(
      {this.key,
      Iterable<View> children,
      View child,
      this.hLabelWidth,
      this.width,
      this.minWidth,
      this.maxWidth,
      Size hLabelMinWidth,
      this.hLabelMaxWidth})
      : children = IfList<View>.union(children, child),
        hLabelMinWidth = hLabelMinWidth ?? FixedSize(100) {
    readValue = _normalGetter;
    setValue = _normalSetter;

    for (View v in this.children) {
      if (v is HLabeledView) {
        if (v.labelField is ViewWithWidth) {
          final ViewWithWidth lab = v.labelField as ViewWithWidth;
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
