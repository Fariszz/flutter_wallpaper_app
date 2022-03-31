import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        centerTitle: true,
      ),
    );
  }
}