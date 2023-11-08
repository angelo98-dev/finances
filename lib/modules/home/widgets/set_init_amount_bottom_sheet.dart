import 'package:finances/core/theme/text.dart';
import 'package:finances/data/entities/freezed_entities/envelop_model/envelop_model.dart';
import 'package:finances/data/entities/freezed_entities/transaction_model/transaction_model.dart';
import 'package:finances/notifiers/notifier.dart';
import 'package:finances/widgets/app_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class SetInitAmountBottomSheet extends ConsumerStatefulWidget {
  const SetInitAmountBottomSheet({
    Key? key,
    required this.envelop,
  }) : super(key: key);

  final EnvelopModel envelop;

  @override
  SetInitAmountBottomSheetState createState() =>
      SetInitAmountBottomSheetState();
}

class SetInitAmountBottomSheetState
    extends ConsumerState<SetInitAmountBottomSheet> {
  final _amountControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _amountControler.text = widget.envelop.initAmount.toString();
  }

  @override
  void dispose() {
    _amountControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styles = ref.watch(textThemeProvider);

    return Padding(
      padding: const EdgeInsets.all(
        15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(15),
          Text(
            'Set Init Amount',
            style: styles.h4.primary,
          ),
          const Gap(15),
          Form(
            key: _formKey,
            child: AppFormField(
              label: 'Init Amount',
              obscureText: false,
              semanticLabel: 'Init Amount',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Must not be empty';
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
                final amount = double.parse(_amountControler.text);
                final envelop = widget.envelop;

                final transactions = [
                  ...envelop.transactions,
                  TransactionModel(
                    date: DateTime.now(),
                    isOutcome: false,
                    amount: amount,
                    label: 'Init Amount',
                  ),
                ];

                final updatedEnvelop = widget.envelop.copyWith(
                  initAmount: amount,
                  transactions: transactions,
                  currentAmount: amount,
                );

                ref.read(envelopsProvider.notifier).updateEnvelop(
                      envelop: updatedEnvelop,
                    );

                Navigator.pop(context);
              }
            },
            child: const Text(
              'Update',
            ),
          ),
          const Gap(50)
        ],
      ),
    );
  }
}
