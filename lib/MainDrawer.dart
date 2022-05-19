import 'package:flutter/material.dart';


class MainDrawer extends StatefulWidget {
  const MainDrawer({ Key? key }) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [
      
          Text("testing data")
    ]),);
  }
}