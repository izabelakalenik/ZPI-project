import 'package:flutter/material.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/contact_info.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  Future<void> _submitReport() async {
    // it will be used later:)

    // String description = _descriptionController.text;
    // String contact = _contactController.text;

    // Save report to Firestore
    // await FirebaseFirestore.instance.collection('reports').add({
    //   'description': description,
    //   'contact': contact,
    //   'timestamp': FieldValue.serverTimestamp(),
    // });
    debugPrint("Report has been submitted.");
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return MainLayout(
        child: Scaffold(
            appBar: CustomAppBar(text: localizations.report_problem_title, height: 100),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(children: [
                SectionCard(
                  title: localizations.report_problem_text_us,
                  items: [
                    Text(
                      localizations.report_problem_description,
                      style: theme.textTheme.bodyLarge,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      labelText: localizations.report_problem_issue_description_label,
                      controller: _descriptionController,
                      hintText: localizations.report_problem_issue_description,
                      maxLines: 5,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      labelText: localizations.report_problem_contact_info_label,
                      controller: _contactController,
                      hintText: localizations.report_problem_contact_info,
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      onPressed: _submitReport,
                      text: Text(localizations.report_problem_submit),
                    ),
                  ],
                ),
                ContactInfo(),
              ]),
            )));
  }
}
