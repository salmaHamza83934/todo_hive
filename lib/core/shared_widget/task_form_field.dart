import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskFormField extends StatelessWidget {
  String fieldName;
  TextEditingController controller;
  IconData icon;
  String hintTxt;
  TaskFormField({required this.fieldName, required this.controller,required this.icon, this.hintTxt=''});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldName,
          style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black),
        ),
        SizedBox(
          height: 15.h,
        ),
        TextFormField(
          maxLength: 20,
          maxLines: 1,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty && value.trim().isEmpty) {
              return 'Field must not empty!';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            hintText: hintTxt,
              hintStyle: TextStyle(fontSize: 20.sp),
              prefixIcon: Icon(
                icon,
                color: Colors.deepPurple,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.deepPurple, width: 2.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.red[900]!, width: 2.5),
              ),focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(color: Colors.red[900]!, width: 2.5),
    )),
        ),
      ],
    );
  }
}
