import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/db_api.dart';

class MembersPage extends StatelessWidget {
  final Workspace space;

  const MembersPage({
    super.key,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(
        children: [
          const Text(
            "Workspace Members",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          const Spacer(),
          SubmitButton(
            text: "Invite Members",
            gradient: const [Color(0xFF06BCC1), Color(0xFF047679)],
            minSize: const Size(200, 50),
            func: () async {
              await showDialog(
                useSafeArea: false,
                context: context,
                builder: (context) {
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
                                      "Tada! Here's the code",
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
                                    icon: const Icon(Icons.close),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
                              child: Row(
                                children: [
                                  Text(
                                    space.code.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Rubik",
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => Clipboard.setData(
                                      ClipboardData(text: space.code.toString()),
                                    ).then(
                                      (value) => ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Copied!'),
                                      )),
                                    ),
                                    icon: const Icon(Icons.copy),
                                  ),
                                ],  
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      const Divider(),
      Flexible(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 995, maxWidth: 1475),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // This next line does the trick.
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("Owner",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              )),
                        ),
                        MemberCard(
                          user: space.owner,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Members",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                )),
                          ),
                          Column(
                            children: space.members
                                .map((e) => MemberCard(user: e))
                                .toList(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
