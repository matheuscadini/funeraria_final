import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart' as fb;

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/models/caixao_model.dart';
import '../../../core/models/venda_model.dart';

class CaixaoRepository {
  FutureOr<List<CaixaoModel>> getCaixoes() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('caixoes').get();

    final List<CaixaoModel> listaCaixoes = [];
    snapshot.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
        listaCaixoes.add(CaixaoModel.fromJson(doc.data())));
    return listaCaixoes;
  }

  FutureOr<List<CaixaoModel>> findCaixoes(String idFuneraria) async {
    QuerySnapshot<Map<String, dynamic>> searchCaixoes = await FirebaseFirestore
        .instance
        .collection('caixoes')
        .where('funerariaId', isEqualTo: idFuneraria)
        .get();

    final List<CaixaoModel> listaCaixoes = [];
    searchCaixoes.docs.forEach(
        (QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            listaCaixoes.add(CaixaoModel.fromJson(doc.data())));
    return listaCaixoes;
  }

  FutureOr<String> getImageCaixao(String nameImage) async {
    return await fb.FirebaseStorage.instance
        .refFromURL('gs://fir-funeraria.appspot.com')
        .child(nameImage)
        .getDownloadURL();
  }

  deleteCaixoes(String id) {
    FirebaseFirestore.instance.collection('caixoes').doc(id).delete();
  }

  compraCaixoes(DateTime dataCompra, int quantidadeAlto, int quantidadeNormal,
      int quantidadeGordo, int quantidadeAltoGordo, String id) {
    FirebaseFirestore.instance.collection('caixoes').doc(id).update(
      {
        'quantidadeTipoNormal': quantidadeNormal,
        'quantidadeTipoAlto': quantidadeAlto,
        'quantidadeTipoGordo': quantidadeGordo,
        'quantidadeTipoGordoAlto': quantidadeAltoGordo,
        'dataUltimaCompra': dataCompra,
      },
    );
    print("tudo ok");
  }

  editStatusCaixoes(
      {String? status, required String id, String? idLote, String? loteAtual}) {
    FirebaseFirestore.instance.collection('caixoes').doc(id).update(
      {'status': status, 'idLote': idLote, 'loteAtual': loteAtual},
    );
  }

  FutureOr<CaixaoModel> newCaixao(CaixaoModel caixao) async {
    //String nome = '';

    // if (foto != null) {
    //   nome = DateTime.now().microsecondsSinceEpoch.toString();
    //   fb.UploadTask storage =
    //       fb.FirebaseStorage.instance.ref(nome).putFile(foto);
    //   caixao.valorVenda = nome;
    // }

    final db = FirebaseFirestore.instance.collection('caixoes').doc();
    caixao.idCaixao = db.id;

    final json = caixao.toJson();
    await db.set(json);
    print("chegou");
    return caixao;
  }

  FutureOr<VendaModel> vendaCaixao(VendaModel venda) async {
    final db = FirebaseFirestore.instance.collection('vendas').doc();
    venda.id = db.id;

    final json = venda.toJson();
    await db.set(json);
    return venda;
  }
}
