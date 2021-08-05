import 'package:flutter/material.dart';

class ReuseableCard extends StatelessWidget {
  const ReuseableCard(
      {Key? key, required this.color, required this.icon, required this.title})
      : super(key: key);

  final Color color;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color.withOpacity(0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(
              icon,
              size: 40,
              color: color.withOpacity(1),
            ),
          ),
          Text(
            title,
            style: TextStyle(color: color.withOpacity(1), fontSize: 15),
          ),
        ],
      ),
    );
  }
}
