import 'package:flutter/material.dart';
import 'package:to_do_list/components/to_do_bubble.dart';
import 'package:to_do_list/models/to_do_model.dart';
import 'package:to_do_list/services/to_do_list/to_do_service.dart';

class ItemToDo extends StatelessWidget {
  final ToDoModel itemToDo;

  const ItemToDo({super.key, required this.itemToDo});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ToDoModel>>(
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
          itemBuilder: (context, i) => ToDoBubble(itemToDo: itensToDo[i]),
          );
        }
      },
    );
  }
}