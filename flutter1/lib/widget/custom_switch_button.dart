import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _circleAnimation;
  bool isFirstCircleVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      // duration: Duration(milliseconds: 10000),
    );
    _circleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_animationController.isCompleted) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
        widget.onChanged(!widget.value);
        setState(() {
          isFirstCircleVisible = !isFirstCircleVisible;
        });
      },
      child: Container(
        width: 80.0,
        height: 46.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Align(
              alignment: _circleAnimation.value,
              child: Container(
                alignment:
                widget.value
                    ? ((Directionality.of(context) == TextDirection.rtl)
                    ? Alignment.centerLeft
                    : Alignment.centerRight)
                    : ((Directionality.of(context) == TextDirection.rtl)
                    ? Alignment.centerRight
                    : Alignment.centerLeft),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: widget.value ? Colors.green : Colors.pink,
                  child: Center(
                    child: Text(isFirstCircleVisible ? "Register" : "Login"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
}
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
