import 'dart:developer';

import 'package:bloc_management/counter_bloc.dart';
import 'package:bloc_management/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(CounterApp());

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoModel model = DemoModel();
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CounterBloc>(
            create: (_) => CounterBloc(0),
          ),
          BlocProvider<CatBloc>(
            create: (_) => CatBloc(model),
          ),
        ], child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  DemoModel model = DemoModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: SingleChildScrollView(
        child: Column
        (
          children: [
            BlocBuilder<CatBloc, DemoModel>(
              buildWhen: (previousState, state){
                if(state.entries==null){
                  return false;
                }
                return true;
              },

              builder: (context, model) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: model.entries?.length??0,
                  itemBuilder: (context,i){
                    return Container(
                      height: 20,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10),
                      color: Colors.red,
                    );
                  },
                );
              },
            ),
            BlocBuilder<CounterBloc, int>(
              buildWhen: (previousState, state){
                if(state>5){
                  return true;
                }
                return false;
              },

              builder: (context, count) => Center(child: Text('$count')),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterBloc>().increment(),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterBloc>().decrement(),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {

                  Controller().getData(context);
              log(context.read<CatBloc>().state.toJson().toString());
            },
          ),
        ],
      ),
    );
  }
}

