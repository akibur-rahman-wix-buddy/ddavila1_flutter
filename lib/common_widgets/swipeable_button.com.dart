import 'package:flutter/material.dart';

class SwipeableButton extends StatefulWidget {
  final String firstText;
  final String secondText;
  final Color activeColor;
  final Color inactiveColor;
  final Color underlineColor;
  final double width;
  final double height;

  // Constructor to customize the button
  const SwipeableButton({
    Key? key,
    required this.firstText,
    required this.secondText,
    this.activeColor = Colors.white,
    this.inactiveColor = const Color(0xFF919191),
    this.underlineColor = Colors.white,
    this.width = 150.0,
    this.height = 30.0,
  }) : super(key: key);

  @override
  _SwipeableButtonState createState() => _SwipeableButtonState();
}

class _SwipeableButtonState extends State<SwipeableButton> {
  int _selectedIndex = 0; // Tracks the selected text (0 for firstText, 1 for secondText)

  // Method to handle text selection
  void _onTextTap(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Background underline that moves based on selected index
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: _selectedIndex * (widget.width / 2), // Position the underline according to the selected text
            bottom: 0,
            child: Container(
              width: widget.width / 16, // Set the underline width to match half the width of the button
              height: 4,
              color: widget.underlineColor, // Underline color
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Text Button
              InkWell(
                onTap: () => _onTextTap(0), // When tapped, update selected index
                child: Container(
                  width: widget.width / 2,
                  height: widget.height,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.firstText,
                    style: TextStyle(
                      color: _selectedIndex == 0 ? widget.activeColor : widget.inactiveColor,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              // Second Text Button
              InkWell(
                onTap: () => _onTextTap(1), // When tapped, update selected index
                child: Container(
                  width: widget.width / 2,
                  height: widget.height,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.secondText,
                    style: TextStyle(
                      color: _selectedIndex == 1 ? widget.activeColor : widget.inactiveColor,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
