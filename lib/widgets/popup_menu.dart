import 'package:cariera/models/job_model.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({Key? key, this.jobModel, this.type, this.model, this.url})
      : super(key: key);
  final JobModel? jobModel;
  final String? type, url;
  final dynamic model;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'delete',
            child: const Text('Delete').translate(),
            onTap: () async {
              model.deleteListing(jobModel!.id.toString(), type, url);
            },
          )
        ];
      },
      onSelected: (String value) {},
    );
  }
}
