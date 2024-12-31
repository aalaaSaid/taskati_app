import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/funcations/navigation.dart';
import 'package:taskati/core/services/local_storge.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/home/screens/home_screen.dart';
import 'package:taskati/features/upload/upload_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5),(){
    bool isUploaded = AppLocalStorage.getCachedDataOfUser('isUploaded') ?? false;
     if(isUploaded){
       navigateWithReplacement(context,const HomeScreen());
     }else{
       navigateWithReplacement(context, const UploadScreen());
     }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/logo.json', height: 200, width: 200),
            Text('Taskati', style: getTitleTextStyle(context, fontSize: 24)),
            const Gap(16),
            Text('It\'s a time to be productive', style: getSmallTextStyle(context,))
          ],
        ),
      ),

    );
  }
}
