import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TaskDateWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  DateTime? initialDate;
  TaskDateWidget({super.key, required this.onDateSelected,this.initialDate});

  @override
  State<TaskDateWidget> createState() => _TaskDateWidgetState();
}

class _TaskDateWidgetState extends State<TaskDateWidget> {
  DateTime? selectedDate;
  @override
  void initState() {
    selectedDate=widget.initialDate;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: 60.h,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Text(
            selectedDate==null?'Date':DateFormat('dd-MM-yyyy').format(selectedDate!),
            style: theme.textTheme.bodyMedium!
                .copyWith(color: Colors.grey),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async{
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2035, 1, 1),
                );
                if (selectedDate != null) {
                  widget.onDateSelected(selectedDate);
                  setState(() {
                    this.selectedDate = selectedDate;
                  });
                }

            },
            child: Container(
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: Text('Date',
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: Colors.black87)),
            ),
          ),
        ],
      ),
    );
  }
}
