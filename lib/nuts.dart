import 'package:nuts/view/view.dart';

export 'package:nuts/view/view.dart';
export 'package:observable_ish/observable_ish.dart';

typedef E ViewRenderer<E, T extends View>(view, Renderer<E> renderers);

abstract class Renderer<E> {
  Iterable<ViewRenderer<E, View>> get allRenderers;

  void register<T extends View>(ViewRenderer<E, T> renderer);

  ViewRenderer<E, T> get<T extends View>();

  ViewRenderer<E, dynamic> getFor(View view);

  E render(final View view) {
    if (view == null) {
      throw new Exception("View cannot be null!");
    }
    if (view is Component) return render(view.view);
    ViewRenderer<E, View> ren = getFor(view);
    if (ren != null) return ren(view, this);
    // Handle types with generic arguments
    for (ViewRenderer<E, View> r in allRenderers) {
      try {
        E ret = r(view, this);
        return ret;
      } catch (e) {
        // print('$r:');
        // print(e);
      }
    }
    throw new Exception("A renderer for ${view.runtimeType} not found!");
  }

  void merge(Renderer<E> other);

  Renderer<E> clone();
}
