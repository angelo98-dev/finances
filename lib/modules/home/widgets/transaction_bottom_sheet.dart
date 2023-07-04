import 'package:finances/core/theme/text.dart';
import 'package:finances/data/entities/envelop/envelop.dart';
import 'package:finances/data/repositories/envelop.dart';
import 'package:finances/widgets/app_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

final _amountProvider = StateProvider.autoDispose<double>((ref) => 0);
final _labelProvider = StateProvider.autoDispose<String>((ref) => '');
final _switchValue = StateProvider.autoDispose<bool>((ref) => false);

final envelopUpdateProvider =
    FutureProvider.autoDispose.family((ref, Envelop envelop) async {
  final envelopRepo = ref.watch(envelopRepositoryProvider);
  final amount = ref.watch(_amountProvider);
  final label = ref.watch(_labelProvider);
  final add = ref.watch(_switchValue);

  final newAmount =
      add ? envelop.currentAmount + amount : envelop.currentAmount - amount;

  final initAmount = add ? envelop.initAmount + amount : envelop.initAmount;

  final updatedEnvelop = envelop.copyWith(
    currentAmount: newAmount,
    initAmount: initAmount,
  );

  return envelopRepo.updateEnvelop(
    envelop: updatedEnvelop,
  );
});

class TransactionBottomSheet extends ConsumerStatefulWidget {
  const TransactionBottomSheet({
    Key? key,
    required this.envelop,
  }) : super(key: key);

  final Envelop envelop;

  @override
  TransactionBottomSheetState createState() => TransactionBottomSheetState();
}

class TransactionBottomSheetState
    extends ConsumerState<TransactionBottomSheet> {
  final _amountControler = TextEditingController();
  final _labelControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountControler.dispose();
    _labelControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final switchValue = ref.watch(_switchValue);
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
            'Transaction',
            style: styles.h4.primary,
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Switch(
                  value: switchValue,
                  onChanged: (value) async =>
                      ref.read(_switchValue.notifier).update(
                            (state) => value,
                          ),
                ),
              ),
              const Gap(5),
              Text(
                switchValue ? 'Income' : 'Outcome',
                style: styles.subtitle.primary,
              ),
            ],
          ),
          const Gap(15),
          Form(
            key: _formKey,
            child: Column(
              children: [
                AppFormField(
                  label: switchValue ? 'Income' : 'Outcome',
                  obscureText: false,
                  semanticLabel: switchValue ? 'Income' : 'Outcome',
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
                const Gap(10),
                AppFormField(
                  label: 'Label',
                  obscureText: false,
                  semanticLabel: 'Label',
                  validator: (value) {
                    return null;
                  },
                  controller: _labelControler,
                  isPassword: false,
                  inputType: TextInputType.text,
                ),
              ],
            ),
          ),
          const Gap(15),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                final amount = double.parse(_amountControler.text);

                ref.read(_labelProvider.notifier).update(
                      (state) => _labelControler.text,
                    );

                ref.read(_amountProvider.notifier).update(
                      (state) => amount,
                    );
                ref.read(
                  envelopUpdateProvider(widget.envelop),
                );

                Navigator.pop(context);
              }
            },
            child: const Text(
              'Validate',
            ),
          ),
          const Gap(50)
        ],
      ),
    );
  }
}
