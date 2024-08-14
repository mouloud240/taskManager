import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/usecases/updateInfoUsecase.dart';
import 'package:task_manager/features/auth/domain/usecases/update_image.dart';
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
  final ImagePicker _imagePicker = ImagePicker();
  final RegExp mailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  late DateTime dob;
  late XFile? selectedImage;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    proffesionController = TextEditingController();
    emailController = TextEditingController();
    _calendarFormat = CalendarFormat.twoWeeks;
    selectedImage = null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserAuthRepositoryImplementation userAuthRepositoryImplementation =
        UserAuthRepositoryImplementation(RemoteAuth(ref: ref));
    final userval = ref.watch(userStateProvider);
    final fireAuth = FirebaseAuth.instance;
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
                      height: MediaQuery.of(context).size.height * 0.8,
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
                            emailController.text = user!.email;
                            dob = user.dob == null ? DateTime.now() : user.dob!;
                          });
                          return Form(
                              key: formKey,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        selectedImage =
                                            await _imagePicker.pickImage(
                                                source: ImageSource.gallery);
                                        setState(() {});

                                        // showDialog(
                                        //     context: context,
                                        //     builder: (context) => AlertDialog(
                                        //           content: Image.file(File(
                                        //               selectedImage!.path)),
                                        //         ));
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: 50,
                                        backgroundImage: selectedImage == null
                                            ? user!.userPfp == null
                                                ? const AssetImage(
                                                    'lib/core/assets/images/default_profile.png')
                                                : NetworkImage(user.userPfp!)
                                            : FileImage(
                                                    File(selectedImage!.path))
                                                as ImageProvider,
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
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                            borderSide: BorderSide(
                                              color: const Color(0xff006EE9)
                                                  .withOpacity(0.06),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                            borderSide: BorderSide(
                                              color: const Color(0xff006EE9)
                                                  .withOpacity(0.06),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
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
                                              return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  content: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.84,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TableCalendar(
                                                          selectedDayPredicate:
                                                              (day) {
                                                            return isSameDay(
                                                                dob, day);
                                                          },
                                                          calendarStyle:
                                                              const CalendarStyle(
                                                                  todayDecoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                  selectedDecoration:
                                                                      BoxDecoration(
                                                                    color: Appcolors
                                                                        .brandColor,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  )),
                                                          daysOfWeekStyle: const DaysOfWeekStyle(
                                                              weekdayStyle: TextStyle(
                                                                  color: Appcolors
                                                                      .textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              weekendStyle: TextStyle(
                                                                  color: Appcolors
                                                                      .brandColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          weekendDays: const [
                                                            DateTime.friday,
                                                            DateTime.saturday
                                                          ],
                                                          onFormatChanged:
                                                              (newFormat) {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                          content:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
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
                                                                                        user!.dob = DateTime.utc(year.year, dob.month, dob.day);
                                                                                        dob = DateTime.utc(year.year, dob.month, dob.day);
                                                                                        Navigator.of(context).pop();
                                                                                      });
                                                                                    }),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ));
                                                          },
                                                          headerStyle:
                                                              const HeaderStyle(
                                                                  leftChevronIcon:
                                                                      Icon(
                                                                    Icons
                                                                        .arrow_left_sharp,
                                                                    color: Appcolors
                                                                        .brandColor,
                                                                    size: 40,
                                                                  ),
                                                                  rightChevronIcon:
                                                                      Icon(
                                                                    Icons
                                                                        .arrow_right_sharp,
                                                                    color: Appcolors
                                                                        .brandColor,
                                                                    size: 40,
                                                                  ),
                                                                  titleCentered:
                                                                      true,
                                                                  formatButtonVisible:
                                                                      true,
                                                                  formatButtonTextStyle: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight: FontWeight
                                                                          .w500),
                                                                  formatButtonDecoration: BoxDecoration(
                                                                      color: Appcolors
                                                                          .brandColor,
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              10))),
                                                                  titleTextStyle: TextStyle(
                                                                      color: Appcolors
                                                                          .brandColor,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                          focusedDay: dob,
                                                          firstDay:
                                                              DateTime.utc(
                                                                  1900, 01, 01),
                                                          lastDay: DateTime.utc(
                                                              2030, 12, 12),
                                                          onDaySelected:
                                                              (selectedDay,
                                                                  focusDay) {
                                                            setState(() {
                                                              user!.dob =
                                                                  selectedDay;

                                                              dob = selectedDay;

                                                              focusDay =
                                                                  selectedDay;
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ));
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
                                                      color:
                                                          Appcolors.textColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "email",
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
                                          if (val == null) {
                                            return "Email cannot be Empty";
                                          }
                                          if (!mailRegex.hasMatch(val)) {
                                            return "Email not valid";
                                          }

                                          return null;
                                        },
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                            borderSide: BorderSide(
                                              color: const Color(0xff006EE9)
                                                  .withOpacity(0.06),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                          hintText: "Email",
                                          hintStyle: const TextStyle(
                                              color: Appcolors.subHeaderColor),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            fixedSize: WidgetStateProperty.all(Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06)),
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Appcolors.brandColor
                                                        .withOpacity(0.9)),
                                            shape: WidgetStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(15)))),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            await Updateinfousecase(
                                                    userAuthRepository:
                                                        userAuthRepositoryImplementation)
                                                .call(proffesionController.text,
                                                    nameController.text, dob);
                                            if (selectedImage == null) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const updateProfileSucces());
                                              return;
                                            }
                                            final res = UpdateImage(
                                                    userAuthRepositoryImplementation)
                                                .call(File(selectedImage!.path),
                                                    user!.uid as String);
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return FutureBuilder(
                                                      future: res,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .none) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                Colors.white,
                                                            content: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.84,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.3,
                                                              child: Column(
                                                                children: [
                                                                  const Text(
                                                                    "No connection",
                                                                    style: TextStyle(
                                                                        color: Appcolors
                                                                            .brandColor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  ElevatedButton(
                                                                      style: ButtonStyle(
                                                                          fixedSize: WidgetStatePropertyAll(Size(
                                                                              MediaQuery.of(context).size.width *
                                                                                  0.6,
                                                                              MediaQuery.of(context).size.height *
                                                                                  0.07)),
                                                                          backgroundColor: const WidgetStatePropertyAll(Appcolors
                                                                              .brandColor),
                                                                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  15)))),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          const Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          "Back",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        } else if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                Colors.white,
                                                            content: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.84,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.3,
                                                              child: Column(
                                                                children: [
                                                                  const CircularProgressIndicator
                                                                      .adaptive(),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  ElevatedButton(
                                                                      style: ButtonStyle(
                                                                          fixedSize: WidgetStatePropertyAll(Size(
                                                                              MediaQuery.of(context).size.width *
                                                                                  0.6,
                                                                              MediaQuery.of(context).size.height *
                                                                                  0.07)),
                                                                          backgroundColor: const WidgetStatePropertyAll(Appcolors
                                                                              .brandColor),
                                                                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  15)))),
                                                                      onPressed:
                                                                          () {
                                                                        //todo Implement canceling
                                                                      },
                                                                      child:
                                                                          const Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          "cancel",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        } else if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          return const updateProfileSucces();
                                                        }
                                                        return const Text(
                                                            'Unkown error');
                                                      });
                                                });
                                          }
                                        },
                                        child: const Text(
                                          "Save",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ))
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
}

class updateProfileSucces extends StatefulWidget {
  const updateProfileSucces({
    super.key,
  });

  @override
  State<updateProfileSucces> createState() => _updateProfileSuccesState();
}

class _updateProfileSuccesState extends State<updateProfileSucces>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.14,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Appcolors.brandColor.withOpacity(_animation.value),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 45,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Text(
              "New profile has been \nsuccessfully updated",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Appcolors.brandColor),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(
                        MediaQuery.of(context).size.width * 0.6,
                        MediaQuery.of(context).size.height * 0.07)),
                    backgroundColor:
                        const WidgetStatePropertyAll(Appcolors.brandColor),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)))),
                onPressed: () {
                  Navigator.of(context).pushNamed("home");
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Back",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
