import 'package:flutter/material.dart';
import 'package:top_accounts/core/enums/viewstate.dart';
import 'package:top_accounts/core/models/account.dart';
import 'package:top_accounts/core/viewmodels/account_model.dart';
import 'package:top_accounts/ui/shared/app_colors.dart';
import 'package:top_accounts/ui/shared/ui_helpers.dart';

import 'base_view.dart';

class AccountView extends StatelessWidget {
  final Account account;

  AccountView({this.account});

  final depositController = TextEditingController();
  final withdrawController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int depositAmount;
    int withdrawalAmount;
    return BaseView<AccountModel>(
      onModelReady: (model) => model.getAccount(account.id),
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blueGrey, Colors.grey]),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3.0,
                      offset: Offset(0.0, 2.0),
                      color: Color.fromARGB(80, 0, 0, 0))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                UIHelper.verticalSpaceLarge(),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.account_balance_wallet, size: 50.0, color: Colors.white,),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              model.account.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 24.0, color: Colors.white),
                            ),
                            Text(
                              'Account Number: ${model.account.accountNumber}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.white),
                            )
                          ]),
                    ]),
                UIHelper.verticalSpaceMedium(),
                Text(
                  'Balance: ${model.account.balance}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.white),
                ),
                Text(
                  'Overdraft: ${model.account.overdraft}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.white),
                ),
                Text(
                  'Created: ${model.account.created}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.white),
                ),
                Text(
                  'Modified: ${model.account.modified}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.white),
                ),
                Text(
                  'Active: ${model.account.active}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.white),
                ),
                Row(
                  children: <Widget>[
                    FlatButton.icon(
                      label: Text(
                        'Deposit',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text('Deposit'),
                                  content: TextField(
                                    controller: depositController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter amount to deposit...',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                        child: const Text('Cancel'),
                                        onPressed: () =>
                                            Navigator.pop(context)),
                                    FlatButton(
                                        child: const Text('Done'),
                                        onPressed: () => {
                                              depositAmount = int.parse(
                                                  depositController.text),
                                              model.depositIntAccount(
                                                  model.account.id,
                                                  depositAmount),
                                              Navigator.pop(context),
                                            }),
                                  ],
                                ));
                      },
                      icon: Icon(Icons.monetization_on),
                    ),
                    UIHelper.horizontalSpaceSmall(),
                    FlatButton.icon(
                      label: Text(
                        'Withdraw',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text('Withdraw'),
                                  content: TextField(
                                    controller: withdrawController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter amount to withdraw...',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                        child: const Text('Cancel'),
                                        onPressed: () =>
                                            Navigator.pop(context)),
                                    FlatButton(
                                        child: const Text('Done'),
                                        onPressed: () => {
                                              withdrawalAmount = int.parse(withdrawController.text),
                                              model.withdrawFromAccount(model.account.id, withdrawalAmount),
                                              Navigator.pop(context),
                                            }),
                                  ],
                                ));
                      },
                      icon: Icon(Icons.exit_to_app),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
