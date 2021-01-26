import 'package:flutter/material.dart';
import 'package:top_accounts/core/enums/viewstate.dart';
import 'package:top_accounts/core/models/account.dart';
import 'package:top_accounts/core/viewmodels/account_model.dart';
import 'package:top_accounts/ui/shared/app_colors.dart';
import 'package:top_accounts/ui/shared/ui_helpers.dart';

import 'base_view.dart';

class AccountView extends StatefulWidget {
  final Account account;

  const AccountView ({ Key key, this.account }): super(key: key);

  @override
  _AccountView createState() => _AccountView();
}

class _AccountView extends State<AccountView> {
  int depositAmount;
  int withdrawalAmount;
  int balance;

  final depositController = TextEditingController();
  final withdrawController = TextEditingController();

  String getFormattedDateTime(String dateTime){
    List<String> dateArr = dateTime.split("T");
    return dateArr.elementAt(0) + ", " + dateArr.elementAt(1).substring(0,8);
  }

  void _setBalanceAmount(int amount){
    setState(() {
      this.balance = amount;
    });
  }

  @override
  void initState() {
     this.balance = widget.account.balance;
  }

  @override
  Widget build(BuildContext context) {

    return BaseView<AccountModel>(
      onModelReady: (model) => model.getAccount(widget.account.id),
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
                      UIHelper.horizontalSpaceSmall(),
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
                  'Balance: R $balance',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.white),
                ),
                UIHelper.verticalSpaceSmall(),
                Text(
                  'Overdraft: R ${model.account.overdraft}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.white),
                ),
                UIHelper.verticalSpaceSmall(),
                Text(
                  'Created: ${getFormattedDateTime(model.account.created)}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.white),
                ),
                UIHelper.verticalSpaceSmall(),
                Text(
                  'Modified: ${getFormattedDateTime(model.account.modified)}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.white),
                ),
                UIHelper.verticalSpaceSmall(),
                Text(
                  'Active: ${model.account.active}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.white),
                ),
                UIHelper.verticalSpaceSmall(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton.icon(
                      minWidth: 175.0,
                      height: 50.0,
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
                                              depositAmount = int.parse(depositController.text),
                                              model.depositIntAccount(model.account.id, depositAmount),
                                              _setBalanceAmount(balance + depositAmount),
                                              Navigator.pop(context),
                                            }),
                                  ],
                                ));
                      },
                      icon: Icon(Icons.monetization_on),
                    ),
                    UIHelper.horizontalSpaceSmall(),
                    FlatButton.icon(
                      minWidth: 150.0,
                      height: 50.0,
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
                                              _setBalanceAmount(balance - withdrawalAmount),
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
