import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  String text = '';

  NoDataWidget({this.text = ''});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/no_items.png',
            height: 150,
            width: 150,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: TextStyle(
                color: Color.fromARGB(235, 72, 184, 192),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
