import 'package:adminpanel/widgets/Single_order_widget/single_order_widget.dart';
import 'package:flutter/material.dart';

import '../../models/order_model/order_model.dart';

class OrderList extends StatelessWidget {
  final List<OrderModel> orderModelList;
  final String title;
  const OrderList({Key? key,required this.orderModelList,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title Order List"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: ListView.builder(
          itemCount: orderModelList.length,
          itemBuilder: (context,index){
            OrderModel orderModel = orderModelList[index];
            return SingleOrderWidget(orderModel: orderModel);
          },
        ),
      ),
    );
  }
}
