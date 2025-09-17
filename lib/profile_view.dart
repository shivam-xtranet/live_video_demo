import 'package:camera_id_demo_android/widgets/profie_card_4.dart';
import 'package:camera_id_demo_android/widgets/profile_card.dart';
import 'package:camera_id_demo_android/widgets/profile_card3.dart';
import 'package:camera_id_demo_android/widgets/profile_card_2.dart';
import 'package:camera_id_demo_android/widgets/profile_card_5.dart';
import 'package:camera_id_demo_android/widgets/profile_card_6.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.filePath});
  final String? filePath;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile Card',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF031273),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Color(0xFF031273)),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelStyle: TextStyle(color: Color(0xFF031273)),
            unselectedLabelStyle: TextStyle(color: Colors.grey[600]),
            tabs: [
              Tab(icon: Icon(Icons.tab), text: 'Profile One'),
              Tab(icon: Icon(Icons.tab), text: 'Profile Two'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProfileCard6(),

            // ProfileCard(filePath: widget.filePath),
            // ProfileCard2(filePath: widget.filePath,),
            // ProfileCard3(filePath: widget.filePath),
            ProfieCard4(filePath: widget.filePath)


          ],
        ),
      ),
    );
  }
}
