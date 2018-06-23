import 'dart:html';
import 'package:nuts/nuts.dart';
import 'package:nuts/html_renderer.dart';

class Counter implements Component {
  @override
  String key;

  int count = 0;

  Counter() {
    view = _makeView();
  }

  @override
  View view;

  View _makeView() {
    Box ret;
    ret = Box(children: [
      TextField(text: 'Count: $count', key: 'info'),
      HBox(children: [
        Button(
            text: 'Increment',
            onClick: () {
              ret.getByKey<TextField>('info').text = 'Count: ${++count}';
            }),
        Button(
            text: 'Decrement',
            onClick: () {
              ret.getByKey<TextField>('info').text = 'Count: ${--count}';
            }),
      ]),
    ]);
    return ret;
  }
}

void main() {
  querySelector('#output').append(defaultRenderers.render(Counter()));
}
