import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {

  const MemberCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 75,
      child: Card(
        color: Color(0xFFD4515D),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
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
              const SizedBox(width: 20,),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Username",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Text(
                    "Email Address",
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
            ],
          ),
        ),
      ),
    );
  }
}
