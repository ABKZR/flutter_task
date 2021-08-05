import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task/model/category_model.dart';
import 'package:flutter_task/const.dart';
import 'package:flutter_task/model/database_helper.dart';

class CookingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      backgroundColor: Color(0xfff8f9ff),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff6c60e1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Cooking',
                    style: kTextStyle,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Labels',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.delete_outline_rounded,
                        size: 30,
                        color: Color(0xff6d65c3),
                      ),
                      Icon(
                        Icons.logout_outlined,
                        size: 30,
                        color: Color(0xff6d65c3),
                      ),
                      Icon(
                        Icons.import_export_outlined,
                        size: 30,
                        color: Color(0xff6d65c3),
                      )
                    ],
                  ),
                  FutureBuilder<List<Category>>(
                      future: DatabaseHelper.instance.getCategory(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Category>> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text('Loading...'));
                        }
                        return snapshot.data!.isEmpty
                            ? Center(child: Text('No Category in List.'))
                            : ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: snapshot.data!.map((category) {
                                  return Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.memory(
                                            base64Decode(category.picture),fit: BoxFit.cover,),
                                      ),
                                      title: Text(
                                        category.name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
