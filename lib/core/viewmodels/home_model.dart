import 'package:top_accounts/core/enums/viewstate.dart';
import 'package:top_accounts/core/models/account.dart';
import 'package:top_accounts/core/services/api.dart';
import 'package:top_accounts/locator.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  Api _api = locator<Api>();

  List<Account> accounts;

  Future getAccounts(String userId) async {
    setState(ViewState.Busy);
    accounts = await _api.getAccountsForUser(userId);
    setState(ViewState.Idle);
  }

  Future createAccount(String userId) async {
    setState(ViewState.Busy);
    await _api.addNewAccountForUser(userId);
    setState(ViewState.Idle);
  }
}
