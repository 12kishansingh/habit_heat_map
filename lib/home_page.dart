import 'package:flutter/material.dart';
import 'package:habit_heat_map/components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final TextEditingController textController=TextEditingController();
  // create new habit
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        content: TextField(
          controller: textController,
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
