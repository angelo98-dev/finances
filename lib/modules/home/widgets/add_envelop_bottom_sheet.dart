import 'package:finances/core/theme/text.dart';
import 'package:finances/notifiers/notifier.dart';
import 'package:finances/widgets/app_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// final _titleProvider = StateProvider.autoDispose<String>((ref) => '');
// final _initAmountProvider = StateProvider.autoDispose<double>((ref) => 0);

// final _envelopCreateProvider = FutureProvider.autoDispose(
//   (ref) async {
//     final envelopRepo = ref.watch(envelopRepositoryProvider);
//     final title = ref.watch(_titleProvider);
//     final initAmount = ref.watch(_initAmountProvider);

//     return envelopRepo.createEnvelop(
//       title: title,
//       initAmount: initAmount,
//     );
//   },
// );

class AddEnvelopBottomSheet extends ConsumerStatefulWidget {
  const AddEnvelopBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  AddEnvelopBottomSheetState createState() => AddEnvelopBottomSheetState();
}

class AddEnvelopBottomSheetState extends ConsumerState<AddEnvelopBottomSheet> {
  final _title = TextEditingController();
  final _initAmount = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _title.dispose();
    _initAmount.dispose();
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
            'Create Envelope',
            style: styles.h4.primary,
          ),
          const Gap(15),
          Form(
            key: _formKey,
            child: Column(
              children: [
                AppFormField(
                  label: 'Title',
                  obscureText: false,
                  semanticLabel: 'Title',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Must not be empty';
                    }
                    return null;
                  },
                  controller: _title,
                  isPassword: false,
                ),
                const Gap(15),
                AppFormField(
                  label: 'Initial amount',
                  obscureText: false,
                  semanticLabel: 'Initial amount',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Must not be empty';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Not valid.';
                    }
                    return null;
                  },
                  controller: _initAmount,
                  isPassword: false,
                  inputType: TextInputType.number,
                ),
              ],
            ),
          ),
          const Gap(15),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                final title = _title.text;
                final amount = double.parse(_initAmount.text);

                ref.read(envelopsProvider.notifier).addEnvelop(
                      title: title,
                      initAmount: amount,
                    );

                Navigator.pop(context);
              }
            },
            child: const Text(
              'Create',
            ),
          ),
          const Gap(50),
        ],
      ),
    );
  }
}
