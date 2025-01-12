import 'package:flutter/material.dart';

class MyHabitTile extends StatelessWidget {
  final bool isCompleted;
  final String txt;
  final void Function(bool?)?onChanged;

  const MyHabitTile({
    super.key,
    required this.isCompleted,
    required this.txt,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(// wrapped the contatiner to gesture detecture 
      onTap: (){
        if(onChanged!=null){
          // toggle compltetion status 
          onChanged!(!isCompleted);

        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isCompleted
              ? Colors.green
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: ListTile(
          title: Text(txt),
          leading:Checkbox(
            activeColor: Colors.green,
            value: isCompleted,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
