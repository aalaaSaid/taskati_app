import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/funcations/navigation.dart';
import 'package:taskati/core/services/local_storge.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/features/home/screens/home_screen.dart';

import '../../core/models/task_model.dart';
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  int selectedColor=0 ;
  bool isDark = AppLocalStorage.getCachedDataOfUser('isDark')??false;
  String date =DateFormat.yMd().format(DateTime.now());
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(hours: 12)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios_new,)),
        title:  Text('Add Task',
          style: getTitleTextStyle(
            context,
            color: AppColors.whiteColor
          ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //title
                Text('Title',style: getBodyTextStyle(
                  context,fontWeight: FontWeight.w500
                ),),
                const Gap(10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: titleController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter title';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter title of task',
                  )
                ),
                const Gap(20),
                //note
                Text('Note',style: getBodyTextStyle(
                    context,fontWeight: FontWeight.w500
                ),),
                const Gap(10),
                TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLines: 2,
                    controller: noteController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter Note';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter note here',
                      //hintStyle: getBodyTextStyle(context),
                    )
                ),
                const Gap(20),
                //date
                Text('Date',style: getBodyTextStyle(context,
                    fontWeight: FontWeight.w500
                ),),
                const Gap(10),
                TextFormField(
                  style: getBodyTextStyle(context,fontWeight: FontWeight.normal),
                  onTap: (){
                    showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: DateTime.now(),
                        builder: (context, child) {
                           return Theme(
                            data:Theme.of(context).copyWith(
                              colorScheme: isDark?const ColorScheme.dark(
                                primary: AppColors.primaryColor, // Header background color
                                onPrimary: Colors.white, // Header text color
                                surface: Colors.black, // Background color
                                onSurface: Colors.white, // Text color
                              ):const ColorScheme.light(
                                primary: AppColors.primaryColor, // Header background color
                                onPrimary: Colors.white, // Header text color
                                surface: Colors.white, // Background color
                                onSurface: Colors.black, // Text color

                              ),
                            ),
                            child: child!,
                          );
                        },
                        lastDate: DateTime.now().
                        add(const Duration(days: 100))).then((value){
                          setState(() {
                            if(value != null){
                              date = DateFormat.yMd().format(value);
                            }
                          });
                    },);
                  },
                    readOnly: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: date,
                      suffixIcon: const Icon(Icons.calendar_month,
                        color: AppColors.primaryColor,),
                    ),
                ),
                const Gap(20),
                //time
                Row(
                 children: [
                   Expanded(
                       child: Text('Start Time',
                           style: getBodyTextStyle(context)
                       ),),
                   const Gap(10),
                   Expanded(
                     child: Text('End Time',
                         style: getBodyTextStyle(context)
                     ),),

                 ],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                        child:TextFormField(
                          onTap: (){
                            showTimePicker(
                                context: context,
                              builder: (context, child) {
                                //bool isDark = AppLocalStorage.getCachedDataOfUser('isDark');
                                return Theme(
                                  data:Theme.of(context).copyWith(
                                    colorScheme: isDark?const ColorScheme.dark(
                                      primary: AppColors.primaryColor, // Header background color
                                      onPrimary: Colors.white, // Header text color
                                      surface: Colors.black, // Background color
                                      onSurface: Colors.white, // Text color
                                    ):const ColorScheme.light(
                                      primary: AppColors.primaryColor, // Header background color
                                      onPrimary: Colors.white, // Header text color
                                      surface: Colors.white, // Background color
                                      onSurface: Colors.black, // Text color

                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                                initialTime: TimeOfDay.now(),
                            ).then((value){
                              if(value!=null){
                                setState(() {
                                  startTime = value.format(context);
                                });
                              }
                            });
                          },
                          style: getBodyTextStyle(context,fontWeight: FontWeight.normal),
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: startTime,
                            suffixIcon: const Icon(Icons.watch_later_outlined,
                            color: AppColors.primaryColor,
                            )
                          ),
                        ) ),
                    const Gap(10),
                    Expanded(
                        child:TextFormField(
                          onTap: (){
                            showTimePicker(
                              context: context,
                              builder: (context, child) {
                               // bool isDark = AppLocalStorage.getCachedDataOfUser('isDark');
                                return Theme(
                                  data:Theme.of(context).copyWith(
                                    colorScheme: isDark?const ColorScheme.dark(
                                      primary: AppColors.primaryColor, // Header background color
                                      onPrimary: Colors.white, // Header text color
                                      surface: Colors.black, // Background color
                                      onSurface: Colors.white, // Text color
                                    ):const ColorScheme.light(
                                      primary: AppColors.primaryColor, // Header background color
                                      onPrimary: Colors.white, // Header text color
                                      surface: Colors.white, // Background color
                                      onSurface: Colors.black, // Text color

                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                              initialTime: TimeOfDay.now(),
                            ).then((value){
                              if(value!=null){
                                setState(() {
                                  endTime = value.format(context);
                                });
                              }
                            });
                          },
                          style: getBodyTextStyle(context,fontWeight: FontWeight.normal),
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: endTime,
                              suffixIcon: const Icon(Icons.watch_later_outlined,
                                color: AppColors.primaryColor,
                              )
                          ),
                        ) ),
                  ],
                ),
                const Gap(20),
                Text('Color',style: getBodyTextStyle(context),),
                const Gap(10),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          selectedColor=0;
                        });
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.orangeColor,
                        child:selectedColor==0? const Icon(Icons.done,
                          color: AppColors.whiteColor,):const SizedBox(),
                      ),
                    ),
                    const Gap(5),
                    InkWell(
                     onTap: (){
                       setState(() {
                         selectedColor=1;
                       });
                     },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.blueColor,
                        child:selectedColor==1? const Icon(Icons.done,
                          color: AppColors.whiteColor,):const SizedBox(),
                      ),
                    ),
                    const Gap(5),
                    InkWell(
                      onTap: (){
                        setState(() {
                          selectedColor=2;
                        });
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primaryColor,
                        child:selectedColor==2? const Icon(Icons.done,
                          color: AppColors.whiteColor,):const SizedBox(),
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      width: 150,
                      text: 'Create Task', onPressed: (){
                        if(formKey.currentState!.validate()) {
                          var id = DateTime.now().toIso8601String();
                          AppLocalStorage.cacheDataOfTasks(id,
                          TaskModel(
                            id: id,
                            title: titleController.text,
                            desc: noteController.text,
                            date: date,
                            startTime: startTime,
                            endTime: endTime,
                            selectedColor: selectedColor,
                            isCompleted: false
                          ),
                          );
                          navigateWithReplacement(context, const HomeScreen());
                        }
                    },)
                  ],
                ),



              ],

            ),
          ),
        ),
      ),
    );
  }
}
