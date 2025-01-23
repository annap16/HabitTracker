import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../classes/habit.dart';

class EditTileColor extends StatefulWidget {
  final String tileTitle;
  Habit habit;

  EditTileColor({
    super.key,
    required this.tileTitle,
    required this.habit,
  });

  @override
  EditTileColorState createState() => EditTileColorState();
}

class EditTileColorState extends State<EditTileColor> {
  Color? _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = colorFromHex(widget.habit.color) ?? Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      child: ListTile(
        leading: Text(widget.tileTitle),
        title: Container(
          height: 20,
          width: 40,
          color: _selectedColor,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: _showColorPickerDialog,
        ),
      ),
    );
  }

  void _showColorPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor!,
              onColorChanged: (Color color) {
                setState(() {
                  _selectedColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  widget.habit.color = colorToHex(_selectedColor!);
                  widget.habit.updateHabit();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
