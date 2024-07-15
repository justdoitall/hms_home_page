import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: FutureBuilder(
            future: rootBundle.loadString('assets/policy/policy.md'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return MarkdownWidget(
                  data: snapshot.data!,
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
    );
  }
}