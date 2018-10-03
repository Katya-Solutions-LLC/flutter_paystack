import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/src/model/card.dart';
import 'package:flutter_paystack/src/common/my_strings.dart';

import 'package:flutter_paystack/src/ui/widgets/input/base_field.dart';

class CVCField extends BaseTextField {
  CVCField(
      {@required PaymentCard card, @required FormFieldSetter<String> onSaved})
      : super(
          labelText: 'CVV',
          hintText: '123',
          onSaved: onSaved,
          validator: (String value) => validateCVC(value, card),
          initialValue:
              card != null && card.cvc != null ? card.cvc.toString() : null,
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            new LengthLimitingTextInputFormatter(4),
          ],
        );

  static String validateCVC(String value, PaymentCard card) {
    if (value == null || value.trim().isEmpty) return Strings.invalidCVC;

    return card.validCVC(value) ? null : Strings.invalidCVC;
  }

  @override
  createState() {
    return super.createState();
  }
}
