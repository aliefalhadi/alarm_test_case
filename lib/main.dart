import 'package:alarm_test_case/common/constants/constants_name.dart';
import 'package:alarm_test_case/data/core/notification_api.dart';
import 'package:alarm_test_case/presentation/routes.dart';
import 'package:alarm_test_case/presentation/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedantic/pedantic.dart';
import 'di/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  await init();
  getItInstance<NotificationApi>().init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ConstantsName.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Alarm(),
      onGenerateRoute: AppRouter().onGenerateRoute,
    );
  }
}
