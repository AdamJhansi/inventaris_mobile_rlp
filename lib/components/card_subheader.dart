import 'package:flutter/material.dart';
import 'package:inventaris_mobile/components/text_styles.dart';

Widget CardSubHeader() {
  return Card(
    // Define the shape of the card
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    // Define how the card's content should be clipped
    clipBehavior: Clip.antiAliasWithSaveLayer,
    // Define the child widget of the card
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Add padding around the row widget
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Add an image widget to display an image
              Image.asset(
                'assets/baju.jpg',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              // Add some spacing between the image and the text
              Container(width: 20),
              // Add an expanded widget to take up the remaining horizontal space
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Add some spacing between the top of the card and the title
                    Container(height: 5),
                    // Add a title widget
                    Text(
                      "Cards Title 1",
                      style: AppTextStyles.title(color: Colors.blueGrey),
                    ),
                    // Add some spacing between the title and the subtitle
                    Container(height: 5),
                    // Add a subtitle widget
                    Text(
                      "Sub title",
                      style: AppTextStyles.subtitle(color: Colors.blueGrey),
                    ),
                    // Add some spacing between the subtitle and the text
                    Container(height: 10),
                    // Add a text widget to display some text
                    Text(
                      "MyStringsSample.card_text",
                      maxLines: 2,
                      style: AppTextStyles.regular(color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
