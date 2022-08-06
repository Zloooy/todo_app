import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/core/presentation/themes/extensions/additional_colors.dart';
import 'package:todo_app/features/task_edit/presentation/widgets/dropdown_list.dart';

const testText =
    '''Фьючерсный контракт — это договор между покупателем и продавцом о покупке/продаже какого-то актива в будущем. Стороны заранее оговаривают, через какой срок и по какой цене состоится сделка.
  Например, сейчас одна акция «Лукойла» стоит около 5700 рублей. Фьючерс на акции «Лукойла» — это, например, договор между покупателем и продавцом о том, что покупатель купит акции «Лукойла» у продавца по цене 5700 рублей через 3 месяца. При этом не важно, какая цена будет у акций через 3 месяца: цена сделки между покупателем и продавцом все равно останется 5700 рублей. Если реальная цена акции через три месяца не останется прежней, одна из сторон в любом случае понесет убытки.''';

class TaskEdit extends StatefulWidget {
  const TaskEdit({Key? key}) : super(key: key);

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  late final ScrollController _controller;
  double offset = 0;
  bool get contentUnderAppBar => offset > 16;
  void scrollListener() {
    print("offset ${_controller.offset}");
    setState(() {
      offset = _controller.offset;
    });
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contentUnderAppbarTheme =
        Theme.of(context).appBarTheme.copyWith(elevation: 0);
    final noContentUnderAppbarTheme = Theme.of(context).appBarTheme;
    final AdditionalColors addititonalColors =
        Theme.of(context).extension<AdditionalColors>()!;
    return Theme(
        data: Theme.of(context).copyWith(
          appBarTheme: contentUnderAppBar
              ? contentUnderAppbarTheme
              : noContentUnderAppbarTheme,
        ),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 56,
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close)),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text(
                  // TODO move to themes
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    height: 1.7,
                    fontWeight: FontWeight.w500,
                  ),
                  AppLocalizations.of(context)!.save.toUpperCase(),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            controller: _controller,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child:
                              //Expanded(child:
                              Text(testText)
                          //),
                          )),
                  // DropdownButtonHideUnderline(
                  //   child: ButtonTheme(
                  //     alignedDropdown: true,
                  //     child: SizedBox(
                  //       height: 64,
                  //       child: DropdownButton<String>(
                  //         alignment: Alignment.topCenter,
                  //         isDense: false,
                  //         isExpanded: false,
                  //         iconSize: 0,
                  //         onChanged: (_){},
                  //         items: [
                  //           DropdownMenuItem<String>(child: const Text('aaa'), value: 'aaa',),
                  //           DropdownMenuItem<String>(child: const Text('bbb'), value: 'bbb',),
                  //         ],
                  //         hint: //Text('lslsl')
                  DropdownList<String>(
                    items: const <String>["aaa", "bbb"],
                    itemBuilder: (BuildContext context, String str) => Material(
                      child: ListTile(title: Text(str)),
                    ),
                    child: SizedBox(
                      height: 64,
                      width: MediaQuery.of(context).size.width - 52,
                      child: ListTile(
                        title: Text(AppLocalizations.of(context)!.importance),
                        subtitle: Text('Нет'),
                      ),
                    ),
                  ),
                  //          ),
                  //        ),
                  //      ),
                  //    ),
                  const Divider(),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.makeUpTo),
                    subtitle: Text(
                        style: TextStyle(color: addititonalColors.blue),
                        '2 июня 2021'),
                    trailing: Switch(
                      value: true,
                      onChanged: (_) {},
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(color: addititonalColors.red, Icons.delete),
                    title: Text(
                        style: TextStyle(color: addititonalColors.red),
                        AppLocalizations.of(context)!.delete),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
