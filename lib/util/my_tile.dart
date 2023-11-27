import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  const MyTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.grey[200]),
              
            child: Center(
              child: Row(
                    children: [
                      const SizedBox(width: 50),
                      // ID widget
                      Text(
                        '1',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 60),
              
                      // Name widget
                      Text(
                        'John Doe',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 80),
              
                      // Email widget
                      Text(
                        'johndoe@example.com',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 80),
              
                      // Actions widget (e.g., buttons)
                      Row(
                        children: [
              // Edit button
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
                      const SizedBox(width: 20),
              // Delete button
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
                      const SizedBox(width: 20),
               IconButton(
                onPressed: () {},
                icon: const Icon(Icons.info_outline),
              ),
                        ],
                      ),
                    ],
                  ),
            )

      ),
    );
  }
}
