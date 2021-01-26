import 'package:flutter/material.dart';
import 'package:top_accounts/core/models/account.dart';
import 'package:top_accounts/ui/shared/ui_helpers.dart';

class AccountListItem extends StatelessWidget {
  final Account account;
  final Function onTap;

  const AccountListItem({this.account, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
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
          children: <Widget>[
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.account_balance_wallet, size: 60.0, color: Colors.white,),
                  UIHelper.horizontalSpaceSmall(),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          account.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 24.0, color: Colors.white),
                        ),
                        Text(
                          'Balance: R ${account.balance} 💰',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 24.0, color: Colors.white),
                        )
                      ]),
                ]),
          ],
        ),
      ),
    );
  }
}
