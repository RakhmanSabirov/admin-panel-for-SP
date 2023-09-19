
import 'package:adminpanel/models/category_model/category_model.dart';
import 'package:adminpanel/models/user_model/user_model.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:adminpanel/screens/add_category/add_category.dart';
import 'package:adminpanel/screens/categories_view/edit_category/edit_category.dart';
import 'package:adminpanel/screens/categories_view/widgets/single_category_view.dart';
import 'package:adminpanel/screens/user_view/widgets/single_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories View"),
          actions: [
          IconButton(onPressed: (){
            Routes.instance.push(widget: AddCategory(), context: context);
          }, icon: Icon(Icons.add_circle))
    ],
      ),
      body: Consumer<AppProvider>(
          builder: (context,value,child) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Categories",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                    SizedBox(height: 12.0,),
                    GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: value.getCategoriesList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2
                        ),
                        padding: const EdgeInsets.all(12.0),
                        itemBuilder: (context,index) {
                          CategoryModel categoryModel = value.getCategoriesList[index];
                          return SingleCategoryView(singleCategory: categoryModel,index: index,);
                        }
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
