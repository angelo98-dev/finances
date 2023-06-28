import 'package:finances/core/theme/text.dart';
import 'package:finances/data/entities/envelop.dart';
import 'package:finances/data/repositories/envelop.dart';
import 'package:finances/widgets/app_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

final _amountProvider = StateProvider.autoDispose<double>((ref) => 0);
final _switchValue = StateProvider.autoDispose<bool>((ref) => false);

final envelopUpdateProvider =
    FutureProvider.autoDispose.family((ref, Envelop envelop) async {
  final envelopRepo = ref.watch(envelopRepositoryProvider);
  final amount = ref.watch(_amountProvider);
  final switchValue = ref.watch(_switchValue);

  return envelopRepo.updateEnvelop(
    envelop: envelop,
    amount: amount,
    add: switchValue,
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
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountControler.dispose();
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
            child: AppFormField(
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
          ),
          const Gap(15),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                final amount = double.parse(_amountControler.text);

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
              'Update',
            ),
          ),
          const Gap(50)
        ],
      ),
    );
  }
}
