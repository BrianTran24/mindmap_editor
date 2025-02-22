import 'dart:ui';
import 'package:mindmap_editor/rect_component.dart';
import 'package:uuid/uuid.dart';

class Line {
  final RectComponent startWidget;
  final RectComponent endWidget;
  late String uid;

  Line(this.startWidget, this.endWidget){
    uid = const Uuid().v6();
  }

  Offset get start{
    var start = startWidget.currentPosition!();
    return start;
  }
  Offset get end {
    var end = endWidget.currentPosition!();
    return end;
  }
}