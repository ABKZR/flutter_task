import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_task/model/category_model.dart';
import 'package:flutter_task/const.dart';
import 'package:flutter_task/model/database_helper.dart';
import 'package:flutter_task/model/category_card_model.dart';
import 'package:flutter_task/screens/cooking_screen.dart';
import 'package:flutter_task/widgets/reuseable_card.dart';
import 'package:flutter_task/widgets/bottom_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatelessWidget {
  int? selectedId;
  final textController = TextEditingController();
  File? path;
  final picker = ImagePicker();

  List<CategoryCardModel> card = [
    CategoryCardModel(
      'New Idea',
      Colors.amber,
      Icons.lightbulb_outlined,
    ),
    CategoryCardModel('Music', Color(0xff4198e6), Icons.audiotrack_outlined),
    CategoryCardModel(
        'Programming', Color(0xff8973e1), Icons.desktop_windows_outlined),
    CategoryCardModel(
        'Cooking', Color(0xffd26fb7), Icons.lunch_dining_outlined),
    CategoryCardModel(
        'Engineering', Color(0xff45a585), Icons.flight_takeoff_outlined),
    CategoryCardModel('Science', Color(0xfff3927a), Icons.science_outlined),
  ];
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
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
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
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: card.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            if (card[index].title == 'Cooking') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CookingScreen()));
                            }
                          },
                          child: ReuseableCard(
                              color: card[index].color,
                              icon: card[index].icon,
                              title: card[index].title));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await buildShowModelSheet(context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }

  buildShowModelSheet(BuildContext context) async {
    showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(),
                    margin:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                        textController.clear();
                          Navigator.pop(context);
                        },
                      child: Text('Add Category'))
                ],
              );
            });
  }
}
