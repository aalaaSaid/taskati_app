import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/funcations/navigation.dart';
import '../../../core/services/local_storge.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_styles.dart';
import '../../profile/profile_screen.dart';
class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello , ${AppLocalStorage.getCachedDataOfUser('name')}!'
              ,style: getBodyTextStyle(
                context,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold
              ),)
            ,const Gap(5),
            Text('Have a nice day.',style: getSmallTextStyle(context,),)

          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: (){
            navigateTo(context, const ProfileScreen()).then((value){
              setState(() {});
            });

          },
          child: Stack(
            alignment: Alignment.bottomRight,
            children:[
              CircleAvatar(
              radius: 30,
              backgroundImage: AppLocalStorage.getCachedDataOfUser('image')!=null?
              FileImage(File(AppLocalStorage.getCachedDataOfUser('image')))
                  :const AssetImage('assets/images/user.jpg'),
            ),
              CircleAvatar(
                radius: 12,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child:const Icon(Icons.edit,color: AppColors.primaryColor,
                size: 15,
                ) ,
              ),
          ]),
        ),
      ],
    );
  }
}
