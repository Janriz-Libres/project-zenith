import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  final String label;

  const TaskList({
    super.key, required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325,
      child: Card(
        color: Colors.black87,
        shadowColor: Colors.black45,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Rubik",
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz), 
                      onPressed: (){})
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(height: 75, color: Colors.red,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(height: 75, color: Colors.blue,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(height: 75, color: Colors.red,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(height: 75, color: Colors.blue,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(height: 75, color: Colors.red,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(height: 75, color: Colors.blue,),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  child: const Row(
                    children: [
                      Icon(Icons.add),
                      Text(
                        "Add a card"
                      )
                    ],
                  ), 
                  onPressed: () {}
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
