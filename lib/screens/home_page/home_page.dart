
import 'package:adminpanel/constants/routes.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:adminpanel/screens/home_page/widgets/single_dash_item.dart';
import 'package:adminpanel/screens/order_list/order_list.dart';
import 'package:adminpanel/screens/product_view/product_view.dart';
import 'package:adminpanel/screens/user_view/user_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../categories_view/category_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  void getData() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context,listen: false);
    await appProvider.callBackFunction();
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("DashBoard"),
      ),
      body:isLoading
          ?Center(
              child: CircularProgressIndicator(),
          )
          : Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              CircleAvatar(
                radius: 30,
              ),
              SizedBox(height: 12.0,),
              Text(
                  "Sabirov Rakhman",
                  style: TextStyle(fontSize: 18),
              ),
              Text(
                "sabirov.rahman.02@mail.ru",
                style: TextStyle(fontSize: 18),
              ),
              GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 12.0),
                  crossAxisCount: 2,
                  children: [
                    SingleDashItem(
                        title: appProvider.getUserList.length.toString(), subtitle: "Users",
                        onPressed: () {
                          Routes.instance.push(widget: UserView(), context: context);
                        }
                    ),
                    SingleDashItem(
                        title: appProvider.getCategoriesList.length.toString(), subtitle: "Categories",
                        onPressed: () {
                          Routes.instance.push(widget: CategoriesView(), context: context);
                        }
                    ),
                    SingleDashItem(
                        title: appProvider.getProducts.length.toString(), subtitle: "Products",
                        onPressed: () {
                          Routes.instance.push(widget: ProductView(), context: context);
                        }
                    ),
                    SingleDashItem(
                        title: "\$${appProvider.getTotalEarning}", subtitle: "Earning",
                        onPressed: () {}
                    ),
                    SingleDashItem(
                        title: appProvider.getPendingOrderList.length.toString(), subtitle: "Pending order",
                        onPressed: () {
                          Routes.instance.push(widget: OrderList(title:"Pending",orderModelList: appProvider.getPendingOrderList), context: context);
                        }
                    ),
                    SingleDashItem(
                        title: appProvider.getDeliveryOrderList.length.toString(), subtitle: "Delivery order",
                        onPressed: () {
                          Routes.instance.push(widget: OrderList(title:"Delivery",orderModelList: appProvider.getDeliveryOrderList), context: context);
                        }
                    ),
                    SingleDashItem(
                        title: appProvider.getCancelOrderList.length.toString(), subtitle: "Cancel order",
                        onPressed: () {
                          Routes.instance.push(widget: OrderList(title:"Cancel",orderModelList: appProvider.getCancelOrderList), context: context);
                        }
                    ),
                    SingleDashItem(
                        title: appProvider.getCompletedOrderList.length.toString(), subtitle: "Completed order",
                        onPressed: () {
                          Routes.instance.push(widget: OrderList(title: "Completed",orderModelList: appProvider.getCompletedOrderList), context: context);
                        }
                    ),

                  ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

