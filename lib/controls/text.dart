import 'package:nuts/nuts.dart';

class TextField implements View, ViewWithWidth, ViewWithClasses {
  String key;
  bool bold;
  String fontFamily;
  String color;
  final IfSet<String> classes;
  Size width;
  Size minWidth;
  Size maxWidth;

  final Callback onClick;

  TextField(
      {/* String | Stream<String> | Reactive<String> */ text,
      this.bold: false,
      this.key,
      this.fontFamily,
      this.color,
      String class_,
      Iterable<String> classes,
      this.width,
      this.minWidth,
      this.maxWidth,
      this.onClick})
      : classes = IfSet<String>.union(classes, class_) {
    textProperty.setHowever(text);
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

class LabeledTextField implements HLabeledView {
  String key;
  TextField labelField;
  TextField textField;
  Size height;
  VAlign vAlign;

  LabeledTextField(
      {String label,
      TextField labelField,
      TextField textField,
      String text,
      this.height,
      this.vAlign,
      this.key})
      : textField = textField ?? TextField(text: text),
        labelField = labelField ?? TextField(text: label) {
    this.labelField.classes.add('label');
  }
}

class VLabeledTextField implements VLabeledView {
  String key;
  TextField labelField;
  TextField textField;
  Size width;
  HAlign hAlign;

  VLabeledTextField(
      {String label,
      TextField labelField,
      TextField textField,
      String text,
      this.width,
      this.hAlign,
      this.key})
      : textField = textField ?? TextField(text: text),
        labelField = labelField ?? TextField(text: label) {
    this.labelField.classes.add('label');
  }
}

class IntField implements View {
  String key;
  final int text;
  final bool bold;

  IntField(this.text, {this.bold, this.key});
}

class LabeledIntField implements HLabeledView {
  String key;
  TextField labelField;
  IntField intField;
  Size height;
  VAlign vAlign;

  LabeledIntField(
      {String label,
      TextField labelField,
      IntField intField,
      int text,
      this.height,
      this.vAlign,
      this.key})
      : intField = intField ?? IntField(text),
        labelField = labelField ?? TextField(text: label) {
    this.labelField.classes.add('label');
  }
}

class VLabeledIntField implements VLabeledView {
  String key;
  TextField labelField;
  IntField intField;
  Size width;
  HAlign hAlign;

  VLabeledIntField(
      {String label,
      TextField labelField,
      IntField intField,
      int text,
      this.width,
      this.hAlign,
      this.key})
      : intField = intField ?? IntField(text),
        labelField = labelField ?? TextField(text: label) {
    this.labelField.classes.add('label');
  }
}

class Button implements View {
  String key;
  final String icon;

  final String text;

  final Callback onClick;

  final String tip;

  final String color;

  final int fontSize;
  final IfSet<String> classes;

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
            : IfSet<String>.union(classes, class_);

  static const String blue = '#2687c1';

  static const String red = 'rgb(208, 51, 51)';

  static const String green = '#19ac19';
}
