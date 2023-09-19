import 'dart:io';
import 'package:adminpanel/constants/constants.dart';
import 'package:adminpanel/helpers/firebase_storage_helper/firebase_storage.dart';
import 'package:adminpanel/models/user_model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_provider.dart';

class EditUser extends StatefulWidget {
  final UserModel userModel;
  final int index;
  const EditUser({super.key,required this.userModel,required this.index});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController cityEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image == null
              ? CupertinoButton(
            onPressed: () {
              takePicture();
            },
            child: const CircleAvatar(
                radius: 55, child: Icon(Icons.camera_alt)),
          )
              : CupertinoButton(
            onPressed: () {
              takePicture();
            },
            child: CircleAvatar(
              backgroundImage: FileImage(image!),
              radius: 55,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: name,
            decoration: InputDecoration(
              hintText: widget.userModel.name,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          const SizedBox(
            height: 16.0,
          ),
          const SizedBox(
            height: 16.0,
          ),
          const SizedBox(
            height: 16.0,
          ),
          const SizedBox(height: 16.0,),
          ElevatedButton(
            child: const Text("Update"),
            onPressed: () async {
              if(image == null && name.text.isEmpty){
                Navigator.of(context).pop();
              }
              else if(image != null){
                String imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(widget.userModel.id,image!);
                UserModel userModel = widget.userModel.copyWith(
                  image: imageUrl,
                  name: name.text.isEmpty?null:name.text,
                );
                appProvider.updateUserList(widget.index,userModel);
                showMessage("Update Successfully");
              }else{
                UserModel userModel = widget.userModel.copyWith(
                  name: name.text.isEmpty?null:name.text,

                );
                appProvider.updateUserList(widget.index,userModel);
                showMessage("Update Successfully");
              }

            },
          ),
        ],
      ),
    );
  }
}
