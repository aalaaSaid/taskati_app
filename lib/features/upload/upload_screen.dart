import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/funcations/dialog.dart';
import 'package:taskati/core/services/local_storge.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/custom_button.dart';

import '../../core/funcations/navigation.dart';
import '../home/screens/home_screen.dart';
class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final nameController = TextEditingController();
  String? path;
  //upload image from gallery
  uploadImageFromGallery() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value){
     setState(() {
       if(value!=null) {
         path = value.path;
       }
     });
   });
  }
  //upload image from camera
  uploadImageFromCamera()  {
    ImagePicker().pickImage(source: ImageSource.camera).then((value){
      setState(() {
        if(value!=null) {
          path = value.path;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
          if(path != null && nameController.text.isNotEmpty) {
            AppLocalStorage.cacheDataOfUser('name', nameController.text);
            AppLocalStorage.cacheDataOfUser('image', path);
            AppLocalStorage.cacheDataOfUser('isUploaded', true);
            navigateWithReplacement(context, const HomeScreen());

          }else if (path != null && nameController.text.isEmpty){
            showErrorDialog(context, 'Please enter your name');
          }else if (path == null && nameController.text.isNotEmpty){
            showErrorDialog(context, 'Please upload your image');
          }else {
            showErrorDialog(context, 'Please upload your image and enter your name');
          }
        },
            child: Text('Done',style:getTitleTextStyle(context,color: AppColors.whiteColor) ,))],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 71,
                  child: CircleAvatar(
                    backgroundImage: path!=null?
                        FileImage(File(path!)) as ImageProvider
                        :const AssetImage('assets/images/user.jpg'),
                    radius:70,
                  ),
                ),
                const Gap(20),
                CustomButton(
                    text: 'Upload image from gallery',
                    width: 280,
                    onPressed: uploadImageFromGallery),
                const Gap(10),
                CustomButton(
                    text: 'Upload image from camera',
                    width: 280,
                    onPressed:uploadImageFromCamera),
                const Gap(20),
                const Divider(),
                const Gap(20),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
