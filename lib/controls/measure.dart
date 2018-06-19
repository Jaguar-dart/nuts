import 'view.dart';

abstract class Size {
  num get size;
}

class FixedSize implements Size {
  final num size;
  const FixedSize(this.size);
  String toString() => '${size.toString()}px';
  FixedSize operator+(/* FixedSize | num */ other) {
    if(other is FixedSize) return FixedSize(size + other.size);
    if(other is num) return FixedSize(size + other);
    throw new Exception('Unknown operand ${other?.runtimeType}');
  }
  FixedSize operator-(/* FixedSize | num */ other) {
    if(other is FixedSize) return FixedSize(size - other.size);
    if(other is num) return FixedSize(size - other);
    throw new Exception('Unknown operand ${other?.runtimeType}');
  }
}

class FlexSize implements Size {
  final double size;
  FlexSize(this.size);
  String toString() => '${size.toString()}';
  FlexSize operator+(/* FlexSize | num */ other) {
    if(other is FlexSize) return FlexSize(size + other.size);
    if(other is num) return FlexSize(size + other);
    throw new Exception('Unknown operand ${other?.runtimeType}');
  }
  FlexSize operator-(/* FlexSize | num */ other) {
    if(other is FlexSize) return FlexSize(size - other.size);
    if(other is num) return FlexSize(size - other);
    throw new Exception('Unknown operand ${other?.runtimeType}');
  }
}

class PercentageSize implements Size {
  final num size;
  PercentageSize(this.size);
  String toString() => '${size.toString()}%';
  PercentageSize operator+(/* PercentageSize | num */ other) {
    if(other is PercentageSize) return PercentageSize(size + other.size);
    if(other is num) return PercentageSize(size + other);
    throw new Exception('Unknown operand ${other?.runtimeType}');
  }
  PercentageSize operator-(/* PercentageSize | num */ other) {
    if(other is PercentageSize) return PercentageSize(size - other.size);
    if(other is num) return PercentageSize(size - other);
    throw new Exception('Unknown operand ${other?.runtimeType}');
  }
}

abstract class ViewWithWidth implements View {
  Size width;
  Size minWidth;
  Size maxWidth;
}

class EdgeInset {
  Size top;
  Size right;
  Size bottom;
  Size left;
  EdgeInset({Size top, Size right, Size bottom, Size left, Size rest})
      : top = top ?? rest,
        right = right ?? rest,
        bottom = bottom ?? rest,
        left = left ?? rest;
  EdgeInset.v(Size pad, {Size rest})
      : top = pad,
        bottom = pad,
        right = rest,
        left = rest;
  EdgeInset.h(Size pad, {Size rest})
      : right = pad,
        left = pad,
        top = rest,
        bottom = rest;
  EdgeInset.all(Size pad)
      : top = pad,
        right = pad,
        bottom = pad,
        left = pad;
}