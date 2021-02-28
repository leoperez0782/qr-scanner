import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/src/pages/direcciones_page.dart';
import 'package:qr_scanner/src/pages/mapas_page.dart';
import 'package:qr_scanner/src/providers/db_provider.dart';
import 'package:qr_scanner/src/providers/ui_provider.dart';
import 'package:qr_scanner/src/widgets/custom_navigatorbar.dart';
import 'package:qr_scanner/src/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Obtener selectedMenuopt
    final uiProvider = Provider.of<UiProvider>(context);

    //cambia para mostrar pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    //tODO TEMPORAL LEER DB
    final tempScan = new ScanModel(valor: 'https://google.com');
    DBProvider.dbProvider.nuevoScan(tempScan);

    switch (currentIndex) {
      case 0:
        return MapasPage();

      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
