import 'package:flutter/material.dart';



///different arc shape design for custom

enum ArcPosition { Bottom, Top, Left, Right }
enum ArcDirection { Outside, Inside }

class ArcShape extends Shape {
  final ArcPosition position;
  final double height;
  final ArcDirection direction;
  final Color color;

  ArcShape({
    this.position = ArcPosition.Bottom,
    this.direction = ArcDirection.Outside,
    this.height = 10,
    this.color=Colors.amberAccent

  });

  @override
  Path build({Rect? rect, double? scale}) {
    return generatePath(rect!, scale);
  }

  Path generatePath(Rect rect, double? scale) {
    final size = rect.size;
    switch (this.position) {
      case ArcPosition.Top:
        if (direction == ArcDirection.Outside) {
          return Path()
            ..moveTo(0.0, height)
            ..quadraticBezierTo(size.width / 4, 0.0, size.width / 2, 0.0)
            ..quadraticBezierTo(size.width * 3 / 4, 0.0, size.width, height)
            ..lineTo(size.width, size.height)
            ..lineTo(0.0, size.height)
            ..close();
        } else {
          return Path()
            ..quadraticBezierTo(size.width / 4, height, size.width / 2, height)
            ..quadraticBezierTo(size.width * 3 / 4, height, size.width, 0.0)
            ..lineTo(size.width, size.height)
            ..lineTo(0.0, size.height)
            ..close();
        }
       // break;
      case ArcPosition.Bottom:
        if (direction == ArcDirection.Outside) {
          return Path()
            ..lineTo(0.0, size.height - height)
            ..quadraticBezierTo(
                size.width / 4, size.height, size.width / 2, size.height)
            ..quadraticBezierTo(size.width * 3 / 4, size.height, size.width,
                size.height - height)
            ..lineTo(size.width, 0.0)
            ..close();
        } else {
          return Path()
            ..moveTo(0.0, size.height)
            ..quadraticBezierTo(size.width / 4, size.height - height,
                size.width / 2, size.height - height)
            ..quadraticBezierTo(size.width * 3 / 4, size.height - height,
                size.width, size.height)
            ..lineTo(size.width, 0.0)
            ..lineTo(0.0, 0.0)
            ..close();
        }
        //break;
      case ArcPosition.Left:
        if (direction == ArcDirection.Outside) {
          return Path()
            ..moveTo(height, 0.0)
            ..quadraticBezierTo(0.0, size.height / 4, 0.0, size.height / 2)
            ..quadraticBezierTo(0.0, size.height * 3 / 4, height, size.height)
            ..lineTo(size.width, size.height)
            ..lineTo(size.width, 0.0)
            ..close();
        } else {
          return Path()
            ..quadraticBezierTo(
                height, size.height / 4, height, size.height / 2)
            ..quadraticBezierTo(height, size.height * 3 / 4, 0.0, size.height)
            ..lineTo(size.width, size.height)
            ..lineTo(size.width, 0.0)
            ..close();
        }
        //break;
      default: //right
        if (direction == ArcDirection.Outside) {
          return Path()
            ..moveTo(size.width - height, 0.0)
            ..quadraticBezierTo(
                size.width, size.height / 4, size.width, size.height / 2)
            ..quadraticBezierTo(size.width, size.height * 3 / 4,
                size.width - height, size.height)
            ..lineTo(0.0, size.height)
            ..lineTo(0.0, 0.0)
            ..close();
        } else {
          return Path()
            ..moveTo(size.width, 0.0)
            ..quadraticBezierTo(size.width - height, size.height / 4,
                size.width - height, size.height / 2)
            ..quadraticBezierTo(size.width - height, size.height * 3 / 4,
                size.width, size.height)
            ..lineTo(0.0, size.height)
            ..lineTo(0.0, 0.0)
            ..close();
        }
        //break;
    }
  }
}

abstract class Shape {
  Path build({Rect? rect, double? scale});
}

abstract class BorderShape {
  void drawBorder(Canvas canvas, Rect rect);
}

class ShapeOfViewBorder extends ShapeBorder {
  final Shape shape;

  ShapeOfViewBorder({required this.shape}) : assert(shape != null);

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(0);
  }

  @override
  ShapeBorder scale(double t) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return shape.build(rect: rect, scale: 1);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (shape is BorderShape) {
      (shape as BorderShape).drawBorder(canvas, rect);
    }
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final ShapeOfViewBorder typedOther = other;
    return shape == typedOther.shape;
  }

  @override
  int get hashCode => shape.hashCode;

  @override
  String toString() {
    return '$runtimeType($shape)';
  }
}

class ShapeOfView extends StatelessWidget {
  final Widget? child;
  final Shape? shape;
  final double elevation;
  final Clip clipBehavior;
  final double? height;
  final double? width;
  final Gradient ?color;

  ShapeOfView({

    this.child,
    this.elevation = 4,
    this.shape,
    this.clipBehavior = Clip.antiAlias,
    this.width,
    this.height,
    this.color,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: ShapeOfViewBorder(shape: this.shape!),
      clipBehavior: this.clipBehavior,
      elevation: this.elevation,
      child: Container(
        height: this.height,
        width: this.width,
        child: this.child,
        decoration: BoxDecoration(
          gradient: color
        ),
      ),
    );
  }
}