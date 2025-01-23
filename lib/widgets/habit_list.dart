import 'package:flutter/material.dart';
import '../screens/detailed_habit_screen.dart';
import 'package:habit_tracker/classes/habit.dart';

class HabitList extends StatefulWidget {
  const HabitList({super.key});

  @override
  HabitListState createState() => HabitListState();
}

class HabitListState extends State<HabitList> {
  bool showCompleted = false;
  bool sortAscending = true;

  Color fromHex(String hexColor) {
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }

    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    return Color(int.parse('0x$hexColor'));
  }

  void _toggleSortOrder() {
    setState(() {
      sortAscending = !sortAscending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Sort alphabetically: ',
                style: TextStyle(fontSize: 16.0),
              ),
              IconButton(
                icon: Icon(
                  sortAscending ? Icons.arrow_downward : Icons.arrow_upward,
                  size: 24.0,
                ),
                onPressed: _toggleSortOrder,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                showCompleted ? 'Your completed habits:' : "Today's habits:",
                style: const TextStyle(fontSize: 16.0),
              ),
              Switch(
                value: showCompleted,
                onChanged: (value) {
                  setState(() {
                    showCompleted = value;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<List<Habit>>(
            stream: Habit.streamHabits(showCompleted: showCompleted),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No habits found'));
              }

              List<Habit> habits = snapshot.data!;

              habits.sort((a, b) {
                if (sortAscending) {
                  return a.name.compareTo(b.name);
                } else {
                  return b.name.compareTo(a.name);
                }
              });

              return ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  Habit habit = habits[index];
                  return Card(
                    color: habit.isCompleted
                        ? const Color(0xFFB0B0B0)
                        : fromHex(habit.color),
                    child: ListTile(
                      title: Text(
                        habit.name,
                        style: TextStyle(
                          color: habit.isCompleted
                              ? Colors.grey.shade800
                              : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        'Frequency: ${habit.frequency.toString().split('.').last}',
                      ),
                      leading: habit.isCompleted
                          ? Checkbox(
                              value: habit.isCompleted,
                              onChanged: (bool? value) async {
                                await habit.toggleCompletion(context);
                                setState(() {});
                              },
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 241, 242, 243),
                                shape: CircleBorder(),
                              ),
                              child:
                                  const Icon(Icons.check, color: Colors.green),
                              onPressed: () async {
                                if (habit.executionCount <
                                    habit.detailedFrequency) {
                                  habit.executionCount++;
                                  if (habit.executionCount ==
                                      habit.detailedFrequency) {
                                    habit.isCompleted = true;
                                  }
                                  await habit.updateHabit();
                                  setState(() {});
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Task already completed!'),
                                    ),
                                  );
                                }
                              },
                            ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: habit.detailedFrequency > 0
                                    ? habit.executionCount /
                                        habit.detailedFrequency
                                    : 0,
                                backgroundColor: Colors.grey.shade300,
                                color: Colors.green,
                              ),
                              Text(
                                '${((habit.executionCount / habit.detailedFrequency) * 100).toStringAsFixed(0)}%',
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailedHabitScreen(habit: habit),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
