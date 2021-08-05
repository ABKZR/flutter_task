
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 50),
        height: 50,
        decoration: BoxDecoration(
            color: Color(0xfff8f9ff),
            borderRadius: BorderRadius.circular(40)),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Icon(Icons.home_outlined), Icon(Icons.star_outline)],
          ),
        ),
      ),
    );
  }
}
