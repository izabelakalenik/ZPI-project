import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/check_login_status.dart';
import '../../widgets/contact_info.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus(context);
  }

  void _feedback(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    BetterFeedback.of(context).show(
          (UserFeedback feedback) async {
        try {
          final attachmentPath = await _writeScreenshotToStorage(feedback.screenshot);
          final email = Email(
            attachmentPaths: [attachmentPath],
            body: feedback.text,
            recipients: [localizations.moviepopapp_email],
            subject: feedback.text.split(' ').take(7).toList().join(' '),
          );

          await FlutterEmailSender.send(email);
        } catch (e) {
          debugPrint("Error occured during sending emai.");
        }
      });
  }

  Future<String> _writeScreenshotToStorage(Uint8List screenshot) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/feedback.png';
    final file = File(filePath);
    await file.writeAsBytes(screenshot);
    return filePath;
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
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 20),
                    Button(
                      onPressed: () => _feedback(context),
                      text:  Text(localizations.report_problem),
                      width: 350,
                    ),
                    SizedBox(height: 20),
                    Text(
                      localizations.report_problem_instructions,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ContactInfo(),
              ]),
            )));
  }
}
