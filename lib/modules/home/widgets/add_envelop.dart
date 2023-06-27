import 'package:finances/data/repositories/envelop.dart';
import 'package:finances/widgets/app_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

final _titleProvider = StateProvider.autoDispose<String>((ref) => '');
final _initAmountProvider = StateProvider.autoDispose<double>((ref) => 0);

final _envelopCreateProvider = FutureProvider.autoDispose(
  (ref) async {
    final envelopRepo = ref.watch(envelopRepositoryProvider);
    final title = ref.watch(_titleProvider);
    final initAmount = ref.watch(_initAmountProvider);

    return envelopRepo.createEnvelop(
      title: title,
      initAmount: initAmount,
    );
  },
);

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
    return Padding(
      padding: const EdgeInsets.all(
        15,
      ),
      child: Column(
        children: [
          const Text(
            'Ajout Envelop',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(15),
          Form(
            key: _formKey,
            child: Column(
              children: [
                AppFormField(
                  label: 'Titre',
                  obscureText: false,
                  semanticLabel: 'Titre',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ne dois pas être vide';
                    }
                    return null;
                  },
                  controller: _title,
                  isPassword: false,
                  inputType: TextInputType.text,
                ),
                const Gap(15),
                AppFormField(
                  label: 'Montant initial',
                  obscureText: false,
                  semanticLabel: 'Montant initial',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ne dois pas être vide';
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

                ref.read(_titleProvider.notifier).update(
                      (state) => title,
                    );
                ref.read(_initAmountProvider.notifier).update(
                      (state) => amount,
                    );
                ref.read(_envelopCreateProvider);

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
