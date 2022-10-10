import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:yukem_dashboard/sdk/common/components/mostrar_confirmacao.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/select/selecionar_meta.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/metas/components/buttons.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/metas/components/input_small_number.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/metas/components/input_small_text.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/metas/moddels/meta.dart';

import '../../../../component/form_date_picker.dart';

class ContainerMetaGerenciar extends StatefulWidget {
  const ContainerMetaGerenciar(
      {Key? key,
      required this.meta,
      this.onRemove,
      this.onSave,
      this.onUpdate,
      this.onAdd})
      : super(key: key);

  final Meta meta;

  @override
  _ContainerMetaGerenciarState createState() => _ContainerMetaGerenciarState();

  final void Function()? onRemove;
  final void Function()? onSave;
  final void Function()? onUpdate;
  final void Function()? onAdd;
}

class _ContainerMetaGerenciarState extends State<ContainerMetaGerenciar> {
  late TextEditingController controllerDiasUteis;

  late TextEditingController controllerDiasDecorridos;

  late TextEditingController controllerMetaNome;

  late TextEditingController textController3;

  late TextEditingController textController4;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void init() {
    controllerDiasUteis =
        TextEditingController(text: '${widget.meta.diasUteis}');
    controllerDiasDecorridos =
        TextEditingController(text: '${widget.meta.diasDecorridos}');
    controllerMetaNome = TextEditingController(text: widget.meta.nome);
    textController3 = TextEditingController();
    textController4 = TextEditingController();
  }

  execute(Function? f) {
    if (f != null) {
      f();
    }
  }

  int i = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    init();

    return Card(
      shadowColor: Colors.black,
      // color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 16, 8, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
              child: InputTextSmall(
                controller: controllerMetaNome,
                style: theme.textTheme.title(),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
              child: CircularPercentIndicator(
                percent: widget.meta.getCircularProgessValue(),
                radius: 60,
                lineWidth: 24,
                animation: true,
                progressColor: theme.colorTheme.primaryColor,
                backgroundColor: const Color(0xFFF1F4F8),
                center: Text(
                  '${(widget.meta.getCircularProgessValue() * 100).toStringAsFixed(0)}%',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Dias Totais',
                      style: theme.textTheme.body(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${widget.meta.diasTotais}',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.body(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Dias Úteis',
                      style: theme.textTheme.body(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InputNumberSmall(
                      controller: controllerDiasUteis,
                      style: theme.textTheme.body(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Dias Decorridos',
                      style: theme.textTheme.body(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InputNumberSmall(
                      controller: controllerDiasDecorridos,
                      style: theme.textTheme.body(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Dias Restantes',
                      style: theme.textTheme.body(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${widget.meta.diasRestantes}',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.body(),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Text(
              'Período',
              style: theme.textTheme.subTitle(),
              // style: FlutterFlowTheme.of(context).bodyText1,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: FormDatePicker(
                        firstDate: DateTime(2000, 1, 1),
                        initialDate: widget.meta.dataInicio,
                        lastDate: DateTime(2100, 1, 1),
                        then: (DateTime? date) {
                          if (date != null) {
                            widget.meta.dataInicio = date;
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: theme.textTheme.body(),
                          hintText: 'Data Inicio',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: FormDatePicker(
                        firstDate: DateTime(2000, 1, 1),
                        initialDate: widget.meta.dataFim,
                        lastDate: DateTime(2100, 1, 1),
                        then: (DateTime? date) {
                          if (date != null) {
                            widget.meta.dataFim = date;
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: theme.textTheme.body(),
                          hintText: 'Data Fim',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            if (widget.meta.status == 1)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: SizedBox(
                  width: double.infinity, // <-- match_parent
                  height: 40,
                  child: TextButton(
                    style: theme.buttonStyle,
                    child: Text('Importar Dados',
                        style: theme.textTheme.subTitle2()),
                    onPressed: () {
                      selecionarMeta(context).then((other) {
                        if (other != null) {
                          mostrarCaixaConfirmacao(context,
                                  content:
                                      'Importar os dados irá APAGAR todas as metas dessa tabela para dar espaço as novas')
                              .then((value) {
                            if (value) {
                              widget.meta
                                  .copy(context, other)
                                  .then((value) => execute(widget.onSave));
                            }
                          });
                        }
                      });
                    },
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: RemoveButton(
                      onActive: widget.meta.id != 0,
                      onPressed: () {
                        widget.meta.remover(context).then((value) {
                          execute(widget.onRemove);
                        });
                      },
                      popUp: true,
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: SaveButton(
                      onPressed: () {
                        try {
                          widget.meta.nome = controllerMetaNome.text;
                          widget.meta.diasUteis =
                              int.parse(controllerDiasUteis.text);
                          widget.meta.diasDecorridos =
                              int.parse(controllerDiasDecorridos.text);
                          widget.meta.salvar(context).then((value) {
                            execute(widget.meta.status == 1
                                ? widget.onSave
                                : widget.onRemove);
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
