import 'package:adminpanel/screens/product_view/add_product/add_product.dart';
import 'package:adminpanel/screens/product_view/widgets/single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../models/product_model/product_model.dart';
import '../../provider/app_provider.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Products View"),
        actions: [
          IconButton(onPressed: (){
            Routes.instance.push(widget: AddProduct(), context: context);
          }, icon: Icon(Icons.add_circle))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Products",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
              SizedBox(height: 12.0,),
              GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: appProvider.getProducts.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.9,
                      crossAxisCount: 2),
                  itemBuilder: (ctx, index) {
                    ProductModel singleProduct =
                    appProvider.getProducts[index];
                    return SingleProductView(singleProduct: singleProduct,index: index,);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
