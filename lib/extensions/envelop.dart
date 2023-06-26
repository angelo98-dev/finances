import 'package:finances/data/entities/envelop.dart';

extension EnvelopExtension on Envelop {
  double getRemainingPercentage() {
    return (currentAmount / initAmount) * 100;
  }

  double getPercentageSpent() {
    return ((initAmount - currentAmount) / initAmount) * 100;
  }
}
