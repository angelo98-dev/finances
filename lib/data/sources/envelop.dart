// ignore_for_file: prefer_const_constructors

import 'package:collection/collection.dart';
import 'package:finances/data/entities/envelop.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final envelopApiClient = Provider(
  (ref) => EnvelopApiClient(),
);

class EnvelopApiClient {
  List<Envelop> allEnvelops = [
    Envelop(
      id: '1',
      currentAmount: 100,
      title: 'Nourriture',
      //currentPercentage: 0.3,
      initAmount: 500,
    ),
    Envelop(
      id: '2',
      currentAmount: 300,
      title: 'Hygiène',
      // currentPercentage: 0.3,
      initAmount: 500,
    ),
    Envelop(
      id: '3',
      currentAmount: 50,
      title: 'Voyages',
      //currentPercentage: 0.3,
      initAmount: 700,
    ),
    Envelop(
      id: '4',
      currentAmount: 100,
      title: 'Libéralités',
      //currentPercentage: 0.6,
      initAmount: 800,
    )
  ];

  Future<List<Envelop>> getAllEnvelop() async {
    return Future.delayed(Duration(seconds: 3), () {
      return allEnvelops;
    });
  }

  Future<void> initEnvelops() async {}

  Future<void> transaction({
    required Envelop envelop,
    required double amount,
    bool add = false,
  }) async {
    final env = allEnvelops.firstWhereOrNull(
      (envel) => envel.id == envelop.id,
    );

    if (env == null) {
      return;
    }

    final newAmount =
        add ? env.currentAmount + amount : env.currentAmount - amount;
    // implement update
  }

  Future<void> createEnvelop({
    required String title,
    required double initAmount,
  }) async {
    final newEnvelop = Envelop(
      id: 'id',
      currentAmount: initAmount,
      title: title,
      initAmount: initAmount,
    );

    allEnvelops.add(newEnvelop);
  }

  List<Envelop> getEnvelop() {
    final mesEnvelop = [
      Envelop(
        id: '1',
        currentAmount: 100,
        title: 'Nourriture',
        //currentPercentage: 0.3,
        initAmount: 500,
      ),
      Envelop(
        id: '2',
        currentAmount: 300,
        title: 'Hygiène',
        // currentPercentage: 0.3,
        initAmount: 500,
      ),
      Envelop(
        id: '3',
        currentAmount: 50,
        title: 'Voyages',
        //currentPercentage: 0.3,
        initAmount: 700,
      ),
      Envelop(
        id: '4',
        currentAmount: 100,
        title: 'Libéralités',
        //currentPercentage: 0.6,
        initAmount: 800,
      ),
    ];

    return mesEnvelop;
  }
}
