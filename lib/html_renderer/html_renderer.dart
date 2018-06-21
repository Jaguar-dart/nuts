import 'dart:html';
import 'package:nuts/nuts.dart';

final HtmlRenderer defaultRenderers = new HtmlRenderer()
  ..register<Box>(boxRenderer)
  ..register<HBox>(hBoxRenderer)
  ..register<TextField>(textFieldRenderer)
  ..register<LabeledField>(labeledFieldRenderer)
  ..register<VLabeledField>(vLabeledFieldRenderer)
  ..register<Button>(buttonRenderer)
  ..register<IntField>(intFieldRenderer)
  ..register<Table>(tableRenderer)
  ..register<TextEdit>(textEditRenderer)
  ..register<LabeledEdit>(labeledEditRenderer)
  ..register<IntEdit>(intEditRenderer)
  ..register<Form>(formRenderer)
  ..register<VariableView>(variableViewRenderer);

void handleWidget(final Element el, final View view) {
  if (view is Widget) {
    view.classes.onChange.listen((e) {
      if (e.op == SetChangeOp.add) {
        el.classes.add(e.element);
      } else {
        el.classes.remove(e.element);
      }
    });

    view.leftProperty.values.listen((Distance left) {
      if (left != null) el.style.left = left.toString();
    });
    view.leftProperty.getter = () => FixedDistance(el.offsetLeft);

    view.topProperty.values.listen((Distance top) {
      if (top != null) el.style.top = top.toString();
    });
    view.topProperty.getter = () => FixedDistance(el.offsetTop);

    view.rightProperty.values.listen((Distance right) {
      if (right != null) el.style.right = right.toString();
    });
    // TODO view.rightProperty.getter = () => FixedDistance(el.offsetRight);

    view.bottomProperty.values.listen((Distance bottom) {
      if (bottom != null) el.style.bottom = bottom.toString();
    });
    // TODO view.bottomProperty.getter = () => FixedDistance(el.offsetBottom);

    view.widthProperty.values.listen((Distance width) {
      if (width is FlexSize) {
        el.style.flex = width.toString();
      } else if (width != null) {
        el.style.width = width.toString();
      }
    });
    view.widthProperty.getter = () => FixedDistance(el.offsetWidth);

    view.minWidthProperty.values.listen((Distance width) {
      if (width != null) el.style.minWidth = width.toString();
    });

    view.maxWidthProperty.values.listen((Distance width) {
      if (width != null) el.style.maxWidth = width.toString();
    });

    view.heightProperty.values.listen((Distance height) {
      if (height is FlexSize) {
        el.style.flex = height.toString();
      } else if (height != null) {
        el.style.height = height.toString();
      }
    });
    view.heightProperty.getter = () => FixedDistance(el.offsetHeight);

    view.minHeightProperty.values.listen((Distance height) {
      if (height != null) el.style.minHeight = height.toString();
    });

    view.maxHeightProperty.values.listen((Distance height) {
      if (height != null) el.style.maxHeight = height.toString();
    });

    view.backgroundColorProperty.values.listen((String value) {
      el.style.backgroundColor = value;
    });
    view.backgroundColorProperty.getter = () => el.style.backgroundColor;

    view.colorProperty.values.listen((String value) {
      el.style.color = value;
    });
    view.colorProperty.getter = () => el.style.color;

    view.paddingLeftProperty.values.listen((Distance d) {
      if (d != null) el.style.paddingLeft = d.toString();
    });
    // TODO padding Left getter

    view.paddingTopProperty.values.listen((Distance d) {
      if (d != null) el.style.paddingTop = d.toString();
    });
    // TODO padding Top getter

    view.paddingRightProperty.values.listen((Distance d) {
      if (d != null) el.style.paddingRight = d.toString();
    });
    // TODO padding Right getter

    view.paddingBottomProperty.values.listen((Distance d) {
      if (d != null) el.style.paddingBottom = d.toString();
    });
    // TODO padding Bottom getter

    view.marginLeftProperty.values.listen((Distance d) {
      if (d != null) el.style.marginLeft = d.toString();
    });
    // TODO margin Left getter

    view.marginTopProperty.values.listen((Distance d) {
      if (d != null) el.style.marginTop = d.toString();
    });
    // TODO margin Top getter

    view.marginRightProperty.values.listen((Distance d) {
      if (d != null) el.style.marginRight = d.toString();
    });
    // TODO margin Right getter

    view.marginBottomProperty.values.listen((Distance d) {
      if (d != null) el.style.marginBottom = d.toString();
    });
    // TODO margin Bottom getter

    view.boldProperty.values.listen((bool v) {
      if (v != null) el.style.fontWeight = v ? 'bold' : 'normal';
    });
    // TODO bold property

    view.fontFamilyProperty.values.listen((String v) {
      if (v != null) el.style.fontFamily = v;
    });
    // TODO fontFamily property
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
  throw new Exception(
      'variableViewRenderer cannot render ${field.runtimeType}');
}

Element textEditRenderer(final field, Renderer<Element> renderers) {
  if (field is TextEdit) {
    var ret = new TextInputElement()..classes.add('textinput');
    if (field.placeholder != null)
      ret.placeholder = field.placeholder; // TODO rx
    field.valueProperty.listen((v) => ret.value = v ?? '');
    field.valueProperty.getter = () => ret.value;
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception(
      'variableViewRenderer cannot render ${field.runtimeType}');
}

Element labeledEditRenderer(final field, Renderer<Element> renderers) {
  if (field is LabeledEdit) {
    var ret = renderers.render(HBox(children: [
      field.labelField,
      field.labelled,
    ]))
      ..classes.addAll(['labeled', 'labeled-textinput']);
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception(
      'variableViewRenderer cannot render ${field.runtimeType}');
}

Element intEditRenderer(final field, Renderer<Element> renderers) {
  if (field is IntEdit) {
    var ret = new TextInputElement()..classes.add('textinput');
    if (field.placeholder != null)
      ret.placeholder = field.placeholder; // TODO rx
    field.valueProperty.listen((v) => ret.value = v?.toString() ?? '');
    field.valueProperty.getter = () => int.tryParse(ret.value) ?? null;
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception(
      'variableViewRenderer cannot render ${field.runtimeType}');
}

Element textFieldRenderer(final field, _) {
  if (field is TextField) {
    var ret = new DivElement()
      ..classes.add('textfield')
      ..text = field.text;
    field.onClick
        .emitStream(ret.onClick.map((e) => ClickEvent(field, e.offset)));
    /*
    if (field.onClick != null)
      ret.onClick.listen((_) => field.onClick()); // TODO
      */
    field.textProperty.values.listen((v) => ret.text = v ?? '');
    field.textProperty.getter = () => ret.text;
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception(
      'variableViewRenderer cannot render ${field.runtimeType}');
}

Element intFieldRenderer(final field, _) {
  if (field is IntField) {
    var ret = new DivElement()
      ..classes.addAll(['textfield', 'textfield-int'])
      ..text = field.text.toString();
    // TODO text
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception('intFieldRenderer cannot render ${field.runtimeType}');
}

Element labeledFieldRenderer(final field, Renderer<Element> renderers) {
  if (field is LabeledField) {
    var ret = renderers.render(HBox(children: [
      field.labelField,
      field.labelled,
    ]))
      ..classes.addAll(['labeled', 'labeled-textfield']);
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception(
      'labeledFieldRenderer cannot render ${field.runtimeType}');
}

Element vLabeledFieldRenderer(final field, Renderer<Element> renderers) {
  if (field is LabeledField) {
    var ret = renderers.render(Box(children: [
      field.labelField,
      field.labelled,
    ]))
      ..classes.addAll(['vlabeled', 'vlabeled-textfield']);
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception(
      'vLabeledFieldRenderer cannot render ${field.runtimeType}');
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
    if (field.vAlign != null)
      ret.style.justifyContent = vAlignToCssJustifyContent(field.vAlign);
    if (field.hAlign != null)
      ret.style.alignItems = hAlignToCssAlignItems(field.hAlign);
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
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception('boxRenderer cannot render ${field.runtimeType}');
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

Element hBoxRenderer(final field, Renderer<Element> renderers) {
  if (field is HBox) {
    var ret = new DivElement()..classes.add('hbox');
    if (field.vAlign != null)
      ret.style.alignItems = vAlignToCssAlignItems(field.vAlign);
    if (field.hAlign != null)
      ret.style.justifyContent = hAlignToCssJustifyContent(field.hAlign);
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
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception('hBoxRenderer cannot render ${field.runtimeType}');
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
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception('buttonRenderer cannot render ${field.runtimeType}');
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
  throw new Exception('tableRenderer cannot render ${field.runtimeType}');
}

Element formRenderer(final field, Renderer<Element> renderers) {
  if (field is Form) {
    var ret = renderers.render(Box(
      children: field.children,
    ))
      ..classes.add('form');
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception('formRenderer cannot render ${field.runtimeType}');
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
