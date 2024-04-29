
import 'package:get/get.dart';

import '../modules/venda/application/venda_controller.dart';
import '../modules/venda/domain/nova_venda_UC.dart';
import '../modules/venda/repository/venda_repository.dart';

class ModulesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => VendaRepository(),
    );

    Get.put<NovaVendaUC>(
      NovaVendaUC(
        vendaRepository: Get.find(),
      ),
    );
    Get.lazyPut<VendaController>(
      () => VendaController(),
    );
  }
}
