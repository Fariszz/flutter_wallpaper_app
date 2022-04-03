import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/views/categorie.dart';
import 'package:flutter_wallpaper_app/widgets/widgets.dart';

import '../data/data.dart';
import '../model/categories_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

TextEditingController searchController = new TextEditingController();
ScrollController _scrollController = new ScrollController();

class _HomeState extends State<Home> {
  List<CategorieModel> categories = [];

  getTrendingWallpaper() async {
    await http.get(
        "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1",
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }

  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xfff5f8fd),
            borderRadius: BorderRadius.circular(30),
          ),
          margin: EdgeInsets.symmetric(horizontal: 24),
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    hintText: "search wallpapers", border: InputBorder.none),
              )),
              InkWell(
                  onTap: () {
                    if (searchController.text != "") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchView(
                                    search: searchController.text,
                                  )));
                    }
                  },
                  child: Container(child: Icon(Icons.search))),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      /// Create List Item tile
                      return CategoriesTile(
                        imgUrls: categories[index].imgUrl,
                        categorie: categories[index].categorieName,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
