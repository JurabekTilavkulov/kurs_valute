import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs_valute/data/model/model_money.dart';
import 'package:kurs_valute/data/net_service/net_service.dart';
import 'package:kurs_valute/ui/pages/home_page/home_page.dart';
import 'package:kurs_valute/ui/pages/next_page/next_page.dart';


import 'data/bloc/money_bloc.dart';

import 'data/cubit/for_home_page/home_page_cubit.dart';
import 'data/cubit/for_next_page/next_page_cubit.dart';


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
        BlocProvider(create: (context) => MoneyBloc(netWorkService: NetWorkService(Dio()))),
        BlocProvider(create: (context) => NextPageCubit(),),
        BlocProvider(create: (context) => HomePageCubit(),),
      ],

      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: "/MyHomePage",
        onGenerateRoute: (settings) {
          switch (settings.name) {

            case "/MyHomePage":
              return CupertinoPageRoute(
                builder: (context) => MyHomePage(),
              );
            case "/NextPage":
              return CupertinoPageRoute(
                builder: (context) => NextPage(modelMoney: settings.arguments as ModelMoney,),
              );
          }
        },
      ),
    );
  }
}


