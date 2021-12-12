import 'package:flutter/material.dart';
import 'package:flutter_application_1/models.dart';
import 'package:provider/provider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => StateManagment(),
        builder: (context, _) {
          StateManagment currentState = Provider.of<StateManagment>(context);
          if ((currentState.currentFirebaseUid ?? "") == "noUid") {
            return Scaffold(
              appBar: AppBar(title: const Text("Log in Page")),
              body: Center(
                  child: TextButton(
                child: const Text("log in"),
                onPressed: () async =>
                    await currentState.getFirebaseUid(context),
              )),
            );
          }
          if (currentState.currentUser != null) {
            print("build");
            return Consumer<StateManagment>(builder: (context, model, _) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Example"),
                ),
                body: Center(
                  child: Text(model.currentUser.name ?? "Filler Name"),
                ),
              );
            });
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
