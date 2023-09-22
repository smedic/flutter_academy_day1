import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final double radius;
  final Color color;
  final VoidCallback onClick;
  final Widget? icon;
  final bool isValid;
  final Color textColor;

  const CustomButton({
    required this.title,
    required this.onClick,
    this.radius = 16,
    this.color = Colors.red,
    this.textColor = Colors.white,
    this.icon,
    this.isValid = true,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
          color: widget.isValid ? widget.color : Colors.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: widget.textColor,
              ),
            ),
            const SizedBox(width: 4),
            if (widget.icon != null) widget.icon!,
          ],
        ),
      ),
    );
  }
}
