

import 'package:cloud_firestore/cloud_firestore.dart';

import 'funeraria_model.dart';

class CaixaoModel {
  String? fornecedor;
  int? quantidadeTipoNormal;
  int? quantidadeTipoGordo;
  int? quantidadeTipoAlto;
  int? quantidadeGordoAlto;
  String? id;
  String? idCaixao;
  String? codigo;
  String? descricao;
  String? funerariaId;
  DateTime? dataUltimaCompra;
  DateTime? dataUltimaVenda;
  FunerariaModel? funerariaModel;
  String? valorVenda;

  CaixaoModel({
    this.fornecedor,
    this.quantidadeTipoNormal,
    this.quantidadeTipoAlto,
    this.quantidadeTipoGordo,
    this.quantidadeGordoAlto,
    this.id,
    this.idCaixao,
    this.codigo,
    this.descricao,
    this.funerariaId,
    this.dataUltimaCompra,
    this.dataUltimaVenda,
    this.funerariaModel,
  });

  CaixaoModel.fromJson(Map<String, dynamic> json) {
    fornecedor = json['fornecedor'];
    quantidadeTipoNormal = json['quantidadeTipoNormal'];
    quantidadeTipoAlto = json['quantidadeTipoAlto'];
    quantidadeTipoGordo = json['quantidadeTipoGordo'];
    quantidadeGordoAlto = json['quantidadeTipoGordoAlto'];

    id = json['id'];
    idCaixao = json['idCaixao'];
    codigo = json['codigo'];
    descricao = json['descricao'];
    funerariaId = json['fazendaId'];
    if (json['dataUltimaCompra'] != null) {
      Timestamp timestamp = json['dataUltimaCompra'];
      dataUltimaCompra = (timestamp.toDate());
    }

    valorVenda = json['valorVenda'];
    funerariaModel = json['funerariaModel'] != null
        ? FunerariaModel.fromJson(json['funerariaModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fornecedor'] = fornecedor;
    data['quantidadeTipoNormal'] = quantidadeTipoNormal;
    data['quantidadeTipoAlto'] = quantidadeTipoAlto;
    data['quantidadeTipoGordo'] = quantidadeTipoGordo;
    data['quantidadeTipoGordoAlto'] = quantidadeGordoAlto;
    data['id'] = id;
    data['idCaixao'] = idCaixao;
    data['codigo'] = codigo;
    data['descricao'] = descricao;
    data['funerariaId'] = funerariaId;
    data['dataUltimaCompra'] = dataUltimaCompra;
    data['dataUltimaVenda'] = dataUltimaVenda;
    data['valorVenda'] = valorVenda;
    if (funerariaModel != null) {
      data['funerariaModel'] = funerariaModel!.toJson();
    }

    return data;
  }
}
