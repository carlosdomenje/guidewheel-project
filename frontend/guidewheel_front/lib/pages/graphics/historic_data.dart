import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guidewheel_front/pages/graphics/widgets/graph_history.dart';
import 'package:guidewheel_front/services/guidewheel_service.dart';
import 'package:provider/provider.dart';

class HistoricDataPage extends StatefulWidget {
  const HistoricDataPage({Key? key}) : super(key: key);

  @override
  State<HistoricDataPage> createState() => _HistoricDataPageState();
}

class _HistoricDataPageState extends State<HistoricDataPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final guidewheelService =
        Provider.of<GuidewheelService>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'HISTORIC DATA',
            style: GoogleFonts.roboto(),
          ),
          centerTitle: true,
          leading: IconButton(
              splashRadius: 10,
              onPressed: () {
                context.go('/');
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const ListTile(
                leading: Icon(
                  Icons.insert_chart,
                  size: 50,
                  //  color: Colors.orange,
                ),
                title: Text('HISTORICAL DATA OF THE DAY'),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: guidewheelService.getAllMeasures(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return GraphHistory(
                      historyList: snapshot.data['measures'],
                      total: snapshot.data['total'],
                      idleTime: snapshot.data['idleTime'],
                      unloadTime: snapshot.data['unloadTime'],
                      min: snapshot.data['idleThreshold'],
                      max: snapshot.data['unloadThreshold'],
                      type: 'History',
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ));
  }
}
