import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';

class JoinWorkspace extends StatelessWidget {
  const JoinWorkspace({
    super.key,
    required this.codeController,
  });

  final TextEditingController codeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        content: SizedBox(
          width: 350,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 35, left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 250,
                      child: Text(
                        "Join an existing workspace",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 12, right: 12),
                child: TextFormField(
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  controller: codeController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color(0xFF06BCC1),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: const EdgeInsets.only(left: 20, right: 20),
                    hintText: "Enter workspace code",
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 144, 142, 142),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25, right: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SubmitButton(
                    text: "Enter",
                    gradient: const [Color(0xFF06BCC1), Color(0xFF168285)],
                    minSize: const Size(200, 50),
                    func: () async {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
