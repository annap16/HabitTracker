import 'package:flutter/material.dart';
import '../classes/habit.dart';

class EditTileFrequency extends StatefulWidget {
  final String tileTitle;
  Habit habit;

  EditTileFrequency({
    super.key,
    required this.tileTitle,
    required this.habit,
  });

  @override
  EditTileFrequencyState createState() => EditTileFrequencyState();
}

class EditTileFrequencyState extends State<EditTileFrequency> {
  bool _isEditing = false;
  ReminderFrequency? _selectedFrequency;
  int? _selectedDetailedFrequency;
  String? _detailedFrequencyError;

  @override
  void initState() {
    super.initState();
    _selectedFrequency = widget.habit.frequency;
    _selectedDetailedFrequency = widget.habit.detailedFrequency;
  }

  void _onFrequencyChanged(ReminderFrequency? newValue) {
    setState(() {
      _selectedFrequency = newValue;
      if (_selectedFrequency == ReminderFrequency.daily) {
        _selectedDetailedFrequency = 1;
      }
    });
  }

  bool _validateDetailedFrequency() {
    if (_selectedFrequency == ReminderFrequency.weekly &&
        (_selectedDetailedFrequency == null ||
            _selectedDetailedFrequency! < 1 ||
            _selectedDetailedFrequency! > 6)) {
      setState(() {
        _detailedFrequencyError =
            'Frequency must be between 1 and 6 for weekly.';
      });
      return false;
    } else if (_selectedFrequency == ReminderFrequency.monthly &&
        (_selectedDetailedFrequency == null ||
            _selectedDetailedFrequency! < 1 ||
            _selectedDetailedFrequency! > 29)) {
      setState(() {
        _detailedFrequencyError =
            'Frequency must be between 1 and 29 for monthly.';
      });
      return false;
    }
    setState(() {
      _detailedFrequencyError = null;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Text(widget.tileTitle),
        title: _isEditing
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<ReminderFrequency>(
                    value: _selectedFrequency,
                    onChanged: _onFrequencyChanged,
                    items:
                        ReminderFrequency.values.map((ReminderFrequency freq) {
                      return DropdownMenuItem<ReminderFrequency>(
                        value: freq,
                        child: Text(_getFrequencyString(freq)),
                      );
                    }).toList(),
                  ),
                  if (_selectedFrequency != ReminderFrequency.daily)
                    TextField(
                      enabled: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: _selectedDetailedFrequency.toString(),
                        errorText: _detailedFrequencyError,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedDetailedFrequency = int.tryParse(value);
                        });
                      },
                    ),
                ],
              )
            : _buildFrequencyDisplay(),
        trailing: IconButton(
          icon: Icon(
            _isEditing ? Icons.check : Icons.edit,
            color: _isEditing ? Colors.green : Colors.blue,
          ),
          onPressed: () {
            if (_validateDetailedFrequency()) {
              setState(() {
                if (_isEditing) {
                  widget.habit.frequency = _selectedFrequency!;
                  widget.habit.detailedFrequency = _selectedDetailedFrequency!;
                  if (_selectedDetailedFrequency! <=
                      widget.habit.executionCount) {
                    widget.habit.executionCount = _selectedDetailedFrequency!;
                    widget.habit.isCompleted = true;
                  } else {
                    widget.habit.isCompleted = false;
                  }
                  widget.habit.updateHabit();
                }
                _isEditing = !_isEditing;
              });
            }
          },
        ),
      ),
    );
  }

  String _getFrequencyString(ReminderFrequency frequency) {
    switch (frequency) {
      case ReminderFrequency.daily:
        return 'Daily';
      case ReminderFrequency.weekly:
        return 'Weekly';
      case ReminderFrequency.monthly:
        return 'Monthly';
    }
  }

  Widget _buildFrequencyDisplay() {
    if (_selectedFrequency == ReminderFrequency.monthly) {
      return Text('$_selectedDetailedFrequency times per month');
    } else if (_selectedFrequency == ReminderFrequency.weekly) {
      return Text('$_selectedDetailedFrequency times per week');
    } else {
      return const Text('Daily');
    }
  }
}
