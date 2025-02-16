import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoneyInputController extends TextEditingController {
  final NumberFormat currencyFormatter = NumberFormat('#,##0', 'vi_VN');

  MoneyInputController() {
    addListener(() {
      final text = this.text.replaceAll(',', '');
      if (text.isNotEmpty) {
        final formattedText = currencyFormatter.format(int.parse(text));
        this.value = this.value.copyWith(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }
    });
  }
}
