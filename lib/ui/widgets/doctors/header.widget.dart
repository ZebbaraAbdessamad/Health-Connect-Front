import 'dart:io';

import 'package:flutter/material.dart';
import 'package:health_connect/theme/extention.dart';

import '../../../service/api_service.dart';
import '../../../theme/light_color.dart';
import '../../../model/patient.dart';
import '../../../model/doctor.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {

  dynamic user;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    print("Fetching user...........................................");
    dynamic fetchedUser = await ApiService.getUser();
    print("==========================>$fetchedUser");
    setState(() {
      user = fetchedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: LightColor.green,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.notifications_none,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            // add onPressed functionality if needed
          },
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: Container(
            decoration: BoxDecoration(
              color: LightColor.lightGreen,
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: getImageWidget(),
            ),
          ),
        ).p(8),
      ],
    );
  }

  Widget getImageWidget() {
    if (user is Patient) {
      Patient patient = user;
      if (patient.image != null && File(patient.image!).existsSync()) {
        return Image.file(
          File(patient.image as String),
          fit: BoxFit.fill,
        );
      }
      return Image.asset(
        'assets/images/man.png',
        fit: BoxFit.fill,
      );
    } else if (user is Doctor) {
      Doctor doctor = user;
      return Image.asset(
        doctor.image ?? '',
        fit: BoxFit.fill,
      );
    } else {
      // Default image widget
      return Image.asset(
        'assets/images/man.png',
        fit: BoxFit.fill,
      );
    }
  }
}
