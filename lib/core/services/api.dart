import 'dart:convert';

import 'package:top_accounts/core/models/account.dart';
import 'package:http/http.dart' as http;

class Api {
  static const endpoint = 'http://us-central1-momentumtest-bfdef.cloudfunctions.net/app/api/v1/account';

  var client = new http.Client();

  Future<List<Account>> getAccountsForUser(String userId) async {

    var accounts = List<Account>();
    // Get user accounts for id
    var response = await client.get('$endpoint/findByUserId?userId=$userId');

    // parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // loop and convert each item to Post
    for (var account in parsed) {
      accounts.add(Account.fromJson(account));
    }

    print('Status: ${response.statusCode}');
    print(response.body.toString());
    return accounts;
  }

  Future<Account> getAccount(String accountId) async {

    // get account using account id
    var response = await client.get('$endpoint/$accountId');

    // Convert and return
    print('Status: ${response.statusCode}');
    print(response.body.toString());
    return Account.fromJson(json.decode(response.body));
  }

  Future<bool> addNewAccountForUser(String userId) async {

    // create account using user id
    var response = await client.put('$endpoint/create?userId=$userId',
        headers: { 'Content-Type': 'application/json; charset=utf-8'},);

    // check if the account has been created
    print('Status: ${response.statusCode}');
    print(response.body.toString());
    return response.statusCode == 201;
  }

  Future<bool> depositAmountIntoAccount(String accountId, int amount) async {

    // deposit amount into account with provided id
    var response = await client.post('$endpoint/deposit/$accountId?amount=$amount',
      headers: { 'Content-Type': 'application/json; charset=utf-8'},);

    print('Status: ${response.statusCode}');
    print(response.body.toString());
    return response.statusCode == 200;
  }

  Future<bool> withdrawAmountFromAccount(String accountId, int amount) async {

    // withdraw amount from account with provided id
    var response = await client.post('$endpoint/withdraw/$accountId?amount=$amount',
      headers: { 'Content-Type': 'application/json; charset=utf-8'},);

    print('Status: ${response.statusCode}');
    print(response.body.toString());
    return response.statusCode == 200;
  }
}