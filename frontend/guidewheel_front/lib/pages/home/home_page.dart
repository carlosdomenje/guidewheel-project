import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guidewheel_front/services/auth_service.dart';
import 'package:guidewheel_front/services/guidewheel_service.dart';
import 'package:guidewheel_front/shared/custom_big_button.dart';
import 'package:guidewheel_front/shared/scaffold/drawer.dart';
import 'package:provider/provider.dart';

import '../graphics/widgets/graph_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

/// Home Page
/// Resume of data
/// Graphic data of the day

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final authService = context.read<AuthService>();

    return Scaffold(
      drawer: drawerMenu(authService, context),
      appBar: AppBar(
        title: const Text('GUIDEWHEEL'),
        centerTitle: true,
      ),
      body: _tabletView(context),
    );
  }

  Widget _tabletView(BuildContext context) {
    final guidewheelService =
        Provider.of<GuidewheelService>(context, listen: false);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const ListTile(
                leading: Icon(
                  Icons.insert_chart,
                  size: 80,
                  //  color: Colors.orange,
                ),
                title: Text(
                  'HISTORICAL DATA OF THE DAY',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 60,
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
