import 'package:flutter/material.dart';
import 'package:project_zenith/widgets/member_card.dart';
import 'package:project_zenith/widgets/submit_button.dart';

class MembersPage extends StatelessWidget {
  
  const MembersPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
              )
            ),
            const Spacer(),
            SubmitButton(
              text: "Invite Members", 
              gradient: const [Color(0xFF06BCC1),Color(0xFF047679)], 
              minSize: const Size(200, 50), 
              func: () {})
          ],
        ),
        const Divider(),
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 995, maxWidth: 1475
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                height: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // This next line does the trick.
                    children: [
                      MemberCard(),
                      MemberCard(),
                      MemberCard(),
                      MemberCard(),
                      MemberCard(),
                      MemberCard(),
                      MemberCard(),
                      MemberCard(),
                      MemberCard(),
                      MemberCard(),
                      MemberCard(),
                      MemberCard(),
                      MemberCard(),
                      MemberCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ]
    );
  }
}