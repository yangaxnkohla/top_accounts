import 'package:flutter/material.dart';
import 'package:top_accounts/core/enums/viewstate.dart';
import 'package:top_accounts/core/models/account.dart';
import 'package:top_accounts/core/viewmodels/home_model.dart';
import 'package:top_accounts/ui/shared/app_colors.dart';
import 'package:top_accounts/ui/shared/text_styles.dart';
import 'package:top_accounts/ui/shared/ui_helpers.dart';
import 'package:top_accounts/ui/widgets/accountlist_item.dart';

import 'base_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String id = 'UZyMgwSApiN0b148VDrZSAeWkfb2';
    String shortId = id.substring(0, 3) +
        '***' +
        id.substring(id.length - 3, id.length); // shorted id for 'welcome' text
    return BaseView<HomeModel>(
      onModelReady: (model) => model.getAccounts(id),
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UIHelper.verticalSpaceLarge(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Welcome $shortId',
                      style: headerStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text('Here are all your accounts',
                        style: subHeaderStyle),
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Expanded(child: getAccountsUi(model.accounts)),
                ],
              ),
        floatingActionButton: model.state == ViewState.Busy
            ? Center()
            : FloatingActionButton(
                onPressed: () => {
                  // add new account
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('Create New Account'),
                            content:
                                Text('Would you like to create a new account?'),
                            actions: <Widget>[
                              FlatButton(
                                  child: const Text('Cancel'),
                                  onPressed: () => Navigator.pop(context)),
                              FlatButton(
                                  child: const Text('Yes'),
                                  onPressed: () => {
                                        model.createAccount(id).whenComplete(() => {
                                          Navigator.pop(context),
                                          model.getAccounts(id),
                                          print('Account created...')
                                        }),
                                      }),
                            ],
                          )),
                },
                child: Icon(Icons.add_circle),
                backgroundColor: Colors.blueAccent,
              ),
      ),
    );
  }

  Widget getAccountsUi(List<Account> accounts) => ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) => AccountListItem(
            account: accounts[index],
            onTap: () {
              Navigator.pushNamed(context, 'account',
                  arguments: accounts[index]);
            },
          ));
}
