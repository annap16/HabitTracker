import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../classes/habit.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  AddHabitScreenState createState() => AddHabitScreenState();
}

class AddHabitScreenState extends State<AddHabitScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  ReminderFrequency _frequency = ReminderFrequency.daily;
  int? _detailedFrequency;
  Color _selectedColor = const Color(0xFFA8D5BA);

  final _formKey = GlobalKey<FormState>();

  String? _nameError;
  String? _detailedFrequencyError;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateName);
  }

  void _validateName() {
    setState(() {
      _nameError = (_nameController.text.trim().isEmpty)
          ? 'Habit Name cannot be empty'
          : null;
    });
  }

  void _validateDetailedFrequency(String value) {
    int? number = int.tryParse(value);
    setState(() {
      if (_frequency == ReminderFrequency.weekly) {
        _detailedFrequencyError = (number == null || number < 1 || number > 6)
            ? 'Please enter a number between 1 and 6'
            : null;
      } else if (_frequency == ReminderFrequency.monthly) {
        _detailedFrequencyError = (number == null || number < 1 || number > 29)
            ? 'Please enter a number between 1 and 29'
            : null;
      } else {
        _detailedFrequencyError = null;
      }
      if (_detailedFrequencyError == null) {
        _detailedFrequency = number;
      }
    });
  }

  bool _validateForm() {
    _validateName();
    if (_frequency == ReminderFrequency.weekly ||
        _frequency == ReminderFrequency.monthly) {
      _validateDetailedFrequency(_detailedFrequency?.toString() ?? '');
    }

    return _nameError == null && _detailedFrequencyError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Habit"),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Habit Name',
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  errorText: _nameError,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<ReminderFrequency>(
                value: _frequency,
                onChanged: (ReminderFrequency? newValue) {
                  setState(() {
                    _frequency = newValue!;
                    _detailedFrequencyError = null;
                    _detailedFrequency = null;
                  });
                },
                items: ReminderFrequency.values.map((ReminderFrequency freq) {
                  return DropdownMenuItem<ReminderFrequency>(
                    value: freq,
                    child: Text(freq.toString().split('.').last),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Frequency',
                  border: OutlineInputBorder(),
                ),
              ),
              if (_frequency == ReminderFrequency.weekly ||
                  _frequency == ReminderFrequency.monthly)
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: _frequency == ReminderFrequency.weekly
                        ? 'Weekly frequency (1-6)'
                        : 'Monthly frequency (1-29)',
                    errorText: _detailedFrequencyError,
                  ),
                  onChanged: _validateDetailedFrequency,
                ),
              const SizedBox(height: 20),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Select Habit Color:"),
                      IconButton(
                        icon: const Icon(Icons.color_lens),
                        onPressed: () {
                          _showColorPicker();
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  if (_validateForm()) {
                    Habit habit = Habit(
                      name: _nameController.text.trim(),
                      description: _descriptionController.text.trim(),
                      frequency: _frequency,
                      detailedFrequency: _detailedFrequency ?? 1,
                      color:
                          '#${_selectedColor.value.toRadixString(16).padLeft(8, '0').substring(2)}',
                    );
                    habit.addHabit().then((_) {
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }).catchError((e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    });
                  }
                },
                child: const Text('Add Habit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Pick a color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
