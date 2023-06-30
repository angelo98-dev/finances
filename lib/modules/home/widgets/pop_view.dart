import 'package:finances/core/theme/color.dart';
import 'package:finances/core/theme/text.dart';
import 'package:finances/data/entities/envelop.dart';
import 'package:finances/modules/home/widgets/app_gesture_builder.dart';
import 'package:finances/modules/home/widgets/edit_name_bottom_sheet.dart';
import 'package:finances/modules/home/widgets/envelop_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class EnvelopPopupView extends ConsumerWidget {
  const EnvelopPopupView({
    Key? key,
    required this.envelop,
    required this.onDelete,
  }) : super(key: key);

  final Envelop envelop;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appColorThemeProvider);

    return Container(
      color: colors.surface,
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _EditButton(
            envelop: envelop,
          ),
          const Gap(10),
          _DeleteButton(
            envelop: envelop,
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }
}

class _EditButton extends ConsumerWidget {
  const _EditButton({
    Key? key,
    required this.envelop,
  }) : super(key: key);

  final Envelop envelop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appColorThemeProvider);

    return _SettingButton(
      text: 'Edit the Title',
      textColor: colors.primary,
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: EditNameBottomSheet(
            envelop: envelop,
          ),
        ),
      ),
    );
  }
}

class _DeleteButton extends ConsumerWidget {
  const _DeleteButton({
    Key? key,
    required this.envelop,
    required this.onDelete,
  }) : super(key: key);
  final Envelop envelop;

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appColorThemeProvider);

    return _SettingButton(
      text: 'Delete the  Envelop',
      textColor: colors.primaryVariant,
      onTap: onDelete,
    );
  }
}

class _SettingButton extends ConsumerWidget {
  const _SettingButton({
    Key? key,
    required this.text,
    this.textColor,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final Color? textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = ref.watch(textThemeProvider);
    final style = styles.caption.surface;

    return AppGestureBuilder(
      onTap: () {
        ref.read(callBackProvider).call();
        Navigator.of(context).pop();
        onTap.call();
      },
      child: Text(
        text,
        style: textColor != null ? style.copyWith(color: textColor) : style,
      ),
    );
  }
}
