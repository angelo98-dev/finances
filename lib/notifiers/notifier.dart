import 'package:finances/data/entities/envelop.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBarIndexNotifier extends StateNotifier<Envelop?> {
  BottomBarIndexNotifier() : super(null);

  void setEnvelop(Envelop value) {
    state = value;
  }
}
