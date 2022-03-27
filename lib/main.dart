import 'package:catalog_app/bloc/cart_blac/carts_bloc.dart';
import 'package:catalog_app/repository/api_repository.dart';
import 'package:catalog_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/item_bloc/items_bloc.dart';
import 'widgets/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  ApiRepository apiRepository = ApiRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemsBloc>(
          create: (context) => ItemsBloc(apiRepository),
        ),
        BlocProvider<CartsBloc>(
          create: (context) => CartsBloc(apiRepository),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: MyTheme.lightTheme(context),
        darkTheme: MyTheme.darkTheme(context),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Home(),
        ),
      ),
    );
  }
}
