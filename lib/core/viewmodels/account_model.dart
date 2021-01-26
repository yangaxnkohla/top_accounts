import 'package:top_accounts/core/enums/viewstate.dart';
import 'package:top_accounts/core/models/account.dart';
import 'package:top_accounts/core/services/api.dart';
import 'package:top_accounts/locator.dart';

import 'base_model.dart';

class AccountModel extends BaseModel {
  Api _api = locator<Api>();

  Account account;

  Future depositIntAccount(String accountId, int amount) async {
    setState(ViewState.Busy);
    await _api.depositAmountIntoAccount(accountId, amount);
    setState(ViewState.Idle);
  }

  Future withdrawFromAccount(String accountId, int amount) async {
    setState(ViewState.Busy);
    await _api.withdrawAmountFromAccount(accountId, amount);
    setState(ViewState.Idle);
  }

  Future getAccount(String accountId) async {
    setState(ViewState.Busy);
    account = await _api.getAccount(accountId);
    setState(ViewState.Idle);
  }
}