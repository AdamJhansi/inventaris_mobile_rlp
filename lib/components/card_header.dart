import 'package:flutter/material.dart';

Widget CardHeader({
  required String imagePath,
  required String title,
  required String description,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    child: InkWell(
      onTap: onPressed,
      hoverColor: Colors.blueGrey,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              imagePath,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    ),
  );
}

///
/// HOW TO USE
///
/// CardHeader(
//   imagePath: 'assets/baju.jpg',
//   title: 'Cards Title 2',
//   description: 'MyStringsSample.card_text',
//   onSharePressed: () {
//     print('Share button pressed!');
//   },
//   onExplorePressed: () {
//     print('Explore button pressed!');
//   },
// );
