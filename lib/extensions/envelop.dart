import 'package:finances/data/entities/envelop.dart';

extension EnvelopExtension on Envelop {
  double getRemainingPercentage() {
    // if current amount is negative, that means we spent 100% of the money.
    if (currentAmount.isNegative) {
      return 0;
    }

    return (currentAmount / initAmount) * 100;
  }

  double getPercentageSpent() {
    if (currentAmount.isNegative) {
      return 100;
    }

    return ((initAmount - currentAmount) / initAmount) * 100;
  }
}
