import 'dart:async';

import '../../../core/models/venda_model.dart';
import '../repository/venda_repository.dart';

class NovaVendaUC {
  final VendaRepository vendaRepository;

  NovaVendaUC({required this.vendaRepository});

  FutureOr<bool> call({
    required VendaModel novaVenda,
    
    
  }) async {
    try {
      await vendaRepository.newVenda(

novaVenda
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}