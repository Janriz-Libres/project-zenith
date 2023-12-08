import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/globals.dart';

class RenderTimePage extends StatefulWidget {
  const RenderTimePage({super.key});

  @override
  State<RenderTimePage> createState() => _RenderTimePageState();
}

class _RenderTimePageState extends State<RenderTimePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("Render Hours",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  )),
              const Spacer(),
              SubmitButton(
                text: "Export Attendances",
                gradient: const [Color(0xFF06BCC1), Color(0xFF047679)],
                minSize: const Size(200, 75),
                func: () async {},
              )
            ],
          ),
          const Divider(),
          gAttendances.isEmpty
              ? const Column(
                  mainAxisSize: MainAxisSize.min,
                )
              : Flexible(
                  child: ListView.builder(
                    itemCount: gAttendances.length,
                    itemBuilder: (context, index) {
                      Attendance attendance = gAttendances.elementAt(index);

                      return SizedBox(
                        height: 75,
                        child: Card(
                          color: const Color(0xFF06BCC1),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: const ShapeDecoration(
                                          color: Color(0xFF313638),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            attendance.user.username
                                                .toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                          Text(
                                            attendance.user.email,
                                            style: const TextStyle(
                                              color: Color(0xFF636769),
                                              fontSize: 15,
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                    flex: 2,
                                    child: Text("${attendance.checkedin}")),
                                const Spacer(),
                                attendance.checkedout == null
                                    ? const Spacer(flex: 2)
                                    : Expanded(
                                        flex: 2,
                                        child:
                                            Text("${attendance.checkedout}")),
                                const Spacer(),
                                attendance.duration == null
                                    ? const Spacer()
                                    : Expanded(
                                        child: Text("${attendance.duration}")),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

// class RenderTimePage extends StatelessWidget {
//   const RenderTimePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: gAllUsers
//           .map((e) => Row(children: [
//                 Text(e.email.toString()),
//                 Text(e.totalMinutes.toString()),
//               ]))
//           .toList(),
//     );
//   }
// }
