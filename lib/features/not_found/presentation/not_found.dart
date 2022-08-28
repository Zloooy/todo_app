import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
    
class NotFound extends StatelessWidget {

  const NotFound({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
                elevation: 0,
                toolbarHeight: 56,
                leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close)),
              ),
      body: Center(
        child: Text(AppLocalizations.of(context)!.addressNotFound),
      ),
    );
  }
}