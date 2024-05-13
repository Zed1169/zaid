import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:techbot/src/config/theme/theme.dart';
import 'package:techbot/src/core/model/form_model.dart';
import 'package:techbot/src/core/model/task.dart';
import 'package:techbot/src/core/widget/buttons/buttons.dart';
import 'package:techbot/src/core/widget/froms/form_model.dart';
import 'package:techbot/src/featuers/schulde/controller/task_controller.dart';
import 'package:techbot/test/test.dart';

class TaskFormPage extends StatefulWidget {
  const TaskFormPage({required this.userEmail, super.key});
  final String userEmail;
  @override
  State<TaskFormPage> createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.put(TaskController());

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: SingleChildScrollView(
            child: Form(
              key: taskController.addFormKey,
              child: Column(
                children: [
                  FormWidget(
                    textForm: FormModel(
                        controller: taskController.taskNameController,
                        enableText: false,
                        hintText: " task name ",
                        icon: const Icon(Icons.assignment_add),
                        invisible: false,
                        validator: (task) =>
                            taskController.validateDescription(task),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: [],
                        onTap: null),
                  ),
                  const Gap(35),
                        FormWidget(
                    textForm: FormModel(
                        controller: taskController.descriptionController,
                        enableText: false,
                        hintText: " task description ",
                        icon: const Icon(Icons.assignment_add),
                        invisible: false,
                        validator: (description) =>
                            taskController.validateDescription(description),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: [],
                        onTap: null),
                  ),
                  const Gap(35),
                  FormWidget(
                    textForm: FormModel(
                      controller: taskController.startDateController,
                      enableText: true,
                      hintText: "start date",
                      icon: const Icon(Icons.date_range_outlined),
                      invisible: false,
                      validator: (username) =>
                          taskController.validateDescription(username),
                      type: TextInputType.datetime,
                      onChange: null,
                      inputFormat: [],
                      onTap: () => _selectDate(
                          context, taskController.startDateController),
                    ),
                  ),
                  const Gap(35),
                  FormWidget(
                    textForm: FormModel(
                      controller: taskController.endDateController,
                      enableText: true,
                      hintText: "End date",
                      icon: const Icon(Icons.date_range_outlined),
                      invisible: false,
                      validator: (username) =>
                          taskController.validateDescription(username),
                      type: TextInputType.datetime,
                      onChange: null,
                      inputFormat: [],
                      onTap: () => _selectDate(
                          context, taskController.endDateController),
                    ),
                  ),
                  const Gap(35),
                  FormWidget(
                    textForm: FormModel(
                      controller: taskController.pdfPathController,
                      enableText: true,
                      hintText: "chose your pdf",
                      icon: const Icon(Icons.file_copy),
                      invisible: false,
                      validator: (username) =>
                          taskController.validateDescription(username),
                      type: TextInputType.datetime,
                      onChange: null,
                      inputFormat: [],
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                        );

                        if (result != null) {
                          File file = File(result.files.single.path!);
                          String fileName =
                              'pdf_${DateTime.now().millisecondsSinceEpoch}.pdf';

                          try {
                            await firebase_storage.FirebaseStorage.instance
                                .ref('pdfs/$fileName')
                                .putFile(file);
                            String downloadURL = await firebase_storage
                                .FirebaseStorage.instance
                                .ref('pdfs/$fileName')
                                .getDownloadURL();

                            taskController.pdfPathController.text =
                                downloadURL;
                          } catch (e) {
                            print('Error uploading PDF: $e');
                          }
                        } else {
                          // User canceled the picker
                        }
                      },
                    ),
                  ),
                 
                  // Add more TextFields for other mission fields if needed
                   SelectUser(names:taskController.names ,),
                  const Gap(35),
               Buttons.   formscontainer(
                      title: 'submit',
                      onTap: () => taskController.onAdd(Task(taskName: taskController.taskNameController.text, descrition: taskController.descriptionController.text, startDate: taskController.startDateController.text, endDate: taskController.endDateController.text, users: taskController.names, userEmail: widget.userEmail, pdfPath: taskController.pdfPathController.text)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Restrict to today's date
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      controller.text = formattedDate;
    }
  }
}
