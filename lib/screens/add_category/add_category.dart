import 'dart:io';
import 'package:adminpanel/constants/constants.dart';
import 'package:adminpanel/helpers/firebase_storage_helper/firebase_storage.dart';
import 'package:adminpanel/models/category_model/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_provider.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key,});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
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
          "Add Category",
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
              hintText: "Category name",
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
            child: const Text("Add"),
            onPressed: () async {
              if(image == null && name.text.isEmpty){
                Navigator.of(context).pop();
              }
              else if(image != null && name.text.isNotEmpty){

                appProvider.addCategory(image!,name.text);
                showMessage("Successfully Added");
              }

            },
          ),
        ],
      ),
    );
  }
}
