import 'package:finances/data/entities/envelop/envelop.dart';
import 'package:finances/data/repositories/envelop.dart';
import 'package:finances/modules/home/widgets/app_gesture_builder.dart';
import 'package:finances/modules/home/widgets/contextual_blur.dart';
import 'package:finances/modules/home/widgets/envelop_item.dart';
import 'package:finances/modules/home/widgets/pop_view.dart';
import 'package:finances/modules/home/widgets/transaction_bottom_sheet.dart';
import 'package:finances/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popover/popover.dart';

Provider<VoidCallback> callBackProvider = Provider(
  (ref) => () {},
);

final envelopDeleteProvider =
    FutureProvider.autoDispose.family((ref, int id) async {
  final envelopRepo = ref.watch(envelopRepositoryProvider);

  return envelopRepo.deleteEnvelop(id);
});

class EnvelopTile extends StatelessWidget {
  const EnvelopTile({
    Key? key,
    required this.envelop,
  }) : super(key: key);

  final Envelop envelop;

  @override
  Widget build(BuildContext context) {
    return _EnvelopTileInnerView(
      envelop: envelop,
    );
  }
}

class _EnvelopTileInnerView extends ConsumerStatefulWidget {
  const _EnvelopTileInnerView({
    Key? key,
    required this.envelop,
  }) : super(key: key);

  final Envelop envelop;

  @override
  _EnvelopTileInnerViewState createState() => _EnvelopTileInnerViewState();
}

class _EnvelopTileInnerViewState extends ConsumerState<_EnvelopTileInnerView> {
  Future<void> _handleLongPress(BuildContext context) async {
    if (!mounted) {
      return;
    }

    final renderObject = context.findRenderObject();

    final blurScope = ContextualBlurScope.of(context);

    if (renderObject is RenderBox) {
      ContextualBlurScope.of(context).showBlur(
        offset: renderObject.localToGlobal(Offset.zero),
        size: renderObject.size,
        child: _DashboardTile(
          envelop: widget.envelop,
        ),
      );

      callBackProvider = Provider((ref) => () {
            return blurScope.hideBlur();
          });

      showPopover(
        context: context,
        bodyBuilder: (context) {
          return EnvelopPopupView(
            envelop: widget.envelop,
            onDelete: () {
              showDialog(
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: AppDialog(
                    title: 'Delete',
                    content: 'Are you sure you want to delete this envelope?',
                    primaryActionLabel: 'Cancel',
                    secondaryActionLabel: 'OK',
                    primaryActionCallback: () => Navigator.pop(context),
                    secondaryActionCallback: () {
                      ref.read(
                        envelopDeleteProvider(widget.envelop.id),
                      );

                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          );
        },
        direction: PopoverDirection.top,
        barrierColor: const Color(0x00000000),
        radius: 12,
        arrowDxOffset: renderObject.size.width / 4,
        shadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            color: const Color(0x33687693).withOpacity(0.05),
          ),
        ],
        onPop: () => blurScope.hideBlur(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _handleLongPress(context),
      child: AppGestureBuilder(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: true,
            context: context,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: TransactionBottomSheet(
                envelop: widget.envelop,
              ),
            ),
          );
        },
        child: _DashboardTile(
          envelop: widget.envelop,
        ),
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  const _DashboardTile({
    Key? key,
    required this.envelop,
  }) : super(key: key);

  final Envelop envelop;

  @override
  Widget build(BuildContext context) {
    return EnvelopItemView(
      envelop: envelop,
    );
  }
}
