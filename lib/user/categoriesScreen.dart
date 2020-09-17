import 'package:flutter/material.dart';
import 'package:mansourarestaurants/models/category.dart';
import 'package:mansourarestaurants/models/category.dart';
import 'package:mansourarestaurants/widget/categoriesCard.dart';

import '../general.dart';
import 'searchScreen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Category category = Category();
  TextEditingController controller = TextEditingController();
  List<Category> categories = List();
  bool isLading = true;

  _getCategories() async {
    if (connected) {
      categories = await fetchCategoriesData();
      isLading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => SearchScreen(category: Category(categoryNameAR: '',categoryNameEN: ''),)));
              })
        ],
        backgroundColor: accentColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: isLading
            ? Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(logo)),
                  color: Colors.grey.withOpacity(.3),
                ),
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                child: myCircularProgressIndicator())
            : categories.isEmpty
                ? Container()
                : GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                    children: categories.map((Category category) {
                      return InkWell(onTap:(){
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (c) => SearchScreen(category:category)));
                      },child: CategoriesCard(category));
                    }).toList(),
                  ),
      ),
    );
  }
}
