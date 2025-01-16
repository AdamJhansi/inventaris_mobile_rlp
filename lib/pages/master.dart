import 'package:flutter/material.dart';
import 'package:inventaris_mobile/pages/list_barang.dart';

import '../components/animated_bar.dart';
import 'dashboard.dart';
import 'notes.dart';

final Color? bottonNavBgColor = Colors.blueGrey[400];

class MasterPage extends StatefulWidget {
  const MasterPage({super.key});

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  int selectedNavIndex = 1;
  final List<Widget> pages = [
    NoteListScreen(),
    DashboardPage(),
    ListBarangPage(),
  ];
  final List<IconData> icons = [
    Icons.edit_note,
    Icons.home,
    Icons.inventory,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      pages[selectedNavIndex],
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.fromLTRB(60, 0, 60, 20),
            decoration: BoxDecoration(
              color: bottonNavBgColor?.withOpacity(0.8),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: bottonNavBgColor!.withOpacity(0.3),
                  offset: const Offset(0, 20),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                icons.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedNavIndex = index;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBar(isActive: selectedNavIndex == index),
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: Opacity(
                            opacity: 0.5,
                            child: Icon(
                              icons[index],
                              size: 28,
                              color: selectedNavIndex == index ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
