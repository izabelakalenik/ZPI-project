import 'package:flutter/material.dart';
import '../../styles/layouts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(child: const PolicyScreenContent());
  }
}

class PolicyScreenContent extends StatelessWidget {
  const PolicyScreenContent({super.key});


  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(text: localizations.privacy_policy),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: rootBundle.loadString('assets/markdown/privacy_policy.md'),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error loading policy'));
            }
            if (snapshot.hasData) {
              return Markdown(
                data: snapshot.data!,
              );
            }
            return const Center(child: Text('No content available'));
          },
        ),
      ),
    );
  }
}
