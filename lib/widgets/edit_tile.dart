import 'package:flutter/material.dart';
import '../classes/habit.dart';

class EditTile extends StatefulWidget {
  final String tileTitle;
  Habit habit;
  String? content;
  EditTile(
      {super.key, required this.tileTitle, required this.habit, this.content});

  @override
  EditTileState createState() => EditTileState();
}

class EditTileState extends State<EditTile> {
  bool _isEditing = false;
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      child: ListTile(
        leading: Text(widget.tileTitle),
        title: _isEditing
            ? TextField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Enter ${widget.tileTitle}',
                  border: const OutlineInputBorder(),
                  errorText: _errorMessage,
                ),
              )
            : Text(
                widget.content ?? 'No content',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
        trailing: IconButton(
          icon: Icon(
            _isEditing ? Icons.check : Icons.edit,
            color: _isEditing ? Colors.green : Colors.blue,
          ),
          onPressed: () {
            if (_isEditing) {
              _validateAndSave();
            } else {
              setState(() {
                _isEditing = true;
              });
            }
          },
        ),
      ),
    );
  }

  void _validateAndSave() {
    setState(() {
      if (widget.tileTitle == "Name" && _controller.text.trim().isEmpty) {
        _errorMessage = "Name cannot be empty.";
      } else {
        _errorMessage = null;
        widget.content = _controller.text;
        if (widget.tileTitle == 'Name') {
          widget.habit.name = _controller.text;
        } else {
          widget.habit.description = _controller.text;
        }
        widget.habit.updateHabit();
        _isEditing = false;
      }
    });
  }
}
