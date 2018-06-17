import 'dart:async';
import 'package:nuts/nuts.dart';

class Box implements Container, ViewWithClasses {
  final String key;
  final IfList<View> children;
  final IfSet<String> classes; // TODO: Make it, bi-directional
  final Size width;
  final Size height;
  HAlign hAlign;
  VAlign vAlign;
  final EdgeInset pad;
  final EdgeInset margin;
  Box(
      {View child,
      Iterable<View> children,
      this.key,
      String class_,
      Iterable<String> classes,
      this.width,
      this.height,
      this.hAlign,
      this.vAlign,
      this.pad,
      this.margin})
      : children = IfList<View>.union(children, child),
        classes = IfSet<String>.union(classes, class_);
  void addChild(View v) => children.add(v);
  void addChildren(Iterable<View> v) => children.addAll(v);
  T getByKey<T extends View>(String key) =>
      children.firstWhere((v) => v.key == key, orElse: () => null);
  T deepGetByKey<T extends View>(Iterable<String> keys) {
    if (key.length == 0) return null;
    View ret =
        children.firstWhere((v) => v.key == keys.first, orElse: () => null);
    if (ret == null) return null;
    if (keys.length == 1) return ret;
    if (ret is Container) {
      if (keys.length == 2) return ret.getByKey<T>(keys.last);
      return ret.deepGetByKey<T>(keys.skip(1));
    }
    return null;
  }

  void bindClass(String class_, Stream<bool> changes) {
    changes.listen((bool v) {
      if (v)
        classes.add(class_);
      else
        classes.remove(class_);
    });
  }
}

class HBox implements Container, ViewWithClasses {
  String key;
  final IfList<View> children;
  final IfSet<String> classes;
  final Size width;
  final Size height;
  HAlign hAlign;
  VAlign vAlign;
  final EdgeInset pad;
  final EdgeInset margin;
  HBox(
      {View child,
      Iterable<View> children,
      this.key,
      String class_,
      Iterable<String> classes,
      this.width,
      this.height,
      this.hAlign,
      this.vAlign: VAlign.middle,
      this.pad,
      this.margin})
      : children = IfList<View>.union(children, child),
        classes = IfSet<String>.union(classes, class_);
  void addChild(View v) => children.add(v);
  void addChildren(Iterable<View> v) => children.addAll(v);
  T getByKey<T extends View>(String key) =>
      children.firstWhere((v) => v.key == key, orElse: () => null);
  T deepGetByKey<T extends View>(Iterable<String> keys) {
    if (key.length == 0) return null;
    View ret =
        children.firstWhere((v) => v.key == keys.first, orElse: () => null);
    if (ret == null) return null;
    if (keys.length == 1) return ret;
    if (ret is Container) {
      if (keys.length == 2) return ret.getByKey<T>(keys.last);
      return ret.deepGetByKey<T>(keys.skip(1));
    }
    return null;
  }

  void bindClass(String class_, Stream<bool> changes) {
    changes.listen((bool v) {
      if (v)
        classes.add(class_);
      else
        classes.remove(class_);
    });
  }
}
