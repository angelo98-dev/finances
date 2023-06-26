import 'package:finances/data/entities/envelop.dart';
import 'package:finances/widgets/app_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TransactionBottomSheet extends StatefulWidget {
  const TransactionBottomSheet({
    Key? key,
    required this.envelop,
  }) : super(key: key);

  final Envelop envelop;

  @override
  State<TransactionBottomSheet> createState() => _TransactionBottomSheetState();
}

class _TransactionBottomSheetState extends State<TransactionBottomSheet> {
  final _amountControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        15,
      ),
      child: Column(
        children: [
          const Text(
            'Transaction',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(15),
          Form(
            key: _formKey,
            child: AppFormField(
              label: 'Sortie',
              obscureText: false,
              semanticLabel: 'Sortie',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ne dois pas être vide';
                }
                return null;
              },
              controller: _amountControler,
              isPassword: false,
              inputType: TextInputType.number,
            ),
          ),
          const Gap(15),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                final currtentAmount = widget.envelop.currentAmount;
                final left = widget.envelop.currentAmount -
                    double.parse(_amountControler.text);

                print('DEBUGG :: $currtentAmount');
                print('DEBUGG (2) :: ${left}');
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Valider',
            ),
          ),
        ],
      ),
    );
  }
}
