import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/home_bloc.dart';
import 'package:flutter_demo/my_list_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'home_event.dart';
import 'home_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
              fontFamily: GoogleFonts.montserrat().fontFamily,
              bodyColor: Colors.white,
              displayColor: Colors.white),
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(colorAccent),
              primary: Colors.black,
              onPrimary: Colors.white70),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'The Kitchen~'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<HomeBloc>();
    _bloc.add(InitEvent());
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title,
                style: Theme.of(context).textTheme.headlineSmall),
            Container(
              decoration: BoxDecoration(
                  color: const Color(colorAccent),
                  borderRadius: BorderRadius.circular(4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Icon(Icons.shopping_cart),
                  ),
                  Container(
                      width: 24,
                      padding: const EdgeInsets.all(2.0),
                      child: BlocBuilder<HomeBloc, HomeState>(
                          bloc: _bloc,
                          buildWhen: (previous, current) {
                            if (previous is HomeStateLoaded) {
                              if (current is HomeStateLoaded &&
                                  (current.counter != previous.counter)) {
                                return true;
                              }
                              return false;
                            } else if (current is HomeStateLoaded) {
                              return true;
                            } else {
                              return false;
                            }
                          },
                          builder: (context, state) {
                            final data =
                                (state is HomeStateLoaded) ? state.counter : "";
                            return Text(
                              "$data",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.black),
                            );
                          })),
                ],
              ),
            )
          ],
        ),
      ),
      body: Container(
        color: const Color(colorAppBackground),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(RefreshEvent());
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: MyListWidget(),
            ),
          ),
        ),
      ),
      //This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
