import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/subpages/task_page.dart';
import 'package:project_zenith/widgets/draw_option.dart';
import 'package:project_zenith/widgets/sidebar_list.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: Row(
        children: [
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 330, maxWidth: 385
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 25),
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(2, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 29),
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
                          const Spacer(),
                          const Expanded(
                            flex: 18,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Production Department",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                Text(
                                  "In charge of operations",
                                  style: TextStyle(
                                    color: Color(0xFF636769),
                                    fontSize: 15,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SidebarList(
                      children: [
                        DrawOption(
                            imgPath: "assets/white_logo.png",
                            text: "Workspace",
                            func: () {},
                          ),
                          DrawOption(
                            imgPath: "assets/build_icon.png",
                            text: "Members",
                            func: () {},
                          ),
                      ]
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Row(children: [
                                const Text(
                                  'BOARDS',
                                  style: TextStyle(
                                    color: Color(0xFF959A9C),
                                    fontSize: 16,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {},
                                )
                              ]),
                            ),
                            Flexible(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minHeight: 375, maxHeight: 750
                                ),
                                child: SingleChildScrollView(
                                  child: SidebarList(
                                    children: [
                                      DrawOption(
                                        imgPath: "assets/join_icon.png",
                                        text: "Booth Department",
                                        func: () {},
                                      ),
                                      DrawOption(
                                        imgPath: "assets/join_icon.png",
                                        text: "Booth Department",
                                        func: () {},
                                      ),
                                      DrawOption(
                                        imgPath: "assets/join_icon.png",
                                        text: "Booth Department",
                                        func: () {},
                                      ),
                                      DrawOption(
                                        imgPath: "assets/join_icon.png",
                                        text: "Booth Department",
                                        func: () {},
                                      ),
                                      DrawOption(
                                        imgPath: "assets/join_icon.png",
                                        text: "Booth Department",
                                        func: () {},
                                      ),
                                      DrawOption(
                                        imgPath: "assets/join_icon.png",
                                        text: "Booth Department",
                                        func: () {},
                                      ),
                                      DrawOption(
                                        imgPath: "assets/join_icon.png",
                                        text: "Booth Department",
                                        func: () {},
                                      ),
                                      DrawOption(
                                        imgPath: "assets/join_icon.png",
                                        text: "Booth Department",
                                        func: () {},
                                      ),
                                      DrawOption(
                                        imgPath: "assets/join_icon.png",
                                        text: "Booth Department",
                                        func: () {},
                                      ),
                                      DrawOption(
                                        imgPath: "assets/join_icon.png",
                                        text: "Booth Department",
                                        func: () {},
                                      ),
                                      
                                    ]
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Padding(
                 padding: const EdgeInsets.only(left: 20, top: 21),
                  child: BackButton(onPressed: () {Navigator.pop(context);}),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 70, bottom: 30),
                  child: TaskPage(label: "Team Tasks",),
                )
              ]
            )
          ),
        ],
      ),
    );
  }
}
