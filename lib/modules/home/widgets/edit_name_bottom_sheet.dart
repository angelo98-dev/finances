import 'package:finances/core/theme/text.dart';
import 'package:finances/data/entities/envelop.dart';
import 'package:finances/data/repositories/envelop.dart';
import 'package:finances/widgets/app_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

final _titleProvider = StateProvider.autoDispose<String>((ref) => '');

final envelopUpdateProvider =
    FutureProvider.autoDispose.family((ref, Envelop envelop) async {
  final envelopRepo = ref.watch(envelopRepositoryProvider);
  final title = ref.watch(_titleProvider);

  final updatedEnvelop = envelop.copyWith(
    title: title,
  );

  return envelopRepo.updateEnvelop(
    envelop: updatedEnvelop,
  );
});

class EditNameBottomSheet extends ConsumerStatefulWidget {
  const EditNameBottomSheet({
    Key? key,
    required this.envelop,
  }) : super(key: key);

  final Envelop envelop;

  @override
  EditNameBottomSheetState createState() => EditNameBottomSheetState();
}

class EditNameBottomSheetState extends ConsumerState<EditNameBottomSheet> {
  final _titleControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleControler.text = widget.envelop.title;
  }

  @override
  void dispose() {
    _titleControler.dispose();
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
            'Edit Title',
            style: styles.h4.primary,
          ),
          const Gap(15),
          Form(
            key: _formKey,
            child: AppFormField(
              label: 'Titre',
              obscureText: false,
              semanticLabel: 'Titre',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Must not be empty';
                }
                return null;
              },
              controller: _titleControler,
              isPassword: false,
              inputType: TextInputType.number,
            ),
          ),
          const Gap(15),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                ref.read(_titleProvider.notifier).update(
                      (state) => _titleControler.text,
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
