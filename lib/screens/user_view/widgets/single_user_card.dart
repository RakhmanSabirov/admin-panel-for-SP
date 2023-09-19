
import 'package:adminpanel/constants/routes.dart';
import 'package:adminpanel/models/user_model/user_model.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:adminpanel/screens/user_view/edit_user/edit_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleCardUser extends StatefulWidget {
  final UserModel userModel;
  final int index;
  const SingleCardUser({Key? key,required this.userModel,required this.index }) : super(key: key);

  @override
  State<SingleCardUser> createState() => _SingleCardUserState();
}

class _SingleCardUserState extends State<SingleCardUser> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    bool isLoading = false;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            widget.userModel.image != null
                ? CircleAvatar(
            backgroundImage: NetworkImage(widget.userModel.image!),
      )
                : const CircleAvatar(
              child: Icon(Icons.person),
            ),
            const SizedBox(width: 12.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userModel.name),
                Text(widget.userModel.email)
              ],
            ),
            const Spacer(),
            isLoading?const CircularProgressIndicator()
                : GestureDetector(
                onTap: () async{
                  setState(() {
                    isLoading = true;
                  });
                  await appProvider.deleteUserFromFirebase(widget.userModel);
                  setState(() {
                    isLoading = true;
                  });
                }, child: Icon(Icons.delete,color: Colors.red,)
            ),
               const SizedBox(width: 6.0),
               GestureDetector(
                onTap: () async{
                  Routes.instance.push(widget: EditUser(index: widget.index,userModel: widget.userModel), context: context);
                }, child: Icon(Icons.edit,color: Colors.black,)
            )
          ],
        ),
      ),
    );
  }
}
