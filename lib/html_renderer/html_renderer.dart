import 'dart:async';
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
  ..register<MultilineEdit>(multilineEditRenderer)
  ..register<TextEdit>(textEditRenderer)
  ..register<LabeledEdit>(labeledEditRenderer)
  ..register<IntEdit>(intEditRenderer)
  ..register<Form>(formRenderer)
  ..register<VariableView>(variableViewRenderer)
  ..register<Absolute>(absoluteRenderer)
  ..register<Relative>(relativeRenderer)
  ..register<Tin>(tinRenderer);

void handleWidget(final Element el, final View view) {
  if (view is Widget) {
    el.classes.addAll(view.classes);
    var classesSub = view.classes.onChange.listen((e) {
      if (e.op == SetChangeOp.add) {
        el.classes.add(e.element);
      } else {
        el.classes.remove(e.element);
      }
    });

    var leftSub = view.leftProperty.values.listen((dynamic left) {
      if (left is Distance)
        el.style.left = left.toString();
      else if (left is num) el.style.left = left.toString() + 'px';
    });
    // TODO view.leftProperty.getterProxy = () => el.offsetLeft;

    var topSub = view.topProperty.values.listen((dynamic top) {
      if (top is Distance)
        el.style.top = top.toString();
      else if (top is num) el.style.top = top.toString() + 'px';
    });
    // TODO view.topProperty.getterProxy = () => FixedDistance(el.offsetTop);

    var rightSub = view.rightProperty.values.listen((dynamic right) {
      if (right is Distance)
        el.style.right = right.toString();
      else if (right is num) el.style.right = right.toString() + 'px';
    });
    // TODO view.rightProperty.getterProxy = () => FixedDistance(el.offsetRight);

    var bottomSub = view.bottomProperty.values.listen((dynamic bottom) {
      if (bottom is Distance)
        el.style.bottom = bottom.toString();
      else if (bottom is num) el.style.bottom = bottom.toString() + 'px';
    });
    // TODO view.bottomProperty.getterProxy = () => FixedDistance(el.offsetBottom);

    var widthSub = view.widthProperty.values.listen((dynamic width) {
      if (width is FlexSize) {
        el.style.flex = width.toString();
      } else if (width is Distance) {
        el.style.width = width.toString();
      } else if (width is num) {
        el.style.width = width.toString() + 'px';
      }
    });
    view.widthProperty.getterProxy = () => FixedDistance(el.offsetWidth);

    var minWidthSub = view.minWidthProperty.values.listen((dynamic width) {
      if (width is Distance)
        el.style.minWidth = width.toString();
      else if (width is num) el.style.minWidth = width.toString() + 'px';
    });

    var maxWidthSub = view.maxWidthProperty.values.listen((Distance width) {
      if (width != null) el.style.maxWidth = width.toString();
    });

    var heightSub = view.heightProperty.values.listen((dynamic height) {
      if (height is FlexSize) {
        el.style.flex = height.toString();
      } else if (height is Distance) {
        el.style.height = height.toString();
      } else if (height is num) {
        el.style.height = height.toString() + 'px';
      }
    });
    view.heightProperty.getterProxy = () => FixedDistance(el.offsetHeight);

    var minHeightSub = view.minHeightProperty.values.listen((dynamic height) {
      if (height is Distance) el.style.minHeight = height.toString();
      else if(height is num) el.style.minHeight = height.toString() + 'px';
    });

    var maxHeightSub = view.maxHeightProperty.values.listen((Distance height) {
      if (height != null) el.style.maxHeight = height.toString();
    });

    var bgColorSub = view.backgroundColorProperty.values.listen((String value) {
      el.style.backgroundColor = value;
    });
    view.backgroundColorProperty.getterProxy = () => el.style.backgroundColor;

    var bgImageSub = view.backgroundImageProperty.values.listen((String value) {
      el.style.backgroundImage = value;
    });
    view.backgroundImageProperty.getterProxy = () => el.style.backgroundImage;

    var colorSub = view.colorProperty.values.listen((String value) {
      el.style.color = value;
    });
    view.colorProperty.getterProxy = () => el.style.color;

    var paddingLeftSub = view.paddingLeftProperty.values.listen((Distance d) {
      if (d != null) el.style.paddingLeft = d.toString();
    });
    // TODO padding Left getterProxy

    var paddingTopSub = view.paddingTopProperty.values.listen((Distance d) {
      if (d != null) el.style.paddingTop = d.toString();
    });
    // TODO padding Top getterProxy

    var paddingRightSub = view.paddingRightProperty.values.listen((Distance d) {
      if (d != null) el.style.paddingRight = d.toString();
    });
    // TODO padding Right getterProxy

    var paddingBottomSub =
        view.paddingBottomProperty.values.listen((Distance d) {
      if (d != null) el.style.paddingBottom = d.toString();
    });
    // TODO padding Bottom getterProxy

    var marginLeftSub = view.marginLeftProperty.values.listen((Distance d) {
      if (d != null) el.style.marginLeft = d.toString();
    });
    // TODO margin Left getterProxy

    var marginTopSub = view.marginTopProperty.values.listen((Distance d) {
      if (d != null) el.style.marginTop = d.toString();
    });
    // TODO margin Top getterProxy

    var marginRightSub = view.marginRightProperty.values.listen((Distance d) {
      if (d != null) el.style.marginRight = d.toString();
    });
    // TODO margin Right getterProxy

    var marginBottomSub = view.marginBottomProperty.values.listen((Distance d) {
      if (d != null) el.style.marginBottom = d.toString();
    });
    // TODO margin Bottom getterProxy

    var boldSub = view.boldProperty.values.listen((bool v) {
      if (v != null) el.style.fontWeight = v ? 'bold' : 'normal';
    });
    // TODO bold property

    var fontFamilySub = view.fontFamilyProperty.values.listen((String v) {
      if (v != null) el.style.fontFamily = v;
    });
    // TODO fontFamily property

    var fontSizeSub = view.fontSizeProperty.values.listen((Distance v) {
      if (v != null) el.style.fontSize = v.toString();
    });
    // TODO fontFamily property

    view.onClick.emitStream(el.onClick.map((e) => ClickEvent(view, e)));
    view.onMouseDown.emitStream(el.onMouseDown.map((e) => ClickEvent(view, e)));
    view.onMouseMove.emitStream(el.onMouseMove.map((e) => ClickEvent(view, e)));
    view.onMouseUp.emitStream(el.onMouseUp.map((e) => ClickEvent(view, e)));

    if (view is RemoveProcessor) {
      (view as RemoveProcessor).onRemoved.listen((_) {
        leftSub.cancel();
        topSub.cancel();
        rightSub.cancel();
        bottomSub.cancel();

        widthSub.cancel();
        heightSub.cancel();

        maxWidthSub.cancel();
        minWidthSub.cancel();

        // TODO
        classesSub.cancel();
        leftSub.cancel();
      });
    }
  }
}

