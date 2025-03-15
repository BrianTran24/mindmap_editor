import 'package:flutter/material.dart';

class RectPosition {
  final Offset targetPosition;
  final Offset centerTopPosition;
  final Offset centerBottomPosition;
  final Offset centerLeftPosition;
  final Offset centerRightPosition;

  RectPosition(this.targetPosition, this.centerTopPosition, this.centerBottomPosition,
      this.centerLeftPosition, this.centerRightPosition);
}


class RectComponent extends StatefulWidget {
  final Offset initialPosition;
  final Color color;
  final Function(RectComponent) onTap;
  final Function(RectComponent, Offset) onPositionChanged;
  final Function(RectComponent)? onRightClick;
  Offset Function()? currentPosition;
  bool Function(Offset offset)? contains;
  RectPosition Function()? getRectPosition;

  RectComponent({
    super.key,
    required this.initialPosition,
    required this.color,
    required this.onTap,
    required this.onPositionChanged,
    this.currentPosition,
    this.onRightClick,
  });

  @override
  RectComponentState createState() => RectComponentState();
}

class RectComponentState extends State<RectComponent> {

  String text = 'Text';
  Offset _position = Offset.zero;

  Offset get position => _position;

  Offset get targetPosition =>
      Offset(_position.dx + _size.width / 2, _position.dy + _size.height / 2);

  Offset get centerTopPosition =>
      Offset(_position.dx + _size.width / 2, _position.dy);

  Offset get centerBottomPosition =>
      Offset(_position.dx + _size.width / 2, _position.dy + _size.height);

  Offset get centerLeftPosition =>
      Offset(_position.dx, _position.dy + _size.height / 2);

  Offset get centerRightPosition =>
      Offset(_position.dx + _size.width, _position.dy + _size.height / 2);

  Size _size = Size.zero;

  Size getSize(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    return renderBox.size;
  }

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    widget.currentPosition = () => _position;
    _position = widget.initialPosition;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _size = getSize(context);
      RectPosition rectPosition = RectPosition(
        targetPosition,
        centerTopPosition,
        centerBottomPosition,
        centerLeftPosition,
        centerRightPosition,
      );
      widget.getRectPosition = () => rectPosition;

      widget.contains  = (Offset offset) {
        return _contains(offset);
      };
    });
  }


  @override
  void didUpdateWidget(covariant RectComponent oldWidget) {
    // TODO: implement didUpdateWidget
    RectPosition rectPosition = RectPosition(
      targetPosition,
      centerTopPosition,
      centerBottomPosition,
      centerLeftPosition,
      centerRightPosition,
    );
    widget.getRectPosition = () => rectPosition;
    super.didUpdateWidget(oldWidget);
  }

  bool _contains(Offset offset) {
    return offset.dx >= _position.dx &&
        offset.dx <= _position.dx + _size.width &&
        offset.dy >= _position.dy &&
        offset.dy <= _position.dy + _size.height;
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onTap: () => widget.onTap(widget),
        onPanUpdate: (details) {
          setState(() {
            _position += details.delta;
          });
          RectPosition rectPosition = RectPosition(
            targetPosition,
            centerTopPosition,
            centerBottomPosition,
            centerLeftPosition,
            centerRightPosition,
          );
          widget.getRectPosition = () => rectPosition;
          widget.onPositionChanged(this.widget, _position);
          widget.contains  = (Offset offset) {
            return _contains(offset);
          };
        },
        onSecondaryTap: () {
          widget.onRightClick?.call(widget);
        },
        onDoubleTap: () async{
         var result = await _showTextInputDialog(context);
         if(result is String){
           setState(() {
             text = result;
           });
         }
        },
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true), // Khi di chuột vào
          onExit: (_) => setState(() => _isHovered = false),
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 100,
              minHeight: 50,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: _isHovered ? Colors.blue[100] : widget.color,
            ),
            child:  Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> _showTextInputDialog(BuildContext context) async{
   return await showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController textEditingController = TextEditingController();
        return AlertDialog(
          title: Text('Enter Text'),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: "Enter text here"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // Handle the text input
                String enteredText = textEditingController.text;
                print('Entered text: $enteredText');
                Navigator.of(context).pop(enteredText);
              },
            ),
          ],
        );
      },
    );
  }

}
