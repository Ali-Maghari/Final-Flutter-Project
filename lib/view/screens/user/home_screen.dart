import 'package:flutter/material.dart';
import 'package:my_teeth/view/widgets/home/day_reminder_widget.dart';
import 'package:my_teeth/view/widgets/home/day_widget.dart';
import 'package:provider/provider.dart';
import '../../../constants/strings.dart';
import '../../../controller/state_manager.dart';
import '../../../model/reminder/reminder.dart';
import '../../widgets/reminders/empty_reminder_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<StateManager>(context, listen: false).initDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.home),
        elevation: 2,
      ),
      body: Consumer<StateManager>(builder: (context, provider, child) {
        return FutureBuilder<List<Reminder>>(
            future: getUserReminders(context, provider),
            builder:
                (BuildContext context, AsyncSnapshot<List<Reminder>> snapshot) {
              return snapshot.data == null || snapshot.data!.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      child: const EmptyReminderWidget(),
                    )
                  : ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 12.0),
                      children: [
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return DayWidget(
                                  day: provider.arrDays[index],
                                  onTap: () {
                                    provider.setSelectedDay(
                                        provider.arrDays[index]);
                                  });
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 4.0);
                            },
                            itemCount: provider.arrDays.length,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return DayReminderWidget(
                                reminder: snapshot.data![index]);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8.0);
                          },
                          itemCount: snapshot.data!.length,
                        ),
                      ],
                    );
            });
      }),
    );
  }

  Future<List<Reminder>> getUserReminders(BuildContext context, StateManager provider) async {
    return await provider.getUserReminders();
  }
}
