import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/container_loading.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/data_ojects/util/item.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/data_ojects/util/vendedor.dart';

import '../../../sdk/models/configuracao/app_theme.dart';

class DrawerSelecaoVendedor extends StatefulWidget {
  const DrawerSelecaoVendedor({
    Key? key,
    required this.onChanged,
    required this.itens,
    this.onLoading = false,
  }) : super(key: key);

  final Function onChanged;

  final List<Vendedor> itens;
  final bool onLoading;

  @override
  State<DrawerSelecaoVendedor> createState() => _DrawerSelecaoVendedorState();
}

class _DrawerSelecaoVendedorState extends State<DrawerSelecaoVendedor> {
  Timer? t;

  @override
  void dispose() {
    super.dispose();
    if (t != null && t!.isActive) {
      t!.cancel();
    }
  }

  onUpdate() {
    if (t != null && t!.isActive) {
      t!.cancel();
    }

    setState(() {
      t = Timer(const Duration(milliseconds: 150), () {
        Vendedor.updateFilter(context, vendedores: widget.itens).then((value) {
          widget.onChanged();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: widget.onLoading
          ? const ContainerLoading()
          : SelecaoItens(
              itens: widget.itens,
              onChanged: () {
                onUpdate();
              },
            ),
    );
  }
}

class SelecaoItens extends StatefulWidget {
  const SelecaoItens({
    Key? key,
    required this.itens,
    required this.onChanged,
  }) : super(key: key);

  final List<Item> itens;
  final Function onChanged;

  @override
  State<SelecaoItens> createState() => _SelecaoItensState();
}

class _SelecaoItensState extends State<SelecaoItens> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24, top: 12),
          child: Column(
            children: [
              Text(
                'Filtrar Vendedores',
                style: AppTheme.of(context).textTheme.title(),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  widget.itens.forEach((element) {
                    element.selecionado = true;
                  });
                });
                widget.onChanged();
              },
              child: Text('Selecionar Tudo'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.itens.forEach((element) {
                    element.selecionado = !element.selecionado;
                  });
                });
                widget.onChanged();
              },
              child: Text('Inverter Seleção'),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.itens.length,
          itemBuilder: (BuildContext context, int index) {
            final item = widget.itens[index];

            return Row(
              children: [
                Checkbox(
                  value: item.selecionado,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        item.selecionado = value;
                        widget.onChanged();
                      });
                    }
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(child: Text('(${item.id}) ${item.nome}'))
              ],
            );
          },
        ),
      ],
    );
  }
}
