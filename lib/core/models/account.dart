class Account {
  String id;
  String name;
  String accountNumber;
  int balance;
  String created;
  String modified;
  int overdraft;
  bool active;
  String userId;

  Account(
      {this.id,
      this.name,
      this.accountNumber,
      this.balance,
      this.created,
      this.modified,
      this.overdraft,
      this.active,
      this.userId});

  Account.initial()
      : id = '',
        name = '',
        accountNumber = '',
        balance = 0,
        created = '',
        modified = '',
        overdraft = 0,
        active = false,
        userId = '';

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accountNumber = json['accountNumber'];
    balance = json['balance'];
    created = json['created'];
    modified = json['modified'];
    overdraft = json['overdraft'];
    active = json['active'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['accountNumber'] = this.accountNumber;
    data['balance'] = this.balance;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['overdraft'] = this.overdraft;
    data['active'] = this.active;
    data['userId'] = this.userId;
    return data;
  }
}
