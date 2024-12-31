import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/models/task_model.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_styles.dart';
class TaskItem extends StatelessWidget {
  const TaskItem({super.key,required this.tasks});
  final TaskModel tasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, right: 8, left: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: tasks.selectedColor==0?
        AppColors.orangeColor:tasks.selectedColor==1?
        AppColors.blueColor:tasks.selectedColor==2?
        AppColors.primaryColor:Colors.greenAccent,
      ),
      child:Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tasks.title??'',style: getBodyTextStyle(context,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),),
                  const Gap(10),
                  Row(
                    children: [
                      const Icon(Icons.watch_later_outlined,color: AppColors.whiteColor,),
                      const Gap(10),
                      Text('${tasks.startTime} to ${tasks.endTime}',style: getBodyTextStyle(
                        context,color: AppColors.whiteColor,
                      ))
                    ],
                  ),
                  const Gap(10),
                  Text(tasks.desc??'',style: getSmallTextStyle(
                    context,color: AppColors.whiteColor,
                  ),),
                ],
              )),
          Container(width: .5, height: 65, color: AppColors.whiteColor),
          const Gap(10),
          RotatedBox(
            quarterTurns: 3,
            child: Text(tasks.isCompleted==true?
            'Done':'ToDo',style: getSmallTextStyle(
              context,color: AppColors.whiteColor,
            )),
          )
        ],
      ),
    );
  }
}
