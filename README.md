# nuts

Nuts and bolts for building cross-platform UI (HTML, Flutter, CLI) using Dart. Also screw frameworks (React, Vue, 
Angular).

## Example

```dart
class Counter implements Component {
  @override
  String key;

  int count = 0;

  @override
  View makeView() {
    Box ret;
    ret = Box(children: [
      TextField('Count: $count', key: 'info'),
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
```