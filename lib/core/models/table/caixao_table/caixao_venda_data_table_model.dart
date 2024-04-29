import '../../../../modules/caixoes/application/caixao_controller.dart';
import '../../../../modules/venda/application/venda_controller.dart';
import '../../caixao_model.dart';
import '../table_data_model.dart';
import '../table_row_model.dart';
import '../table_value_model.dart';

class CaixaoVendaDataTableModel implements TableDataModel {
  @override
  List<TableRowModel> data = [];

  @override
  TableRowModel? header;

  CaixaoVendaDataTableModel.fromList({
    required List<CaixaoModel> list,
    required CaixaoController caixaoController,
    required VendaController vendaController,
  }) {
    List<TableValueModel> headerValues = [
      TableValueModel(
        description: 'Modelo',
        flex: 30,
      ),
      TableValueModel(
        description: 'Fornecedor',
        flex: 30,
      ),
      TableValueModel(
        description: 'Normal',
        flex: 15,
      ),
      TableValueModel(
        description: 'Alto',
        flex: 15,
      ),
      TableValueModel(description: 'Gordo', flex: 15),
      TableValueModel(description: 'Alto e Gordo', flex: 15),
    ];
    header = TableRowModel(row: headerValues);
    list.sort((a, b) => (a.idCaixao)!.compareTo(b.idCaixao!));
    for (var i = 0; i < list.length; i++) {
      TableRowModel dataRow = caixaoToDataTable(
        caixao: list[i],
        index: i,
        caixaoController: caixaoController,
      );
      dataRow.onClick = () {
        vendaController.caixaoSelecionado.value = list[i];

        caixaoController.getFoto(list[i].valorVenda!);

        // Get.dialog(ModalSurveyWidget(
        //   caixaoController: caixaoController,
        // ));
      };
      data.add(dataRow);
    }
  }

  TableRowModel caixaoToDataTable({
    required CaixaoModel caixao,
    int index = 0,
    required CaixaoController caixaoController,
  }) {
    TableRowModel rowItem = TableRowModel(
      row: [],
      index: index,
    );
    TableValueModel idCaixao = TableValueModel(
      description: caixao.descricao.toString(),
      flex: 30,
      //isRelevant: true,
    );
    TableValueModel fornecedor = TableValueModel(
      description: caixao.fornecedor.toString(),
      flex: 30,
      //isRelevant: true,
    );
    TableValueModel normal = TableValueModel(
      description: caixao.quantidadeTipoNormal.toString(),
      //("${animal.dataNascimento?.day}-${animal.dataNascimento?.month}-${animal.dataNascimento?.year} "),
      flex: 15,
      //isRelevant: true,
    );
    TableValueModel alto = TableValueModel(
      description: caixao.quantidadeTipoAlto.toString(),
      //("${animal.dataNascimento?.day}-${animal.dataNascimento?.month}-${animal.dataNascimento?.year} "),
      flex: 15,
      //isRelevant: true,
    );
    TableValueModel gordo = TableValueModel(
      description: caixao.quantidadeTipoGordo.toString(),
      //("${animal.dataNascimento?.day}-${animal.dataNascimento?.month}-${animal.dataNascimento?.year} "),
      flex: 15,
      //isRelevant: true,
    );
    TableValueModel altoGordo = TableValueModel(
      description: caixao.quantidadeGordoAlto.toString(),
      //("${animal.dataNascimento?.day}-${animal.dataNascimento?.month}-${animal.dataNascimento?.year} "),
      flex: 15,
      //isRelevant: true,
    );

    // TableValueModel editItem = TableValueModel(
    //   flex: 1,
    //   isRelevant: true,
    //   type: TableValueType.edit,
    //   onClick: () {
    //     Get.dialog(
    //       ActionDialog(
    //         title: 'Editar Badword',
    //         confirmButton: 'Editar',
    //       ),
    //     );
    //   },
    // );
    // TableValueModel removeItem = TableValueModel(
    //   flex: 1,
    //   isRelevant: true,
    //   type: TableValueType.exclude,
    //   onClick: () {
    //     Get.dialog(
    //       SimpleDialog(
    //         insetPadding: EdgeInsets.zero,
    //         contentPadding: EdgeInsets.zero,
    //         children: [
    //           AlertDialogWidget(
    //             title: 'Tem certeza que deseja excluir?',
    //             subtitle: 'Remover badword: ${animal.description}',
    //             confirmOption: 'Excluir',
    //             confirmFunction: () async {
    //               await badwordsController.removeItem(animal.id ?? '');
    //               Get.back();
    //             },
    //             negativeFunction: () => Get.back(),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
    rowItem.row = [idCaixao, fornecedor, normal, alto, gordo, altoGordo];
    return rowItem;
  }

  String getData(CaixaoModel caixao) {
    String data2 = '';
    if (caixao.dataUltimaVenda == null) {
      data2 = 'Sem Registro';
    } else {
      data2 =
          "${caixao.dataUltimaVenda!.day}-${caixao.dataUltimaVenda!.month}-${caixao.dataUltimaVenda!.year}";
    }
    return data2;
  }
}
