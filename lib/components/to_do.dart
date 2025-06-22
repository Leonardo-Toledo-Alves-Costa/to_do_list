import 'package:flutter/material.dart';
import 'package:to_do_list/components/item_to_do.dart';
import 'package:to_do_list/services/to_do_list/to_do_service.dart';

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ToDoService().streamToDoItens(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),
          );
        }else if(!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Sem itens para fazer por enquanto!'),
          );
        }else {
          final itensToDo = snapshot.data!;
          return ListView.builder(itemCount: itensToDo.length,
          itemBuilder: (context, i) => ItemToDo(itemToDo: itensToDo[i]),
          );
        }
      },
    );
  }
}
