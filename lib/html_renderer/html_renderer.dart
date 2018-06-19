import 'dart:html';
import 'package:nuts/nuts.dart';

final HtmlRenderer defaultRenderers = new HtmlRenderer()
  ..register<Box>(boxRenderer)
  ..register<HBox>(hBoxRenderer)
  ..register<TextField>(textFieldRenderer)
  ..register<LabeledTextField>(labeledTextFieldRenderer)
  ..register<VLabeledTextField>(vLabeledTextFieldRenderer)
  ..register<Button>(buttonRenderer)
  ..register<IntField>(intFieldRenderer)
  ..register<Table>(tableRenderer)
  ..register<LabeledIntField>(labeledIntFieldRenderer)
  ..register<VLabeledIntField>(vLabeledIntFieldRenderer)
  ..register<TextEdit>(textEditRenderer)
  ..register<LabeledTextEdit>(labeledTextEditRenderer)
  ..register<IntEdit>(intEditRenderer)
  ..register<LabeledIntEdit>(labeledIntEditRenderer)
  ..register<Form>(formRenderer)
  ..register<VariableView>(variableViewRenderer);

void _handleWidth(final Element el, final View view) {
  if (view is ViewWithWidth) {
    if (view.width != null) el.style.width = view.width.toString();
    if (view.minWidth != null) el.style.minWidth = view.minWidth.toString();
    if (view.maxWidth != null) el.style.maxWidth = view.maxWidth.toString();
  }
}

void _handleClasses(final Element el, final View view) {
  if (view is ViewWithClasses) {
    view.classes.onChange.listen((e) {
      if (e.op == SetChangeOp.add) {
        el.classes.add(e.element);
      } else {
        el.classes.remove(e.element);
      }
    });
  }
}

Element variableViewRenderer(final field, Renderer<Element> renderers) {
  if (field is VariableView) {
    Element el = renderers.render(field.makeView(field.initial));
    field.rebuildOn.listen((v) {
      Element newEl = renderers.render(field.makeView(v));
      el.replaceWith(newEl);
      el = newEl;
    });
    return el;
  }
  throw new Exception();
}

Element textEditRenderer(final field, Renderer<Element> renderers) {
  if (field is TextEdit) {
    var ret = new TextInputElement()
      ..classes.add('textinput')
      ..value = field.initial ?? '';
    if (field.placeholder != null) ret.placeholder = field.placeholder;
    if (field.bold) ret.style.fontWeight = 'bold';
    field.readValue = () => ret.value;
    field.setValue = (v) {
      ret.value = v ?? '';
    };
    _handleWidth(ret, field);
    _handleClasses(ret, field);
    return ret;
  }
  throw new Exception();
}

Element labeledTextEditRenderer(final field, Renderer<Element> renderers) {
  if (field is LabeledTextEdit) {
    var ret = renderers.render(HBox(children: [
      field.labelField,
      field.editField,
    ]))
      ..classes.addAll(['labeled', 'labeled-textinput']);
    _handleWidth(ret, field);
    _handleClasses(ret, field);
    return ret;
  }
  throw new Exception();
}

Element intEditRenderer(final field, Renderer<Element> renderers) {
  if (field is IntEdit) {
    var ret = new TextInputElement()
      ..classes.add('textinput')
      ..value = field.initial?.toString() ?? '';
    if (field.placeholder != null) ret.placeholder = field.placeholder;
    if (field.bold) ret.style.fontWeight = 'bold';
    field.readValue = () => int.tryParse(ret.value);
    void setValue(int v) => ret.value = v?.toString() ?? '';
    field.setValue = setValue;
    _handleWidth(ret, field);
    _handleClasses(ret, field);
    return ret;
  }
  throw new Exception();
}

Element labeledIntEditRenderer(final field, Renderer<Element> renderers) {
  if (field is LabeledIntEdit) {
    var ret = renderers.render(HBox(children: [
      field.labelField,
      field.editField,
    ]))
      ..classes.addAll(['labeled', 'labeled-textinput']);
    _handleWidth(ret, field);
    _handleClasses(ret, field);
    return ret;
  }
  throw new Exception();
}

Element textFieldRenderer(final field, _) {
  if (field is TextField) {
    var ret = new DivElement()
      ..classes.add('textfield')
      ..text = field.text;
    ret.classes.addAll(field.classes);
    if (field.bold) ret.style.fontWeight = 'bold';
    if (field.fontFamily != null) ret.style.fontFamily = field.fontFamily;
    if (field.color != null) ret.style.color = field.color;
    if (field.onClick != null) ret.onClick.listen((_) => field.onClick());
    field.textProperty.getter = () => ret.text;
    field.textProperty.values.listen((v) => ret.text = v ?? '');
    _handleWidth(ret, field);
    _handleClasses(ret, field);
    return ret;
  }
  throw new Exception();
}

Element intFieldRenderer(final field, _) {
  if (field is IntField) {
    var ret = new DivElement()
      ..classes.addAll(['textfield', 'textfield-int'])
      ..text = field.text.toString();
    _handleWidth(ret, field);
    _handleClasses(ret, field);
    return ret;
  }
  throw new Exception();
}

