abstract class Distance {
  num get size;
}

class FixedDistance implements Distance {
  final num size;
  const FixedDistance(this.size);
  String toString() => '${size.toString()}px';
  FixedDistance operator +(/* FixedSize | num */ other) {
    if (other is FixedDistance) return FixedDistance(size + other.size);
    if (other is num) return FixedDistance(size + other);
    throw new Exception('Unknown operand ${other?.runtimeType}');
  }

  FixedDistance operator -(/* FixedSize | num */ other) {
    if (other is FixedDistance) return FixedDistance(size - other.size);
    if (other is num) return FixedDistance(size - other);
    throw new Exception('Unknown operand ${other?.runtimeType}');
  }
}

class FlexSize implements Distance {
  final double size;
  FlexSize(this.size);
  String toString() => '${size.toString()}';
  FlexSize operator +(/* FlexSize | num */ other) {
    if (other is FlexSize) return FlexSize(size + other.size);
    if (other is num) return FlexSize(size + other);
    throw new Exception('Unknown operand ${other?.runtimeType}');
  }

  FlexSize operator -(/* FlexSize | num */ other) {
    if (other is FlexSize) return FlexSize(size - other.size);
    if (other is num) return FlexSize(size - other);
    throw new Exception('Unknown operand ${other?.runtimeType}');
  }
}

class PercentageDistance implements Distance {
  final num size;
  PercentageDistance(this.size);
  String toString() => '${size.toString()}%';
  PercentageDistance operator +(/* PercentageSize | num */ other) {
    if (other is PercentageDistance)
      return PercentageDistance(size + other.size);
    if (other is num) return PercentageDistance(size + other);
    throw new Exception('Unknown operand ${other?.runtimeType}');
  }

  PercentageDistance operator -(/* PercentageSize | num */ other) {
    if (other is PercentageDistance)
      return PercentageDistance(size - other.size);
    if (other is num) return PercentageDistance(size - other);
    throw new Exception('Unknown operand ${other?.runtimeType}');
  }
}

class EdgeInset {
  Distance top;
  Distance right;
  Distance bottom;
  Distance left;
  EdgeInset(
      {Distance top,
      Distance right,
      Distance bottom,
      Distance left,
      Distance rest})
      : top = top ?? rest,
        right = right ?? rest,
        bottom = bottom ?? rest,
        left = left ?? rest;
  EdgeInset.v(Distance pad, {Distance rest})
      : top = pad,
        bottom = pad,
        right = rest,
        left = rest;
  EdgeInset.h(Distance pad, {Distance rest})
      : right = pad,
        left = pad,
        top = rest,
        bottom = rest;
  EdgeInset.all(Distance pad)
      : top = pad,
        right = pad,
        bottom = pad,
        left = pad;
}
