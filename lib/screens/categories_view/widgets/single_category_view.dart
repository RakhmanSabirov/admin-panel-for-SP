import 'package:adminpanel/models/category_model/category_model.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:adminpanel/screens/categories_view/edit_category/edit_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/routes.dart';

class SingleCategoryView extends StatefulWidget {
  final CategoryModel singleCategory;
  final int index;
  const SingleCategoryView({Key? key,required this.singleCategory,required this.index}) : super(key: key);

  @override
  State<SingleCategoryView> createState() => _SingleCategoryViewState();
}

class _SingleCategoryViewState extends State<SingleCategoryView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Card(
      color: Colors.white,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              child: Image.network(widget.singleCategory.image,scale: 8,),
            ),
          ),
          Positioned(
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children:  [
                  IgnorePointer(
                    ignoring: isLoading,
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await appProvider.deleteCategoryFromFirebase(widget.singleCategory);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child:isLoading?Center(child: CircularProgressIndicator(),) :const Icon(Icons.delete,color: Colors.red,),
                    ),
                  ),
                  const SizedBox(width: 12.0,),
                  GestureDetector(
                    onTap: (){
                      Routes.instance.push(widget: EditCategory(categoryModel: widget.singleCategory, index: widget.index), context: context);
                    },
                    child: Icon(Icons.edit),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
