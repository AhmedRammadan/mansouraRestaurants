import 'package:flutter/material.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/category.dart';

import '../general.dart';

class CategoriesCard extends StatelessWidget {
  Category category;

  CategoriesCard(this.category);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "$domainImages/category/${category.categoryImage}"),
                    fit: BoxFit.fill)),
          ),
          Flexible(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context).locale.languageCode == "en"
                    ? "${category.categoryNameEN.toLowerCase()}"
                    : "${category.categoryNameAR.toLowerCase()}",
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: textColor,
                    fontSize: 12
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
