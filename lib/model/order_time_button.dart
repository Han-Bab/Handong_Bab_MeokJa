import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:han_bab/controller/order_time_button_controller.dart';

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
        controller.setOrderTime(result.format(context));
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
