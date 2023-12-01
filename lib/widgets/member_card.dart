import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';

class MemberCard extends StatelessWidget {
  final User user;

  const MemberCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 75,
      child: Card(
        color: const Color(0xFFD4515D),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Text(
                    user.email,
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
      ),
    );
  }
}