Element labeledTextFieldRenderer(final field, Renderer<Element> renderers) {
  if (field is LabeledTextField) {
    var ret = renderers.render(HBox(children: [
      field.labelField,
      field.textField,
    ]))
      ..classes.addAll(['labeled', 'labeled-textfield']);
    _handleWidth(ret, field);
    _handleClasses(ret, field);
    return ret;
  }
  throw new Exception();
}

Element vLabeledTextFieldRenderer(final field, Renderer<Element> renderers) {
  if (field is LabeledTextField) {
    var ret = renderers.render(Box(children: [
      field.labelField,
      field.textField,
    ]))
      ..classes.addAll(['vlabeled', 'vlabeled-textfield']);
    _handleWidth(ret, field);
    _handleClasses(ret, field);
    return ret;
  }
  throw new Exception();
}

Element labeledIntFieldRenderer(final field, Renderer<Element> renderers) {
  if (field is LabeledIntField) {
    var ret = renderers.render(HBox(children: [
      field.labelField,
      field.intField,
    ]))
      ..classes.addAll(['labeled', 'labeled-textfield']);
    _handleWidth(ret, field);
    _handleClasses(ret, field);
    return ret;
  }
  throw new Exception();
}

Element vLabeledIntFieldRenderer(final field, Renderer<Element> renderers) {
  if (field is LabeledTextField) {
    var ret = renderers.render(Box(children: [
      field.labelField,
      field.textField,
    ]))
      ..classes.addAll(['vlabeled', 'vlabeled-textfield']);
    _handleWidth(ret, field);
    _handleClasses(ret, field);
    return ret;
  }
  throw new Exception();
}

String vAlignToCssJustifyContent(VAlign align) {
  switch (align) {
    case VAlign.top:
      return 'start';
    case VAlign.middle:
      return 'center';
    case VAlign.bottom:
      return 'end';
    default:
      return 'inherit';
  }
}

String hAlignToCssAlignItems(HAlign align) {
  switch (align) {
    case HAlign.left:
      return 'left';
    case HAlign.center:
      return 'center';
    case HAlign.right:
      return 'right';
    case HAlign.right:
      return 'right';
    default:
      return 'inherit';
  }
}

Element boxRenderer(final field, Renderer<Element> renderers) {
  if (field is Box) {
    var ret = new DivElement()..classes.add('box');
    ret.classes.addAll(field.classes);
    for (View child in field.children) ret.append(renderers.render(child));

    field.widthProperty.getter = () => FixedSize(ret.offsetWidth);
    field.widthProperty.values.listen((Size width) {
      ret.style.width = width.toString();
    });
    field.heightProperty.getter = () => FixedSize(ret.offsetHeight);
    field.heightProperty.values.listen((Size height) {
      if (height is FlexSize) {
        ret.style.flex = height.toString();
      } else {
        ret.style.height = height.toString();
      }
    });

    field.backgroundColorProperty.getter = () => ret.style.backgroundColor;
    field.backgroundColorProperty.values.listen((String value) {
      ret.style.backgroundColor = value;
    });

    if (field.vAlign != null)
      ret.style.justifyContent = vAlignToCssJustifyContent(field.vAlign);
    if (field.hAlign != null)
      ret.style.alignItems = hAlignToCssAlignItems(field.hAlign);
    if (field.pad != null) _padElement(ret, field.pad);
    if (field.margin != null) _marginElement(ret, field.margin);
    field.children.onChange.listen((e) {
      if (e.op == ListChangeOp.add)
        ret.children.insert(e.pos, renderers.render(e.element));
      else if (e.op == ListChangeOp.set)
        ret.children[e.pos] = renderers.render(e.element);
      else if (e.op == ListChangeOp.remove)
        ret.children.removeAt(e.pos);
      else
        ret.children.clear();
    });
    _handleClasses(ret, field);
    return ret;
  }
  throw new Exception();
}

String vAlignToCssAlignItems(VAlign align) {
  switch (align) {
    case VAlign.top:
      return 'start';
    case VAlign.middle:
      return 'center';
    case VAlign.bottom:
      return 'end';
    default:
      return 'inherit';
  }
}

String hAlignToCssJustifyContent(HAlign align) {
  switch (align) {
    case HAlign.left:
      return 'left';
    case HAlign.center:
      return 'center';
    case HAlign.right:
      return 'right';
    case HAlign.right:
      return 'right';
    default:
      return 'inherit';
  }
}

void _padElement(Element e, EdgeInset padding) {
  if (padding.top != null) e.style.paddingTop = padding.top.toString();
  if (padding.right != null) e.style.paddingRight = padding.right.toString();
  if (padding.bottom != null) e.style.paddingBottom = padding.bottom.toString();
  if (padding.left != null) e.style.paddingLeft = padding.left.toString();
}

void _marginElement(Element e, EdgeInset margin) {
  if (margin.top != null) e.style.marginTop = margin.top.toString();
  if (margin.right != null) e.style.marginRight = margin.right.toString();
  if (margin.bottom != null) e.style.marginLeft = margin.bottom.toString();
  if (margin.left != null) e.style.marginBottom = margin.left.toString();
}

