import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:han_bab/controller/order_time_button_controller.dart';

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = this.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}

class OrderTimeButton extends GetView<OrderTimeButtonController> {
  const OrderTimeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    // TODO: implement build
    Future<void> _show() async {
      final TimeOfDay? result =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (result != null) {
        if (!mounted) return;
        controller.setOrderTime(result.to24hours());
      }
    }

    return Obx(() => OutlinedButton(
          onPressed: _show,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            controller.orderTime.value,
            style: const TextStyle(color: Colors.grey),
          ),
        ));
  }
}

// order time 하느중
