import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String desc;

  const TaskCard({
    super.key, required this.title, required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
            //set border radius more than 50% of height and width to make circle
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                desc.isEmpty ? Container() : Text(
                  desc,
                  style: const TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 12,
                    color: Colors.black87
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
