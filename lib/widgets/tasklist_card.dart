import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  final String label;

  const TaskList({
    super.key,
    required this.label,
  });

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: SizedBox(
        width: 321,
        child: Card(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            //set border radius more than 50% of height and width to make circle
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.label.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      IconButton(
                          icon: const Icon(Icons.more_horiz), onPressed: () {})
                    ],
                  ),
                ),
                const Divider(),
                const Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.add),
                          Text(
                            "Add a card",
                            style: TextStyle(fontFamily: "Rubik", fontSize: 16),
                          )
                        ],
                      ),
                      onPressed: () {}),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