Element variableViewRenderer(final field, Renderer<Element> renderers) {
  if (field is VariableView) {
    dynamic oldData = field.initial;
    View oldV = field.makeView(oldData);
    Element el = renderers.render(oldV);
    Future f;
    bool removed = false;
    StreamSubscription s = field.rebuildOn.listen((data) async {
      if (oldData == data) return;
      oldData = data;
      final c = Completer();
      if (f != null) {
        Future oldF = f;
        f = oldF.then((_) => c.future);
        await oldF;
      } else {
        f = c.future;
      }
      View newV = field.makeView(data);
      Timer.periodic(Duration(microseconds: 50), (t) {
        if (removed) {
          t.cancel();
          emitRemoved(newV);
          return;
        }
        if (!document.body.contains(el)) return;
        t.cancel();
        Element newEl = renderers.render(newV);
        el.replaceWith(newEl);
        el = newEl;
        emitRemoved(oldV);
        oldV = newV;
        c.complete();
      });
    });
    field.onRemoved.listen(() async {
      removed = true;
      s.cancel();
      emitRemoved(oldV);
      if (f != null) await f;
    });
    return el;
  }
  throw new Exception(
      'variableViewRenderer cannot render ${field.runtimeType}');
}

Element multilineEditRenderer(final field, Renderer<Element> renderers) {
  if (field is MultilineEdit) {
    var ret = new TextAreaElement()..classes.add('multiline');
    if (field.placeholder != null)
      ret.placeholder = field.placeholder; // TODO rx
    field.valueProperty.listen((v) => ret.value = v ?? '');
    field.valueProperty.getterProxy = () => ret.value;
    ret.onBlur.listen((_) {
      print('here');
      field.onCommit.emitOne(ValueCommitEvent<String>(field, ret.value));
    });
    ret.onKeyPress.listen((KeyboardEvent e) {
      if (e.shiftKey && e.keyCode == KeyCode.ENTER) {
        field.onCommit.emitOne(ValueCommitEvent<String>(field, ret.value));
        e.preventDefault();
      }
    });
    if (field.shouldEscape) {
      String valueWhenFocus;
      ret.onFocus.listen((_) {
        valueWhenFocus = field.value;
      });
      ret.onKeyDown.listen((KeyboardEvent e) {
        if (e.keyCode == KeyCode.ESC) {
          ret.value = valueWhenFocus ?? '';
          ret.blur();
        }
      });
    }
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception('textEditRenderer cannot render ${field.runtimeType}');
}

Element textEditRenderer(final field, Renderer<Element> renderers) {
  if (field is TextEdit) {
    var ret = new TextInputElement()..classes.add('textinput');
    if (field.placeholder != null)
      ret.placeholder = field.placeholder; // TODO rx
    field.valueProperty.listen((v) => ret.value = v ?? '');
    field.valueProperty.getterProxy = () => ret.value;
    ret.onBlur.listen((_) {
      field.onCommit.emitOne(ValueCommitEvent<String>(field, ret.value));
    });
    ret.onKeyPress.listen((KeyboardEvent e) {
      if (e.keyCode == KeyCode.ENTER) {
        field.onCommit.emitOne(ValueCommitEvent<String>(field, ret.value));
      }
    });
    if (field.shouldEscape) {
      String valueWhenFocus;
      ret.onFocus.listen((_) {
        valueWhenFocus = field.value;
      });
      ret.onKeyDown.listen((KeyboardEvent e) {
        if (e.keyCode == KeyCode.ESC) {
          ret.value = valueWhenFocus ?? '';
          ret.blur();
        }
      });
    }
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception('textEditRenderer cannot render ${field.runtimeType}');
}

Element intEditRenderer(final field, Renderer<Element> renderers) {
  if (field is IntEdit) {
    var ret = new TextInputElement()..classes.add('textinput');
    if (field.placeholder != null)
      ret.placeholder = field.placeholder; // TODO rx
    field.valueProperty.listen((v) => ret.value = v?.toString() ?? '');
    field.valueProperty.getterProxy = () => int.tryParse(ret.value) ?? null;
    ret.onBlur.listen((_) {
      field.onCommit.emitOne(ValueCommitEvent<int>(field, field.value));
    });
    ret.onKeyPress.listen((KeyboardEvent e) {
      if (e.keyCode == KeyCode.ENTER) {
        field.onCommit.emitOne(ValueCommitEvent<int>(field, field.value));
      }
    });
    if (field.shouldEscape) {
      int valueWhenFocus;
      ret.onFocus.listen((_) {
        valueWhenFocus = field.value;
      });
      ret.onKeyDown.listen((KeyboardEvent e) {
        if (e.keyCode == KeyCode.ESC) {
          ret.value = valueWhenFocus?.toString() ?? '';
          ret.blur();
        }
      });
    }
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception('intEditRenderer cannot render ${field.runtimeType}');
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
  throw new Exception('labeledEditRenderer cannot render ${field.runtimeType}');
}

Element textFieldRenderer(final field, _) {
  if (field is TextField) {
    var ret = new DivElement()
      ..classes.add('textfield')
      ..text = field.text;
    field.textProperty.values.listen((v) {
      ret.text = v ?? '';
    });
    field.textProperty.getterProxy = () => ret.text;
    handleWidget(ret, field);
    return ret;
  }
  throw new Exception('textFieldRenderer cannot render ${field.runtimeType}');
}

Element intFieldRenderer(final field, _) {
  if (field is IntField) {
    var ret = new DivElement()
      ..classes.add('textfield')
      ..text = field.text?.toString() ?? '';
    field.textProperty.values.listen((v) => ret.text = v?.toString() ?? '');
    field.textProperty.getterProxy = () => int.tryParse(ret.text);
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
    for (View child in field.children)
      ret.children.add(renderers.render(child));
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
    for (View child in field.children)
      ret.children.add(renderers.render(child));
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

Element absoluteRenderer(final field, Renderer<Element> renderers) {
  if (field is Absolute) {
    var ret = new DivElement()..classes.add('absolute-layout');
    for (View child in field.children)
      ret.children.add(renderers.render(child));
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
  throw new Exception('absoluteRenderer cannot render ${field.runtimeType}');
}

Element relativeRenderer(final field, Renderer<Element> renderers) {
  if (field is Relative) {
    var ret = new DivElement()..classes.add('relative-layout');
    for (View child in field.children)
      ret.children.add(renderers.render(child));
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
  throw new Exception('relativeRenderer cannot render ${field.runtimeType}');
}

Element tinRenderer(final field, Renderer<Element> renderers) {
  if (field is Tin) {
    var ret = new DivElement()..classes.add('tin-layout');
    for (View child in field.children)
      ret.children.add(renderers.render(child));
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
  throw new Exception('tinRenderer cannot render ${field.runtimeType}');
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
