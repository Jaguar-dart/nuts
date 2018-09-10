import 'package:nuts/nuts.dart';

abstract class EditView<T> implements View {
  ProxyValue<T> get valueProperty;
  T value;
  void setCastValue(v);
  StreamBackedEmitter<ValueCommitEvent<T>> get onCommit;
}

abstract class EditWidget<T> implements EditView<T>, Widget {}

class TextEdit extends Object with WidgetMixin implements EditWidget<String> {
  String key;
  final RxSet<String> classes;
  String placeholder;
  final onCommit = StreamBackedEmitter<ValueCommitEvent<String>>();
  final bool shouldEscape;
  TextEdit({
    this.placeholder,
    this.key,
    /* String | Stream<String> | Reactive<String> */ value,
    /* Distance | Stream<Distance> | Reactive<Distance> */ width,
    /* Distance | Stream<Distance> | Reactive<Distance> */ minWidth,
    /* Distance | Stream<Distance> | Reactive<Distance> */ maxWidth,

    /* bool | Stream<bool> | Reactive<bool> */ bold,

    /* String | Stream<String> | Reactive<String> */ fontFamily,
    /* String | Stream<String> | Reactive<Stream> */ color,
    /* String | Stream<String> | Reactive<Stream> */ backgroundColor,
    this.shouldEscape: true,
    String class_,
    Iterable<String> classes,
    /* Callback | ValueCallback<String> */ onCommit,
  }) : classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);
    valueProperty.bindOrSet(value);
    widthProperty.bindOrSet(width);
    minWidthProperty.bindOrSet(minWidth);
    maxWidthProperty.bindOrSet(maxWidth);
    boldProperty.bindOrSet(bold);
    fontFamilyProperty.bindOrSet(fontFamily);
    colorProperty.bindOrSet(color);
    backgroundColorProperty.bindOrSet(backgroundColor);
    if (onCommit != null) this.onCommit.on(onCommit);
  }

  final valueProperty = ProxyValue<String>();
  String get value => valueProperty.value;
  set value(String value) => valueProperty.value = value;
  void setCastValue(v) => valueProperty.value = value;
}

class IntEdit extends Object with WidgetMixin implements EditWidget<int> {
  String key;
  final RxSet<String> classes;
  String placeholder;
  final onCommit = StreamBackedEmitter<ValueCommitEvent<int>>();
  final bool shouldEscape;
  IntEdit({
    this.placeholder,
    this.key,
    /* int | Stream<int> | Reactive<int> */ value,
    /* Distance | Stream<Distance> | Reactive<Distance> */ width,
    /* Distance | Stream<Distance> | Reactive<Distance> */ minWidth,
    /* Distance | Stream<Distance> | Reactive<Distance> */ maxWidth,
    this.shouldEscape: true,
    String class_,
    Iterable<String> classes,
    /* Callback | ValueCallback<int> */ onCommit,
  }) : classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);
    valueProperty.bindOrSet(value);
    widthProperty.bindOrSet(width);
    minWidthProperty.bindOrSet(minWidth);
    maxWidthProperty.bindOrSet(maxWidth);
    if (onCommit != null) this.onCommit.on(onCommit);
  }

  final valueProperty = ProxyValue<int>();
  int get value => valueProperty.value;
  set value(int value) => valueProperty.value = value;
  void setCastValue(v) => valueProperty.value = value;
}

class LabeledEdit<T> extends Object
    with WidgetMixin
    implements EditView<T>, HLabeledView, Widget {
  String key;
  final RxSet<String> classes;
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
    /* Callback | ValueCallback<T> */ onCommit,
  })  : labelField = labelField ?? TextField(text: label),
        classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);
    this.height = height;
    this.labelField.classes.add('label');
    if (onCommit != null) this.onCommit.on(onCommit);
  }

  ProxyValue<T> get valueProperty => labelled.valueProperty;
  T get value => labelled.value;
  set value(T value) => valueProperty.value = value;
  void setCastValue(v) => valueProperty.value = value;
  StreamBackedEmitter<ValueCommitEvent<T>> get onCommit => labelled.onCommit;
}

class Form extends Object
    with WidgetMixin
    implements EditView<Map<String, dynamic>>, Widget {
  @override
  String key;
  final RxSet<String> classes;
  final RxList<View> children;
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
    /* Callback | ValueCallback<Map<String, dynamic>> */ onCommit,
  })  : children = RxList<View>.union(children, child),
        hLabelMinWidth = hLabelMinWidth ?? FixedDistance(100),
        classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);

    valueProperty.values.listen(_normalSetter);
    valueProperty.getterProxy = _normalGetter;

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
    if (onCommit != null) this.onCommit.on(onCommit);
    // TODO emit commits
  }

  final valueProperty = ProxyValue<Map<String, dynamic>>();
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

  final onCommit =
      StreamBackedEmitter<ValueCommitEvent<Map<String, dynamic>>>();
}

class MultilineEdit extends Object
    with WidgetMixin
    implements EditWidget<String> {
  String key;
  final RxSet<String> classes;
  String placeholder;
  final onCommit = StreamBackedEmitter<ValueCommitEvent<String>>();
  final bool shouldEscape;
  MultilineEdit({
    this.placeholder,
    this.key,
    /* String | Stream<String> | Reactive<String> */ value,
    /* Distance | Stream<Distance> | Reactive<Distance> */ width,
    /* Distance | Stream<Distance> | Reactive<Distance> */ minWidth,
    /* Distance | Stream<Distance> | Reactive<Distance> */ maxWidth,

    /* bool | Stream<bool> | Reactive<bool> */ bold,

    /* String | Stream<String> | Reactive<String> */ fontFamily,
    /* String | Stream<String> | Reactive<Stream> */ color,
    /* String | Stream<String> | Reactive<Stream> */ backgroundColor,
    this.shouldEscape: true,
    String class_,
    Iterable<String> classes,
    /* Callback | ValueCallback<String> */ onCommit,
  }) : classes = classes is RxSet<String>
            ? classes
            : RxSet<String>.union(classes, class_) {
    if (classes is RxSet) this.classes.addNonNull(class_);
    valueProperty.bindOrSet(value);
    widthProperty.bindOrSet(width);
    minWidthProperty.bindOrSet(minWidth);
    maxWidthProperty.bindOrSet(maxWidth);
    boldProperty.bindOrSet(bold);
    fontFamilyProperty.bindOrSet(fontFamily);
    colorProperty.bindOrSet(color);
    backgroundColorProperty.bindOrSet(backgroundColor);
    if (onCommit != null) this.onCommit.on(onCommit);
  }

  final valueProperty = ProxyValue<String>();
  String get value => valueProperty.value;
  set value(String value) => valueProperty.value = value;
  void setCastValue(v) => valueProperty.value = value;
}
