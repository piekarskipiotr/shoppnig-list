import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/add_delete_shopping_list_bloc.dart';
import 'package:shopping_list_app_flutter/feature/home/ui/archived_shopping_lists.dart';
import 'package:shopping_list_app_flutter/feature/home/ui/shopping_list_form.dart';
import 'package:shopping_list_app_flutter/feature/home/ui/shopping_lists.dart';
import 'package:shopping_list_app_flutter/network/api_service.dart';
import 'package:shopping_list_app_flutter/network/network_listener.dart';
import 'package:shopping_list_app_flutter/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    NetworkListener(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildTabViews(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        AppLocalizations.of(context)!.shopping_lists,
        style: AppThemes.appBarTitleStyle,
      ),
      bottom: TabBar(
        indicatorColor: Colors.white,
        tabs: [
          Tab(
              text: AppLocalizations.of(context)!.shopping_lists,
              icon: Icon(Icons.list)),
          Tab(
              text: AppLocalizations.of(context)!.archived_shopping_lists,
              icon: Icon(Icons.archive))
        ],
      ),
    );
  }

  Widget _buildTabViews() {
    return TabBarView(
      children: [
        ShoppingLists(),
        ArchivedShoppingLists(),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, bottom: 30.0),
      child: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(14.0),
                    topLeft: Radius.circular(14.0)),
              ),
              builder: (context) => SingleChildScrollView(
                    child: BlocProvider.value(
                      value:
                          BlocProvider.of<AddDeleteShoppingListBloc>(context),
                      child: ShoppingListForm(),
                    ),
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                  ));
        },
        tooltip: 'Add new shopping list',
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
