// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:mind_map_editor/rect_component.dart';
//
// import 'line.dart';
//
// class LinePainter extends CustomPainter {
//   final Line line;
//
//   LinePainter(this.line);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;
//
//     Offset start;
//
//     Offset end;
//
//     RectPosition startRectPosition = line.startWidget.getRectPosition!();
//     RectPosition endRectPosition = line.endWidget.getRectPosition!();
//
//     if (startRectPosition.targetPosition.dx <
//         endRectPosition.targetPosition.dx) {
//       // Widget đích nằm bên trái
//       start = startRectPosition.centerRightPosition;
//       end = endRectPosition.centerLeftPosition;
//     } else if (startRectPosition.targetPosition.dx >
//         endRectPosition.targetPosition.dx) {
//       // Widget đích nằm bên phải
//       start = startRectPosition.centerLeftPosition;
//       end = endRectPosition.centerRightPosition;
//     } else if (startRectPosition.targetPosition.dy <
//         endRectPosition.targetPosition.dy) {
//       // Widget đích nằm phía trên
//       start = startRectPosition.centerTopPosition;
//       end = endRectPosition.centerBottomPosition;
//     } else {
//       // Widget đích nằm phía dưới
//       start = startRectPosition.centerBottomPosition;
//       end = endRectPosition.centerTopPosition;
//     }
//
//     // Tính toán các điểm trung gian để tạo đường gấp khúc
//     final mid1 = Offset((start.dx + end.dx) / 2, start.dy); // Điểm giữa theo trục X
//     final mid2 = Offset(mid1.dx, end.dy); // Điểm giữa theo trục Y
//
//     // Vẽ đường gấp khúc
//     final path = Path()
//       ..moveTo(start.dx, start.dy) // Bắt đầu từ điểm start
//       ..lineTo(mid1.dx, mid1.dy) // Đoạn 1: start -> mid1
//       ..lineTo(mid2.dx, mid2.dy) // Đoạn 2: mid1 -> mid2
//       ..lineTo(end.dx, end.dy); // Đoạn 3: mid2 -> end
//
//     canvas.drawPath(path, paint);
//
//     // Vẽ mũi tên tại điểm cuối
//     _drawArrow(canvas, mid2, end, paint);
//   }
//
//   void _drawArrow(Canvas canvas, Offset start, Offset end, Paint paint) {
//     final arrowSize = 10.0; // Kích thước mũi tên
//     final angle = (end - start).direction; // Góc của đường kẻ
//     final arrowTip = end;
//
//     // Tính toán các điểm của mũi tên
//     final arrowPoint1 = Offset(
//       arrowTip.dx - arrowSize * cos(angle - pi / 6),
//       arrowTip.dy - arrowSize * sin(angle - pi / 6),
//     );
//     final arrowPoint2 = Offset(
//       arrowTip.dx - arrowSize * cos(angle + pi / 6),
//       arrowTip.dy - arrowSize * sin(angle + pi / 6),
//     );
//
//     // Vẽ mũi tên
//     final path = Path()
//       ..moveTo(arrowTip.dx, arrowTip.dy)
//       ..lineTo(arrowPoint1.dx, arrowPoint1.dy)
//       ..lineTo(arrowPoint2.dx, arrowPoint2.dy)
//       ..close();
//     canvas.drawPath(path, paint..style = PaintingStyle.fill);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
//
//
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:mind_map_editor/rect_component.dart';
//
// import 'line.dart';
//
// class LineEditor extends StatefulWidget {
//   final Line line;
//
//   LineEditor({required this.line});
//
//   @override
//   _LineEditorState createState() => _LineEditorState();
// }
//
// class _LineEditorState extends State<LineEditor> {
//   Offset _mid1 = Offset(0, 0); // Điểm trung gian 1
//   Offset _mid2 = Offset(0, 0); // Điểm trung gian 2
//
//   @override
//   void initState() {
//     super.initState();
//     // Khởi tạo vị trí ban đầu của mid1 và mid2
//     _initializeMidPoints();
//   }
//
//   void _initializeMidPoints() {
//     RectPosition startRectPosition = widget.line.startWidget.getRectPosition!();
//     RectPosition endRectPosition = widget.line.endWidget.getRectPosition!();
//
//     Offset start;
//     Offset end;
//
//     if (startRectPosition.targetPosition.dx < endRectPosition.targetPosition.dx) {
//       start = startRectPosition.centerRightPosition;
//       end = endRectPosition.centerLeftPosition;
//     } else if (startRectPosition.targetPosition.dx > endRectPosition.targetPosition.dx) {
//       start = startRectPosition.centerLeftPosition;
//       end = endRectPosition.centerRightPosition;
//     } else if (startRectPosition.targetPosition.dy < endRectPosition.targetPosition.dy) {
//       start = startRectPosition.centerTopPosition;
//       end = endRectPosition.centerBottomPosition;
//     } else {
//       start = startRectPosition.centerBottomPosition;
//       end = endRectPosition.centerTopPosition;
//     }
//
//     // Khởi tạo mid1 và mid2 dựa trên start và end
//     setState(() {
//       _mid1 = Offset((start.dx + end.dx) / 2, start.dy);
//       _mid2 = Offset(_mid1.dx, end.dy);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     RectPosition startRectPosition = widget.line.startWidget.getRectPosition!();
//     RectPosition endRectPosition = widget.line.endWidget.getRectPosition!();
//
//     Offset start;
//     Offset end;
//
//     if (startRectPosition.targetPosition.dx < endRectPosition.targetPosition.dx) {
//       start = startRectPosition.centerRightPosition;
//       end = endRectPosition.centerLeftPosition;
//     } else if (startRectPosition.targetPosition.dx > endRectPosition.targetPosition.dx) {
//       start = startRectPosition.centerLeftPosition;
//       end = endRectPosition.centerRightPosition;
//     } else if (startRectPosition.targetPosition.dy < endRectPosition.targetPosition.dy) {
//       start = startRectPosition.centerTopPosition;
//       end = endRectPosition.centerBottomPosition;
//     } else {
//       start = startRectPosition.centerBottomPosition;
//       end = endRectPosition.centerTopPosition;
//     }
//
//     return Stack(
//       children: [
//         // Vẽ đường kẻ
//         CustomPaint(
//           size: Size.infinite,
//           painter: LinePainter(start, end, _mid1, _mid2),
//         ),
//         // Widget cho mid1
//         Positioned(
//           left: _mid1.dx - 10,
//           top: _mid1.dy - 10,
//           child: GestureDetector(
//             behavior: HitTestBehavior.translucent,
//             onPanUpdate: (details) {
//               setState(() {
//                 _mid1 = Offset(
//                   _mid1.dx + details.delta.dx,
//                   _mid1.dy + details.delta.dy,
//                 );
//               });
//             },
//             child: Container(
//               width: 20,
//               height: 20,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//         ),
//         // Widget cho mid2
//         Positioned(
//           left: _mid2.dx - 10,
//           top: _mid2.dy - 10,
//           child: GestureDetector(
//             behavior: HitTestBehavior.translucent,
//             onPanUpdate: (details) {
//               setState(() {
//                 _mid2 = Offset(
//                   _mid2.dx + details.delta.dx,
//                   _mid2.dy + details.delta.dy,
//                 );
//               });
//             },
//             child: Container(
//               width: 20,
//               height: 20,
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class LinePainter extends CustomPainter {
//   final Offset start;
//   final Offset end;
//   final Offset mid1;
//   final Offset mid2;
//
//   LinePainter(this.start, this.end, this.mid1, this.mid2);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;
//
//     // Vẽ đường gấp khúc
//     final path = Path()
//       ..moveTo(start.dx, start.dy) // Bắt đầu từ điểm start
//       ..lineTo(mid1.dx, mid1.dy) // Đoạn 1: start -> mid1
//       ..lineTo(mid2.dx, mid2.dy) // Đoạn 2: mid1 -> mid2
//       ..lineTo(end.dx, end.dy); // Đoạn 3: mid2 -> end
//
//     canvas.drawPath(path, paint);
//
//     // Vẽ mũi tên tại điểm cuối
//     _drawArrow(canvas, mid2, end, paint);
//   }
//
//   void _drawArrow(Canvas canvas, Offset start, Offset end, Paint paint) {
//     final arrowSize = 10.0; // Kích thước mũi tên
//     final angle = (end - start).direction; // Góc của đường kẻ
//     final arrowTip = end;
//
//     // Tính toán các điểm của mũi tên
//     final arrowPoint1 = Offset(
//       arrowTip.dx - arrowSize * cos(angle - pi / 6),
//       arrowTip.dy - arrowSize * sin(angle - pi / 6),
//     );
//     final arrowPoint2 = Offset(
//       arrowTip.dx - arrowSize * cos(angle + pi / 6),
//       arrowTip.dy - arrowSize * sin(angle + pi / 6),
//     );
//
//     // Vẽ mũi tên
//     final path = Path()
//       ..moveTo(arrowTip.dx, arrowTip.dy)
//       ..lineTo(arrowPoint1.dx, arrowPoint1.dy)
//       ..lineTo(arrowPoint2.dx, arrowPoint2.dy)
//       ..close();
//     canvas.drawPath(path, paint..style = PaintingStyle.fill);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mindmap_editor/rect_component.dart';

import 'line.dart';


class MultiLineEditor extends StatefulWidget {
  final List<Line> lines;

  const MultiLineEditor({required this.lines, super.key});

  @override
  MultiLineEditorState createState() => MultiLineEditorState();
}

class MultiLineEditorState extends State<MultiLineEditor> {
  // Danh sách các điểm trung gian cho mỗi đường kẻ
  List<Offset> mid1List = [];
  List<Offset> mid2List = [];

  @override
  void initState() {
    super.initState();
    // Khởi tạo vị trí ban đầu của các điểm trung gian
    _initializeMidPoints();
  }

  void _initializeMidPoints() {
    for (var line in widget.lines) {
      _addMidPointsForLine(line);
    }
  }

  void _addMidPointsForLine(Line line) {
    RectPosition startRectPosition = line.startWidget.getRectPosition!();
    RectPosition endRectPosition = line.endWidget.getRectPosition!();

    final delta = endRectPosition.targetPosition - startRectPosition.targetPosition;
    final angle = atan2(delta.dy, delta.dx);

    Offset start;
    Offset end;

    if (angle >= -3 * pi / 4 && angle < -pi / 4) {
      // Bên trên
      start = startRectPosition.centerTopPosition;
      end = endRectPosition.centerBottomPosition;
    } else if (angle >= -pi / 4 && angle < pi / 4) {
      // Bên phải
      start = startRectPosition.centerRightPosition;
      end = endRectPosition.centerLeftPosition;
    } else if (angle >= pi / 4 && angle < 3 * pi / 4) {
      // Bên dưới
      start = startRectPosition.centerBottomPosition;
      end = endRectPosition.centerTopPosition;
    } else {
      // Bên trái
      start = startRectPosition.centerLeftPosition;
      end = endRectPosition.centerRightPosition;
    }


    // Thêm mid1 và mid2 vào danh sách
    mid1List.add(Offset((start.dx + end.dx) / 2, start.dy));
    mid2List.add(Offset(mid1List.last.dx, end.dy));
  }

  void addLine(Line newLine) {
    setState(() {
      widget.lines.add(newLine); // Thêm đường kẻ mới vào danh sách
      _addMidPointsForLine(newLine); // Thêm các điểm trung gian tương ứng
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Vẽ tất cả các đường kẻ
        for (int i = 0; i < widget.lines.length; i++)
          CustomPaint(
            size: Size.infinite,
            painter: LinePainter(
              widget.lines[i].startWidget.getRectPosition!(),
              widget.lines[i].endWidget.getRectPosition!(),
              mid1List[i],
              mid2List[i],
            ),
          ),
        // Vẽ các điểm trung gian có thể kéo được
        for (int i = 0; i < widget.lines.length; i++) ...[
          // Widget cho mid1 của đường kẻ thứ i
          Positioned(
            left: mid1List[i].dx - 3,
            top: mid1List[i].dy - 3,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  mid1List[i] = Offset(
                    mid1List[i].dx + details.delta.dx,
                    mid1List[i].dy + details.delta.dy,
                  );
                });
              },
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          // Widget cho mid2 của đường kẻ thứ i
          Positioned(
            left: mid2List[i].dx -3,
            top: mid2List[i].dy - 3,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  mid2List[i] = Offset(
                    mid2List[i].dx + details.delta.dx,
                    mid2List[i].dy + details.delta.dy,
                  );
                });
              },
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class LinePainter extends CustomPainter {
  final RectPosition startRectPosition;
  final RectPosition endRectPosition;
  final Offset mid1;
  final Offset mid2;

  LinePainter(this.startRectPosition, this.endRectPosition, this.mid1, this.mid2);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;
    // Tính toán góc giữa widget 1 và widget 2
    final delta = endRectPosition.targetPosition - startRectPosition.targetPosition;
    final angle = atan2(delta.dy, delta.dx);

    Offset start;
    Offset end;

    if (angle >= -3 * pi / 4 && angle < -pi / 4) {
      // Bên trên
      start = startRectPosition.centerTopPosition;
      end = endRectPosition.centerBottomPosition;
    } else if (angle >= -pi / 4 && angle < pi / 4) {
      // Bên phải
      start = startRectPosition.centerRightPosition;
      end = endRectPosition.centerLeftPosition;
    } else if (angle >= pi / 4 && angle < 3 * pi / 4) {
      // Bên dưới
      start = startRectPosition.centerBottomPosition;
      end = endRectPosition.centerTopPosition;
    } else {
      // Bên trái
      start = startRectPosition.centerLeftPosition;
      end = endRectPosition.centerRightPosition;
    }

    // Vẽ đường gấp khúc
    final path = Path()
      ..moveTo(start.dx, start.dy) // Bắt đầu từ điểm start
      ..lineTo(mid1.dx, mid1.dy) // Đoạn 1: start -> mid1
      ..lineTo(mid2.dx, mid2.dy) // Đoạn 2: mid1 -> mid2
      ..lineTo(end.dx, end.dy); // Đoạn 3: mid2 -> end

    canvas.drawPath(path, paint);

    canvas.drawPath(path, paint);

    // Vẽ mũi tên tại điểm cuối
    _drawArrow(canvas, mid2, end, paint);
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end, Paint paint) {
    final arrowSize = 10.0; // Kích thước mũi tên
    final angle = (end - start).direction; // Góc của đường kẻ
    final arrowTip = end;

    // Tính toán các điểm của mũi tên
    final arrowPoint1 = Offset(
      arrowTip.dx - arrowSize * cos(angle - pi / 6),
      arrowTip.dy - arrowSize * sin(angle - pi / 6),
    );
    final arrowPoint2 = Offset(
      arrowTip.dx - arrowSize * cos(angle + pi / 6),
      arrowTip.dy - arrowSize * sin(angle + pi / 6),
    );

    // Vẽ mũi tên
    final path = Path()
      ..moveTo(arrowTip.dx, arrowTip.dy)
      ..lineTo(arrowPoint1.dx, arrowPoint1.dy)
      ..lineTo(arrowPoint2.dx, arrowPoint2.dy)
      ..close();
    canvas.drawPath(path, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}