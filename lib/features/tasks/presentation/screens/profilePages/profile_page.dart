import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late TextEditingController nameController;
  late TextEditingController proffesionController;
  late TextEditingController emailController;
  late CalendarFormat _calendarFormat;
  DateTime dob = DateTime.now();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    proffesionController = TextEditingController();
    emailController = TextEditingController();
    _calendarFormat = CalendarFormat.twoWeeks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userval = ref.watch(userStateProvider);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            pinned: false,
            expandedHeight: 120,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                "My Profile",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              centerTitle: true,
            ),
            leading: IconButton(
              style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(Colors.white),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Appcolors.brandColor,
              ),
            ),
            backgroundColor: Appcolors.brandColor,
          ),
          SliverToBoxAdapter(
              child: Container(
                  decoration: const BoxDecoration(
                    color: Appcolors.brandColor,
                  ),
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                      ),
                      child: userval.when(
                        data: (user) {
                          setState(() {
                            nameController.text =
                                user!.username == null ? "" : user.username!;
                            proffesionController.text =
                                user.profession == null ? "" : user.profession!;
                            emailController.text = user.email;
                            dob = user.dob == null ? DateTime.now() : user.dob!;
                          });
                          return Form(
                              key: formKey,
                              child: Column(children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 50,
                                    backgroundImage: user!.userPfp == null
                                        ? const AssetImage(
                                            'lib/core/assets/images/default_profile.png')
                                        : NetworkImage(user.userPfp!),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "name",
                                    style: TextStyle(
                                        color: Appcolors.brandColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Name cannot be empty";
                                      }
                                      return null;
                                    },
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        borderSide: BorderSide(
                                          color: const Color(0xff006EE9)
                                              .withOpacity(0.06),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: const Color(0xff006EE9)
                                                .withOpacity(0.06),
                                            width: 2),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: const Color(0xff006EE9)
                                              .withOpacity(0.06),
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      hintText: "Name",
                                      hintStyle: const TextStyle(
                                          color: Appcolors.subHeaderColor),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Proffesion",
                                    style: TextStyle(
                                        color: Appcolors.brandColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: proffesionController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        borderSide: BorderSide(
                                          color: const Color(0xff006EE9)
                                              .withOpacity(0.06),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: const Color(0xff006EE9)
                                                .withOpacity(0.06),
                                            width: 2),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: const Color(0xff006EE9)
                                              .withOpacity(0.06),
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      hintText: "Proffesion ..",
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Date of birth",
                                    style: TextStyle(
                                        color: Appcolors.brandColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return calendarDialog(context);
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff006EE9)
                                                  .withOpacity(0.06)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today,
                                              color: Appcolors.brandColor,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              DateFormat('MMM-dd-yyyy')
                                                  .format(dob),
                                              style: const TextStyle(
                                                  color: Appcolors.textColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]));
                        },
                        error: (err, stk) => const Text(
                          "Error",
                          style: TextStyle(color: Colors.white),
                        ),
                        loading: () => const CircularProgressIndicator(),
                      ))))
        ]));
  }

  AlertDialog calendarDialog(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.84,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TableCalendar(
                selectedDayPredicate: (day) {
                  return isSameDay(dob, day);
                },
                calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                        color: Colors.blueGrey, shape: BoxShape.circle),
                    selectedDecoration: BoxDecoration(
                      color: Appcolors.brandColor,
                      shape: BoxShape.circle,
                    )),
                daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: Appcolors.textColor,
                        fontWeight: FontWeight.w500),
                    weekendStyle: TextStyle(
                        color: Appcolors.brandColor,
                        fontWeight: FontWeight.w500)),
                weekendDays: const [DateTime.friday, DateTime.saturday],
                onFormatChanged: (newFormat) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 300,
                                  width: 200,
                                  child: YearPicker(
                                      firstDate: DateTime.utc(1900),
                                      lastDate: DateTime.utc(2030),
                                      selectedDate: dob,
                                      onChanged: (year) {
                                        setState(() {
                                          dob = DateTime.utc(
                                              year.year, dob.month, dob.day);
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ));
                },
                calendarFormat: _calendarFormat,
                headerStyle: const HeaderStyle(
                    leftChevronIcon: Icon(
                      Icons.arrow_left_sharp,
                      color: Appcolors.brandColor,
                      size: 40,
                    ),
                    rightChevronIcon: Icon(
                      Icons.arrow_right_sharp,
                      color: Appcolors.brandColor,
                      size: 40,
                    ),
                    formatButtonVisible: true,
                    formatButtonTextStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                    formatButtonDecoration: BoxDecoration(
                        color: Appcolors.brandColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    titleTextStyle: TextStyle(
                        color: Appcolors.brandColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                focusedDay: dob,
                firstDay: DateTime.utc(2010, 01, 01),
                lastDay: DateTime.utc(2030, 12, 12),
                onDaySelected: (selectedDay, focusDay) {
                  setState(() {
                    dob = selectedDay;
                    focusDay = selectedDay;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }
}
