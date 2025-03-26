import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pursenal/app/global/dimensions.dart';
import 'package:pursenal/app/extensions/currency.dart';
import 'package:pursenal/core/enums/currency.dart';
import 'package:pursenal/widgets/shared/calculator_keyboard.dart';

class CalculatedField extends StatelessWidget {
  const CalculatedField(
      {super.key,
      this.amount,
      required this.onChanged,
      required this.label,
      this.errorText,
      this.autoFocus = false,
      this.textStyle,
      this.isDisabled = false,
      required this.currency,
      this.helperText});
  final double? amount;
  final Function(double?) onChanged;
  final String label;
  final String? errorText;
  final bool autoFocus;
  final TextStyle? textStyle;
  final bool isDisabled;
  final Currency currency;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    final isMobile = Platform.isAndroid || Platform.isIOS;
    if (!isMobile) {
      return TextFormField(
        style: textStyle,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.end,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
              RegExp(r'^\d*\.?\d*')), // Allows only numbers and one decimal
        ],
        decoration: InputDecoration(
            helperText: helperText,
            helperMaxLines: 2,
            labelText: label,
            errorText: errorText,
            prefix: Text(currency.symbol)),
        initialValue:
            amount?.toStringAsFixed(countDecimalPlaces(currency.format)),
        onChanged: (value) {
          var doubleValue = double.tryParse(value);
          if (doubleValue != null) {
            doubleValue = roundToFormat(doubleValue, currency.format);
          }
          onChanged(doubleValue);
        },
        autofocus: autoFocus,
        enabled: !isDisabled,
      );
    }

    return TextFormField(
      style: textStyle,
      textAlign: TextAlign.end,
      decoration: InputDecoration(
          helperText: helperText,
          helperMaxLines: 2,
          labelText: label,
          errorText: errorText,
          prefix: Text(currency.symbol)),
      controller:
          TextEditingController(text: (amount ?? 0).toCurrencyString(currency)),
      onChanged: (value) {
        onChanged(double.tryParse(value));
      },
      autofocus: autoFocus,
      readOnly: isMobile,
      enabled: !isDisabled,
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          constraints: const BoxConstraints(maxWidth: smallWidth),
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: CalculatorKeyBoard(
                  onChanged: (p0) => onChanged(p0),
                  amount: amount,
                  dismissFn: () {
                    Navigator.pop(context);
                  },
                  currency: currency,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

int countDecimalPlaces(String format) {
  final parts = format.split('.');
  if (parts.length < 2) return 0; // No decimal point means 0 decimal places
  return parts[1].replaceAll(RegExp(r'[^0#]'), '').length;
}

double roundToFormat(double number, String format) {
  int decimalPlaces = countDecimalPlaces(format);
  double factor = pow(10, decimalPlaces).toDouble();
  return (number * factor).roundToDouble() / factor;
}
