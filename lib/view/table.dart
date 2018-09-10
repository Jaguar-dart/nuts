import 'view.dart';
import 'package:observable_ish/observable_ish.dart';

// TODO:
// 1) Sortable
// 2) Resizable columns

class TableRow implements View {
  String key;
  final Distance height;
  final FixedDistance minHeight;
  final FixedDistance maxHeight;
  Map<String, View> cells;
  TableRow(this.cells, {this.height, this.minHeight, this.maxHeight, this.key});
  final onRemoved = StreamBackedEmitter<void>();
}

class ColumnSpec<T> {
  final String label;
  final String name;
  final Distance width;
  final FixedDistance minWidth;
  final FixedDistance maxWidth;
  final bool isResizable;
  // TODO

  ColumnSpec(this.label,
      {String name,
      this.width,
      this.minWidth,
      this.maxWidth,
      this.isResizable: true})
      : name = name ?? label;

  bool operator ==(other) {
    if (other is ColumnSpec) return name == other.name;
    return false;
  }

  int get hashCode => name.hashCode;
}

class Table implements View {
  String key;

  List<ColumnSpec> spec;

  List<TableRow> rows;

  final bool isResponsive;
  final onRemoved = StreamBackedEmitter<void>();

  Table({this.spec, this.rows, this.isResponsive: false, this.key});

  int get numCols => spec.length;

  int get numRows => rows.length;
}
