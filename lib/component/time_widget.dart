import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';

import '../controller/order_time_button_controller.dart';

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = this.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}

class TimerWidget extends GetView<OrderTimeButtonController> {
  final format = DateFormat("HH:mm");

  var padding = 16.0;
  TimerWidget(this.padding, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        decoration: InputDecoration(
          hintText: '주문 예정 시간을 설정해주세요',
          icon: const Icon(Icons.alarm, color: Color(0xff717171),),
          hintStyle: Theme.of(context)
              .inputDecorationTheme
              .hintStyle,
          contentPadding: const EdgeInsets.all(16),
          fillColor: Colors.transparent,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: Color(0xffC2C2C2)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: Colors.black87),
          ),
        ),
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          if (time != null) {
            controller.setOrderTime(time.to24hours());
          }
          return DateTimeField.convert(time);
        },
        validator: (DateTime? selectedDateTime) {
          if (selectedDateTime != null) {
            // If the DateTime difference is negative,
            // this indicates that the selected DateTime is in the past
            var selected = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, selectedDateTime.hour, selectedDateTime.minute);
            if (selected.difference(DateTime.now()).isNegative) {
              return '이미 지난 시간입니다.';
            }
          } else {
            return '주문 예정 시간을 설정해주세요.';
          }
        },
        textInputAction: TextInputAction.next,
      ),
    ]);
  }
}
