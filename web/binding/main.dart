import 'dart:html';
import 'package:nuts/nuts.dart';
import 'package:nuts/html_renderer.dart';

class Counter implements Component {
  @override
  String key;

  final count = RxValue<int>(initial: 0);

  Counter() {
    view = _makeView();
  }

  @override
  View view;

  View _makeView() {
    return Box(children: [
      HBox(children: [
        TextField(text: 'Count: '),
        IntField(text: count, class_: 'count')
      ]),
      HBox(children: [
        Button(text: 'Increment', onClick: () => count.value++),
        Button(text: 'Decrement', onClick: () => count.value--),
      ]),
    ]);
  }
}

void main() {
  querySelector('#output').append(defaultRenderers.render(Counter()));
}
