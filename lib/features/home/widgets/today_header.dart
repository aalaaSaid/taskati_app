import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../core/funcations/navigation.dart';
import '../../../core/utils/text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../add_task/add_task_screen.dart';
class TodayHeader extends StatelessWidget {
  const TodayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat.yMMMd().format(DateTime.now()),
              style:getBodyTextStyle(
                  context,fontWeight: FontWeight.bold
              ),),
            const Gap(5),
            Text('Today',style: getBodyTextStyle(
                context, fontWeight: FontWeight.bold
            ),)
          ],
        ),
        const Spacer(),
        CustomButton(text: '+Add Task',
            width: 140,
            onPressed: (){
              navigateTo(context, const AddTaskScreen());
            })
      ],
    );
  }
}
