import 'package:nuts/controls/view.dart';

export 'package:nuts/controls/view.dart';
export 'package:nuts/collection/collection.dart';

typedef E ViewRenderer<E, T extends View>(view, Renderer<E> renderers);

abstract class Renderer<E> {
  void register<T extends View>(ViewRenderer<E, T> renderer);

  ViewRenderer<E, T> get<T extends View>();

  ViewRenderer<E, dynamic> getFor(View view);

  E render(final View view) {
    if (view == null) throw new Exception("View cannot be null!");
    if (view is Component) return render(view.makeView());
    ViewRenderer<E, View> ren = getFor(view);
    if (ren != null) return ren(view, this);
    throw new Exception("A renderer for ${view.runtimeType} not found!");
  }

  void merge(Renderer<E> other);

  Renderer<E> clone();
}