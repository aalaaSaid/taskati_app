import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local_storge.dart';
import 'package:taskati/features/home/widgets/home_header.dart';
import 'package:taskati/features/home/widgets/task_item.dart';
import 'package:taskati/features/home/widgets/today_header.dart';
import 'package:taskati/core/utils/colors.dart';

import '../../../core/utils/text_styles.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const HomeHeader(),
              const Gap(20),
              const TodayHeader(),
              const Gap(10),
              DatePicker(
                monthTextStyle: getBodyTextStyle(context),
                dateTextStyle: getBodyTextStyle(context),
                dayTextStyle: getBodyTextStyle(context),
                height: 100,
                width: 70,
                DateTime.now().subtract(const Duration(days: 2)),
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.primaryColor,
                selectedTextColor: AppColors.whiteColor,
                onDateChange: (date) => setState(() {
                    selectedDate = DateFormat('dd-MM-yyyy').format(date) ;
                  }),
              ),
              const Gap(20),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: AppLocalStorage.tasksBox.listenable(),
                 builder: (context,value,child){
                    List<TaskModel> tasks = [];
                   for(var task in value.values){
                     if(selectedDate == task.date){
                       tasks.add(task);
                     }
                   }
                  /* tasks.sort((a,b){
                     String A= a.startTime!.trim();
                     String B= b.startTime!.trim();
                     DateTime timeA= DateFormat.jm().parse(A);
                     DateTime timeB= DateFormat.jm().parse(B);
                     return timeA.compareTo(timeB);
                   });*/
                   if(tasks.isEmpty){
                     return Center(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Lottie.asset('assets/images/empty.json', height: 200, width: 200),
                            const Gap(30),
                           Text('No Tasks for Today.',
                               style: getBodyTextStyle( context,fontSize: 24,
                               color: AppColors.primaryColor,
                               )),
                         ],
                       ),

                     );
                   }
                    return ListView.builder(
                        itemBuilder: (context, index) =>
                            Dismissible(
                                key: UniqueKey(),
                                background: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.greenColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.check, color: Colors.white),
                                        const Gap(10),
                                        Text('Complete Task',
                                            style: getBodyTextStyle(
                                                context,color: Colors.white)),
                                      ],
                                    ),
                                ),
                                secondaryBackground:  Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.redColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(Icons.delete, color: Colors.white),
                                      const Gap(10),
                                      Text('Delete Task',
                                          style: getBodyTextStyle(
                                              context,color: Colors.white)),
                                    ],
                                  ),
                                ),
                                onDismissed: (direction) {
                                  if(direction ==DismissDirection.endToStart){
                                    value.delete(tasks[index].id);
                                  }else{
                                    value.put(tasks[index].id, TaskModel(
                                      id: tasks[index].id,
                                      title: tasks[index].title,
                                      desc: tasks[index].desc,
                                      startTime: tasks[index].startTime,
                                      endTime: tasks[index].endTime,
                                      selectedColor: 3,
                                      date: tasks[index].date,
                                      isCompleted: true
                                    ));

                                  }
                                },
                                child: TaskItem(tasks: tasks[index])),
                        itemCount: tasks.length);
                 },

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
