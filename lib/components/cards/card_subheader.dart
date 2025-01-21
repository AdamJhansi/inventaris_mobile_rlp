import 'package:flutter/material.dart';
import 'package:inventaris_mobile/components/text_styles.dart';

Widget CardSubHeader() {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/baju.jpg',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              Container(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(height: 5),
                    Text(
                      "Cards Title 1",
                      style: AppTextStyles.title(color: Colors.blueGrey),
                    ),
                    Container(height: 5),
                    Text(
                      "Sub title",
                      style: AppTextStyles.subtitle(color: Colors.blueGrey),
                    ),
                    Container(height: 10),
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
