# Owlet Toast

Owlet Toast uses the overlay for show your custom toast via the [OverlayManager](https://pub.dev/packages/overlay_manager).

You can customize your toast's UI and Owlet Toast will make it show on the screen with the animation effect.
You also customize your animation effect.

## Import
The ``overlay_manager`` is needed when using ``owlet_toast``.

```yaml
dependencies:
      overlay_manager: ^0.0.1
      owlet_toast: ^0.0.1
```

# Usage

## Customize your toast

Define your toast's type to list out your toast's variant.
Then create the ``AppToast`` extends of ``OwletToast`` with 2 generic type arguments:
Your ``ToastType``, and your message data type.

```dart
enum ToastType {
  error,
  information,
  warning,
  success;
}

class AppToast extends OwletToast<ToastType, String>{
  const AppToast({required super.overlayManager});
  
  @override
  Widget buildToast(BuildContext context, ToastEntry<ToastType, String> entry) {
    // TODO: implement buildToast
    throw UnimplementedError();
  }
}
```


Override the ``buildToast`` method, which  return your toast UI widget. See more in [this example](https://github.com/sonnts996/owlet-toast/blob/main/example/lib/app_toast.dart).

```dart
class AppToast extends OwletToast<ToastType, String> {
  
  @override
  Widget buildToast(BuildContext context, ToastEntry<ToastType, String> entry) {
    return switch (entry.type) {
      ToastType.error =>
          Toasty(
            icon: const Icon(
              Icons.error_outline_rounded,
              color: Colors.white,
            ),
            color: Colors.red,
            message: entry.data,
          ),
      ToastType.information =>
          Toasty(
            icon: const Icon(
              Icons.info_outlined,
              color: Colors.blue,
            ),
            color: Colors.white,
            message: entry.data,
          ),
      ToastType.warning =>
          Toasty(
              icon: const Icon(
                Icons.warning_amber_outlined,
                color: Colors.white,
              ),
              color: Colors.orange,
              message: entry.data),
      ToastType.success =>
          Toasty(
              icon: Lottie.asset(
                'assets/success_animations.json',
                height: 32,
                width: 32,
                repeat: false,
              ),
              color: Colors.white,
              message: entry.data),
    };
  }
}
```

## Use it

In the ``main.dart`` or any where you want to define your toast (such as an injections).

```dart
final appToast = AppToast(overlayManager: GlobalOverlayManager(navigatorKey: navKey)); 
```

To show your toast, let's call ``appToast.show()``.

Another way, let's define this method in the ``AppToast`` class:

```dart

class AppToast extends OwletToast<ToastType, String> {
  
  Future<R?> showInformation<R extends Object>(String message) {
    return show(
        type: ToastType.information,
        data: message,
        alignment: const Alignment(0, -0.7),
        transitionDelegate: const TranslateTransitionDelegate(direction: Alignment.topCenter),
        transitionDuration: const Duration(milliseconds: 500),
        holdDuration: const Duration(seconds: 1));
  }
}
```

...and call:

```dart
    appToast.showInformation('Hello World');
```

## ToastTransitionDelegate

In default, there are 3 ``ToastTransitionDelegate`` in ``owlet_toast`` package

* With ``TranslateTransitionDelegate``, the toast will be shown with transform animation from
  the ``start`` position to the ``destination`` position with the defined ``direction``.

<img src="https://github.com/sonnts996/owlet-toast/blob/main/documents_assets/gif1.gif?raw=true" width="200" /> 


* With ``FadeTransitionDelegate``, the toast will appear and dismiss with fade animation.

<div>
<table >
     <tr>
        <td><b> <img src="https://github.com/sonnts996/owlet-toast/blob/main/documents_assets/gif3.gif?raw=true" width="200" /> </b></td>
        <td><b> <img src="https://github.com/sonnts996/owlet-toast/blob/main/documents_assets/gif4.gif?raw=true" width="200" /> </b></td>
     </tr>
</table>
</div>

> Some custom animation with ``FadeTransitionDelegate`` in [example](https://github.com/sonnts996/owlet-toast/blob/main/example/lib/app_toast.dart).:

<div>
<table >
     <tr>
        <td><b> <img src="https://github.com/sonnts996/owlet-toast/blob/main/documents_assets/gif5.gif?raw=true" width="200" /> </b></td>
        <td><b> <img src="https://github.com/sonnts996/owlet-toast/blob/main/documents_assets/gif6.gif?raw=true" width="200" /> </b></td>
     </tr>
</table>
</div>

* With ``ShakeTransitionDelegate``, the toast will appear with a shake animation and dismiss with a
  fade animation.

<img src="https://github.com/sonnts996/owlet-toast/blob/main/documents_assets/gif2.gif?raw=true" width="200" />

To customize your toast transition animation, please override the ``transition`` or ``opacity`` method in ``ToastTransitionDelegate``.

```dart
class CustomTransitionDelegate with ToastTransitionDelegate{ 
  @override
  Offset transition(AnimationStatus animationStatus, double animationValue) {
    // TODO: implement transition
    throw UnimplementedError();
  }

  @override
  double opacity(AnimationStatus animationStatus, double animationValue) {
    // TODO: implement opacity
    return super.opacity(animationStatus, animationValue);
  }
}
```

## Tips!

- Toast appearance area is inside the ``MediaQuery.viewInsetsOf(context)``.
- Using ``Alignment`` not only aligns your toast's widget but also moves the original position to a
  factor of the screen.

> Example: ``Alignment(0, -0.7)`` will move your widget to ``0.5 x screen width`` (center x)
and ``0.6 x screen height`` (zero point is in center of screen).

- Override ``ToastTransitionDelegate.transition`` also changes the original position of toast's widget.

<div style="background: white; padding: 10px; width: 500px">
<img src="https://github.com/sonnts996/owlet-toast/blob/main/documents_assets/aligment.png?raw=true" width="500" /> 
</div>

# Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/sonnts996/owlet-toast/issues).