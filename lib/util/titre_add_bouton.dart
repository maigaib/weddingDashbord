import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final String titre;

  const MyButton({
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.titre,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
                SizedBox(width: 300,),
          Container(
             child: Text(titre),
                ),
                SizedBox(width: 200,),
          ElevatedButton(
          //  style: ElevatedButton.styleFrom(
          //   color : Color.fromRGBO(253, 139, 139, 1),
          // ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,color: Color.fromRGBO(253, 139, 139, 1),),
                const SizedBox(width: 8),
                Text(text,style: const TextStyle(color: Color.fromRGBO(253, 139, 139, 1),),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
