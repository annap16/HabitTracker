import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../classes/habit.dart';
import 'detailed_habit_screen.dart';
import '../widgets/upper_menu.dart';
import '../widgets/my_drawer.dart';

class AllHabitsScreen extends StatelessWidget {
  const AllHabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
        automaticallyImplyLeading: false,
      ),
      drawer: const MyDrawer(),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UpperMenu(),
              ],
            ),
          ),
          SliverFillRemaining(
            child: AllHabitsList(),
          ),
        ],
      ),
    );
  }
}

class AllHabitsList extends StatefulWidget {
  const AllHabitsList({super.key});

  @override
  AllHabitsListState createState() => AllHabitsListState();
}

class AllHabitsListState extends State<AllHabitsList> {
  bool sortAscending = true;

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
        const Padding(
          padding: EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'All Your habits:',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<Habit>>(
            stream: Habit.streamAllHabits(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No habits found'));
              }

              List<Habit> habits = snapshot.data!;

              habits.sort((a, b) => sortAscending
                  ? a.name.compareTo(b.name)
                  : b.name.compareTo(a.name));

              return ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  Habit habit = habits[index];
                  return Card(
                    color: colorFromHex(habit.color),
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
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailedHabitScreen(
                                habit: habit,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.chevron_right),
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
