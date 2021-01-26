import 'package:flutter/material.dart';
import 'package:top_accounts/core/enums/viewstate.dart';
import 'package:top_accounts/core/models/account.dart';
import 'package:top_accounts/core/viewmodels/account_model.dart';
import 'package:top_accounts/ui/shared/app_colors.dart';
import 'package:top_accounts/ui/shared/ui_helpers.dart';

import 'base_view.dart';

class AccountView extends StatefulWidget {
  final Account account;

  const AccountView({Key key, this.account}) : super(key: key);

  @override
  _AccountView createState() => _AccountView();
}

class _AccountView extends State<AccountView> {
  int depositAmount;
  int withdrawalAmount;
  int balance;

  final depositController = TextEditingController();
  final withdrawController = TextEditingController();

  String getFormattedDateTime(String dateTime) {
    List<String> dateArr = dateTime.split("T");
    return dateArr.elementAt(0) + ", " + dateArr.elementAt(1).substring(0, 8);
  }

  void _setBalanceAmount(int amount) {
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
              appBar: AppBar(
                title: Text('Account Details'),
                backgroundColor: Colors.deepPurple,
              ),
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
                          colors: [Colors.deepPurple, Colors.deepPurple]),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3.0,
                            offset: Offset(0.0, 2.0),
                            color: Color.fromARGB(80, 0, 0, 0))
                      ],
                      border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      UIHelper.verticalSpaceSmall(),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.account_balance_wallet,
                              size: 50.0,
                              color: Colors.white,
                            ),
                            UIHelper.horizontalSpaceSmall(),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    model.account.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 24.0,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Account Number: ${model.account.accountNumber}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16.0,
                                        color: Colors.white),
                                  )
                                ]),
                          ]),
                      UIHelper.verticalSpaceMedium(),
                      Text(
                        'Balance:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      Text(
                        'R $balance',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 24.0,
                            color: Colors.white),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Text(
                        'Overdraft:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      Text(
                        'R ${model.account.overdraft}',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 24.0,
                            color: Colors.white),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Text(
                        'Created:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      Text(
                        '${getFormattedDateTime(model.account.created)}',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 24.0,
                            color: Colors.white),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Text(
                        'Modified:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      Text(
                        '${getFormattedDateTime(model.account.modified)}',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 24.0,
                            color: Colors.white),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Text(
                        'Active:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      Text(
                        '${model.account.active}',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 24.0,
                            color: Colors.white),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 50.0,
                            child: RaisedButton.icon(
                              elevation: 8.0,
                              label: Text(
                                'Deposit',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.green)),
                              color: Colors.purple,
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
                                              hintText:
                                                  'Enter amount to deposit...',
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
                                                          depositController
                                                              .text),
                                                      model.depositIntAccount(
                                                          model.account.id,
                                                          depositAmount),
                                                      _setBalanceAmount(
                                                          balance +
                                                              depositAmount),
                                                      Navigator.pop(context),
                                                    }),
                                          ],
                                        ));
                              },
                              icon: Icon(Icons.monetization_on),
                            ),
                          ),
                          UIHelper.horizontalSpaceSmall(),
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 50.0,
                            child: RaisedButton.icon(
                              elevation: 8.0,
                              label: Text(
                                'Withdraw',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)),
                              color: Colors.purple,
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
                                              hintText:
                                                  'Enter amount to withdraw...',
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
                                                      withdrawalAmount =
                                                          int.parse(
                                                              withdrawController
                                                                  .text),
                                                      model.withdrawFromAccount(
                                                          model.account.id,
                                                          withdrawalAmount),
                                                      _setBalanceAmount(
                                                          balance -
                                                              withdrawalAmount),
                                                      Navigator.pop(context),
                                                    }),
                                          ],
                                        ));
                              },
                              icon: Icon(Icons.exit_to_app),
                            ),
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
