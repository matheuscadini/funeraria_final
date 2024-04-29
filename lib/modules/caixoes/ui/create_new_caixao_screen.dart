// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../core/models/caixao_model.dart';
import '../../../core/styles/custom_colors.dart';
import '../../../core/widgets/custom_form_field.dart';
import '../../../core/widgets/snackbar_widget.dart';
import '../../funeraria/application/funeraria_controller.dart';
import '../application/caixao_controller.dart';

// ignore: must_be_immutable
class CreateNewCaixaoScreen extends StatefulWidget {
  CaixaoController caixaoController;
  late var imageFileScreen;
  late Uint8List file;
  RxBool imageLoaded = false.obs;
  late File foto;

  CreateNewCaixaoScreen({
    Key? key,
    required this.caixaoController,
  }) : super(key: key);

  @override
  State<CreateNewCaixaoScreen> createState() => _CreateNewOxScreen();
}

class _CreateNewOxScreen extends State<CreateNewCaixaoScreen> {
  FunerariaController funerariaController = Get.find();
  //AnimalController animalController = Get.find();

  var weightMaskFormatter = MaskTextInputFormatter(
    mask: '####',
  );
  var maskFormatter = MaskTextInputFormatter(
    mask: '',
  );

  TextEditingController idCaixao = TextEditingController();
  TextEditingController textCodigo = TextEditingController();
  TextEditingController textDescricao = TextEditingController();
  TextEditingController textObservacao = TextEditingController();
  TextEditingController textFornecedor = TextEditingController();
  TextEditingController textQuantidadeNormal = TextEditingController();
  TextEditingController textQuantidadeGordo = TextEditingController();
  TextEditingController textQuantidadeAlto = TextEditingController();
  TextEditingController textQuantidadeAltoGordo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        height: 550,
        width: 950,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 42, 32, 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cadastrar novo Caixão",
                      )),
                  Row(
                    children: [
                      IconButton(
                          alignment: Alignment.topRight,
                          icon: SvgPicture.asset(
                            'icons/close_round.svg',
                            height: 24,
                            width: 24,
                          ),
                          onPressed: () {
                            Get.back();
                          }),
                    ],
                  ),
                ],
              ),
              const Divider(
                thickness: 2,
                height: 10,
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: CustomColors.backgroundTextFormField,
                      ),
                      height: 369,
                      child: widget.imageLoaded.value == false
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'icons/figure_survey_stack.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.fitWidth,
                                ),
                                Positioned(
                                  bottom: 18,
                                  right: 18,
                                  child: Container(
                                      height: 32,
                                      width: 32,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0XFF313138)),
                                      child: IconButton(
                                          padding: EdgeInsets.zero,
                                          color: CustomColors
                                              .backgroundTextFormField,
                                          onPressed: () async {
                                            pickImage();
                                          },
                                          icon: const Icon(Icons.add))),
                                ),
                              ],
                            )
                          : Stack(
                              fit: StackFit.expand,
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    widget.imageFileScreen.path,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 18,
                                  right: 18,
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0XFF313138)),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      color:
                                          CustomColors.backgroundTextFormField,
                                      onPressed: () {
                                        widget.imageLoaded.value = false;
                                      },
                                      icon: const Icon(
                                        Icons.close_outlined,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    flex: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Fornecedor'),
                            SizedBox(
                              width: 380,
                              child: CustomTextFormField(
                                controller: textFornecedor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Código'),
                            SizedBox(
                              width: 380,
                              child: CustomTextFormField(
                                controller: textCodigo,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Descrição'),
                            SizedBox(
                              width: 380,
                              child: CustomTextFormField(
                                controller: textDescricao,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Observações'),
                            SizedBox(
                              width: 380,
                              child: CustomTextFormField(
                                controller: textObservacao,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Normal'),
                                SizedBox(
                                  width: 150,
                                  child: CustomTextFormField(
                                    controller: textQuantidadeNormal,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text('Gordo'),
                                SizedBox(
                                  width: 150,
                                  child: CustomTextFormField(
                                    controller: textQuantidadeGordo,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Alto'),
                                SizedBox(
                                  width: 150,
                                  child: CustomTextFormField(
                                    controller: textQuantidadeAlto,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text('Alto e Gordo'),
                                SizedBox(
                                  width: 150,
                                  child: CustomTextFormField(
                                    controller: textQuantidadeAltoGordo,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                          height: 10,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: CustomColors.background,
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                fixedSize: const Size(152, 40),
                              ),
                              onPressed: () {
                                if (widget.imageLoaded.value == false) {
                                  snackbarWidget(
                                      title: 'Uma imagem é necessária.',
                                      icon: 'icons/warning_message.svg');
                                } else {
                                  addCaixao();
                                }
                              },
                              child: const Text('Publicar'),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  textDate({
    required TextEditingController dateController,
    required String label,
  }) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        readOnly: true,
        controller: dateController,
        decoration: InputDecoration(
          labelText: label,
        ),
        onTap: () async {
          await showDatePicker(
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: CustomColors.background,
                    onPrimary: CustomColors.textwhite,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      backgroundColor: CustomColors.background,
                    ),
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2015),
            lastDate: DateTime(2025),
          ).then((selectedDate) {
            if (selectedDate != null) {
              dateController.text =
                  DateFormat('dd-MM-yyyy').format(selectedDate);
            }
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter date.';
          }
          return null;
        },
      ),
    );
  }

  void addCaixao() {
    int quantidadeCaixaonormal = 0;
    int quantidadeCaixaoAlto = 0;
    int quantidadeCaixaoAltoGordo = 0;
    int quantidadeCaixaoGordo = 0;
    if (textQuantidadeNormal.value.text.isNotEmpty) {
      quantidadeCaixaonormal = int.parse(textQuantidadeNormal.value.text);
    }
    if (textQuantidadeAlto.value.text.isNotEmpty) {
      quantidadeCaixaoAlto = int.parse(textQuantidadeAlto.value.text);
    }
    if (textQuantidadeAltoGordo.value.text.isNotEmpty) {
      quantidadeCaixaoAltoGordo = int.parse(textQuantidadeAltoGordo.value.text);
    }
    if (textQuantidadeGordo.value.text.isNotEmpty) {
      quantidadeCaixaoGordo = int.parse(textQuantidadeGordo.value.text);
    }
    widget.caixaoController.novoCaixao(
      CaixaoModel(
        idCaixao: idCaixao.text,
        funerariaId: funerariaController.funerariaSelecionada.value.id,
        fornecedor: textFornecedor.value.text,
        descricao: textDescricao.value.text,
        codigo: textCodigo.value.text,
        dataUltimaCompra: DateTime.now(),
        quantidadeTipoNormal: quantidadeCaixaonormal,
        quantidadeGordoAlto: quantidadeCaixaoAltoGordo,
        quantidadeTipoAlto: quantidadeCaixaoAlto,
        quantidadeTipoGordo: quantidadeCaixaoGordo,
      ),
    );
    //);
    clearText();
    snackbarWidget(
        title: 'Caixão Cadastrado com Sucesso.', icon: 'icons/Key.svg');
  }

  void clearText() {
    textCodigo.clear();
    textDescricao.clear();
    textObservacao.clear();
    textFornecedor.clear();
    textQuantidadeAlto.clear();
    textQuantidadeAltoGordo.clear();
    textQuantidadeGordo.clear();
    textQuantidadeNormal.clear();
    widget.imageLoaded.value == false;
  }

  pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    //widget.foto = File(image.path);
    widget.imageFileScreen = image;
    Uint8List data = await image!.readAsBytes();
    widget.file = data;
    widget.imageLoaded.value = true;
  }
}
