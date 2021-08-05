import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_task/category_model.dart';
import 'package:flutter_task/const.dart';
import 'package:flutter_task/cooking_screen.dart';
import 'package:flutter_task/database_helper.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedId;
  final textController = TextEditingController();
  File? path;
  final picker = ImagePicker();
  String? img64;
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff8f9ff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                color: Color(0xff6c60e1),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 60, left: 30, right: 30, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.widgets_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                    Text(
                      'Hi Abdullah',
                      style: kTextStyle.copyWith(fontSize: 25),
                    ),
                    Text(
                      'Welcome Back',
                      style: kTextStyle.copyWith(
                          fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(168, 160, 236, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30,
                          ),
                          Text(
                            'What do you want to search',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.delete_outline_rounded,
                            size: 30,
                            color: Color(0xffc1bde3),
                          ),
                          Icon(
                            Icons.note_alt_outlined,
                            size: 30,
                            color: Color(0xffc1bde3),
                          ),
                          Icon(
                            Icons.import_export_outlined,
                            size: 30,
                            color: Color(0xff6d65c3),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ReuseableCard(
                        title: 'New Idea',
                        icon: Icons.lightbulb_outlined,
                        color: Colors.amber,
                      ),
                      ReuseableCard(
                        title: 'Music',
                        icon: Icons.audiotrack_outlined,
                        color: Color(0xff4198e6),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ReuseableCard(
                        title: 'Programming',
                        icon: Icons.desktop_windows_outlined,
                        color: Color(0xff8973e1),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CookingScreen()));
                          },
                          child: ReuseableCard(
                            title: 'Cooking',
                            icon: Icons.lunch_dining_outlined,
                            color: Color(0xffd26fb7),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ReuseableCard(
                        title: 'Engineering',
                        icon: Icons.flight_takeoff_outlined,
                        color: Color(0xff45a585),
                      ),
                      ReuseableCard(
                        title: 'Science',
                        icon: Icons.science_outlined,
                        color: Color(0xfff3927a),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                      ),
                      margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Enter category',
                            contentPadding: EdgeInsets.only(left: 20)),
                        controller: textController,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          final pickedImageFile = await picker.pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 50,
                            maxWidth: 150,
                          );
                          final bytes =
                              File(pickedImageFile!.path).readAsBytesSync();
                          img64 = base64Encode(bytes);
                        },
                        child: Text('Select an image')),

                    TextButton(
                        onPressed: () async {
                          await DatabaseHelper.instance.add(
                            Category(
                                name: textController.text,
                                picture: img64.toString()),
                          );
                          setState(() {
                            textController.clear();
                            selectedId = null;
                            Navigator.pop(context);
                          });
                        },
                        child: Text('Add Category'))
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 50),
          height: 50,
          decoration: BoxDecoration(
              color: Color(0xfff8f9ff),
              borderRadius: BorderRadius.circular(40)),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(Icons.home_outlined), Icon(Icons.star_outline)],
            ),
          ),
        ),
      ),
    );
  }
}

class ReuseableCard extends StatelessWidget {
  const ReuseableCard(
      {Key? key, required this.color, required this.icon, required this.title})
      : super(key: key);

  final Color color;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color.withOpacity(0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(
              icon,
              size: 40,
              color: color.withOpacity(1),
            ),
          ),
          Text(
            title,
            style: TextStyle(color: color.withOpacity(1), fontSize: 15),
          ),
        ],
      ),
    );
  }
}