Element hBoxRenderer(final field, Renderer<Element> renderers) {
  if (field is HBox) {
    var ret = new DivElement()..classes.add('hbox');
    ret.classes.addAll(field.classes);
    for (View child in field.children) ret.append(renderers.render(child));

    field.widthProperty.getter = () => FixedSize(ret.offsetWidth);
    field.widthProperty.values.listen((Size width) {
      if (width is FlexSize) {
        ret.style.flex = width.toString();
      } else {
        ret.style.width = width.toString();
      }
    });
    field.heightProperty.getter = () => FixedSize(ret.offsetHeight);
    field.heightProperty.values.listen((Size height) {
      ret.style.height = height.toString();
    });

    field.backgroundColorProperty.getter = () => ret.style.backgroundColor;
    field.backgroundColorProperty.values.listen((String value) {
      ret.style.backgroundColor = value;
    });

    if (field.vAlign != null)
      ret.style.alignItems = vAlignToCssAlignItems(field.vAlign);
    if (field.hAlign != null)
      ret.style.justifyContent = hAlignToCssJustifyContent(field.hAlign);
    if (field.pad != null) _padElement(ret, field.pad);
    if (field.margin != null) _marginElement(ret, field.margin);
    field.children.onChange.listen((e) {
      if (e.op == ListChangeOp.add)
        ret.children.insert(e.pos, renderers.render(e.element));
      else if (e.op == ListChangeOp.set)
        ret.children[e.pos] = renderers.render(e.element);
      else if (e.op == ListChangeOp.remove)
        ret.children.removeAt(e.pos);
      else
        ret.children.clear();
    });
    _handleClasses(ret, field);
    return ret;
  }
  throw new Exception();
}

Element buttonRenderer(final field, Renderer<Element> renderers) {
  if (field is Button) {
    var ret = new SpanElement()
      ..classes.add('button')
      ..style.color = field.color;
    if (field.icon != null) ret.append(new SpanElement()); // TODO set icon
    if (field.text != null) ret.append(new SpanElement()..text = field.text);
    if (field.fontSize != null) ret.style.fontSize = '${field.fontSize}px';
    if (field.tip != null) ret.title = field.tip;
    if (field.onClick != null) ret.onClick.listen((_) => field.onClick());
    ret.classes.addAll(field.classes);
    _handleWidth(ret, field);
    _handleClasses(ret, field);
    return ret;
  }
  throw new Exception();
}

Element tableRenderer(final field, Renderer<Element> renderers) {
  if (field is Table) {
    var header = new Element.tag('thead')
      ..classes.add('jaguar-admin-table-head');
    for (int i = 0; i < field.numCols; i++) {
      ColumnSpec spec = field.spec[i];
      var th = new Element.th()
        ..classes.add('jaguar-admin-table-head-item')
        ..append(renderers.render(TextField(text: spec.label)));
      if (spec.width != null) th.style.width = spec.width.toString();
      header.append(th);
    }
    var body = new Element.tag('tbody')..classes.add('jaguar-admin-table-body');
    for (int r = 0; r < field.numRows; r++) {
      TableRow row = field.rows[r];
      // TODO set height
      var el = new TableRowElement()..classes.add('jaguar-admin-table-row');
      for (int c = 0; c < field.numCols; c++) {
        ColumnSpec spec = field.spec[c];
        View v = row.cells[spec.name];
        if (v != null) {
          el.append(new TableCellElement()..append(renderers.render(v)));
        } else {
          el.append(new TableCellElement()
            ..append(renderers.render(TextField(text: ""))));
        }
      }
      body.append(el);
    }
    // TODO classes
    return new DivElement()
      ..classes.add('jaguar-admin-table-frame')
      ..append(new TableElement()
        ..classes.add('jaguar-admin-table')
        ..append(header)
        ..append(body)
        ..attributes.addAll({
          "cellspacing": "0",
          "cellpadding": "0",
        }));
  }
  throw new Exception();
}

Element formRenderer(final field, Renderer<Element> renderers) {
  if (field is Form) {
    var ret = renderers.render(Box(
      children: field.children,
    ))
      ..classes.add('form');
    _handleWidth(ret, field);
    return ret;
  }
  throw new Exception();
}

class HtmlRenderer extends Renderer<Element> {
  final _renderers = <Type, ViewRenderer<Element, View>>{};

  @override
  Iterable<ViewRenderer<Element, View>> get allRenderers => _renderers.values;

  void register<T extends View>(ViewRenderer<Element, View> renderer) {
    _renderers[T] = renderer;
  }

  @override
  ViewRenderer<Element, T> get<T extends View>() => _renderers[T];

  ViewRenderer<Element, dynamic> getFor(View view) =>
      _renderers[view.runtimeType];

  void merge(Renderer<Element> other) {
    if (other is HtmlRenderer)
      _renderers.addAll(other._renderers);
    else
      throw new Exception("Cannot merge!");
  }

  HtmlRenderer clone() {
    var ret = new HtmlRenderer();
    ret.merge(this);
    return ret;
  }
}
