import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/services/local_storge.dart';
import 'package:taskati/core/utils/colors.dart';

import '../../../core/utils/text_styles.dart';
import '../../../core/widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  uploadFromCamera() {
    ImagePicker().pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        setState(() {
          AppLocalStorage.cacheDataOfUser('image', value.path);
        });
      }
    });
  }

  uploadFromGallery() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        setState(() {
          AppLocalStorage.cacheDataOfUser('image', value.path);
        });
      }
    });
  }
  //show image bottom sheet
  showImageBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 3,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppColors.greyColor,
                      borderRadius: BorderRadius.circular(5)),
                ),
                const Gap(20),
                CustomButton(
                    text: 'Upload From Camera',
                    onPressed: () {
                      uploadFromCamera();
                      Navigator.pop(context);
                    }),
                const Gap(15),
                CustomButton(
                    text: 'Upload From Gallery',
                    onPressed: () {
                      uploadFromGallery();
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }
  //show name bottom sheet
  showNameBottomSheet(BuildContext context){
    final nameController= TextEditingController(
        text: AppLocalStorage.getCachedDataOfUser('name'));
    final formKey=GlobalKey<FormState>();
    return showModalBottomSheet(
        context: context,
        builder:(context){
          return Padding(
            padding:MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 3,
                        width: 50,
                        decoration: BoxDecoration(
                            color: AppColors.greyColor,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      const Gap(10),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please enter your name';
                          }
                          return null;
                        },
                  
                      ),
                      const Gap(15),
                      CustomButton(
                          text: 'Update Name',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AppLocalStorage.cacheDataOfUser(
                                  'name', nameController.text);
                              setState(() {
                                Navigator.pop(context);
                              });
                            }
                          }),
                      Gap(30),
                  
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            bool isDark = AppLocalStorage.getCachedDataOfUser('isDark')??false;
            if(isDark){
              AppLocalStorage.cacheDataOfUser('isDark', false);
            }else{
              AppLocalStorage.cacheDataOfUser('isDark', true);
            }
            setState(() {});
          }, icon: const Icon(Icons.brightness_4_outlined)),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:
                    AppLocalStorage.getCachedDataOfUser('image') != null
                        ? FileImage(
                        File(AppLocalStorage.getCachedDataOfUser('image')))
                        : const AssetImage('assets/images/user.jpg'),
                  ),
                  GestureDetector(
                    onTap: () {
                      showImageBottomSheet(context);
                    },
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: const Icon(
                          Icons.camera_alt,
                          color: AppColors.primaryColor,
                          size: 20,
                        )),
                  ),
                ],
              ),
              const Gap(30),
              const Divider(),
              const Gap(30),
              Row(
                children: [
                  Text(
                    '${AppLocalStorage.getCachedDataOfUser('name')}',
                    style: getBodyTextStyle(
                        context,color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        showNameBottomSheet(context);
                        //Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.primaryColor,
                        size: 28,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
}
