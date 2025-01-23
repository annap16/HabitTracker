import 'package:flutter/material.dart';
import '../classes/habit.dart';
import '../widgets/edit_tile.dart';
import '../widgets/edit_tile_frequency.dart';
import '../widgets/edit_tile_color.dart';

class DetailedHabitScreen extends StatefulWidget {
  final Habit habit;
  const DetailedHabitScreen({super.key, required this.habit});

  @override
  DetailedHabitScreenState createState() => DetailedHabitScreenState();
}

class DetailedHabitScreenState extends State<DetailedHabitScreen> {
  void _deleteHabit() async {
    widget.habit.deleteHabit();

    Navigator.pop(context);
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Habit'),
          content: const Text('Are you sure you want to delete this habit?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteHabit();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Your detailed habit'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                EditTile(
                  tileTitle: 'Name',
                  habit: widget.habit,
                  content: widget.habit.name,
                ),
                EditTile(
                  tileTitle: 'Description',
                  habit: widget.habit,
                  content: widget.habit.description,
                ),
                EditTileFrequency(
                  tileTitle: 'Frequency',
                  habit: widget.habit,
                ),
                EditTileColor(
                  tileTitle: 'Color',
                  habit: widget.habit,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDeleteConfirmationDialog,
        backgroundColor: Colors.green,
        child: const Icon(Icons.delete),
      ),
    );
  }
}
