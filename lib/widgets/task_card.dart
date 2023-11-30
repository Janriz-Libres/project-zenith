import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {

  const TaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: 325,
        height: 90,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
              //set border radius more than 50% of height and width to make circle
          ),
          
        ),
      ),
    );
  }
}
