class BankDetailModel {
  bool? isSelected;

  String? user_id;
  String? bank_stripe_id;
  String? holder_name;
  String? account_holder_type;
  String? bank_name;
  String? account_number;
  String? routing_number;
  String? city;
  String? state;
  String? country;
  String? address;
  String? phone_number;
  String? bank_reason;
  String? bank_status;
  String? postal_code;

  int? id;
  BankDetailModel({
    this.isSelected,
    this.user_id,
    this.bank_stripe_id,
    this.holder_name,
    this.account_holder_type,
    this.bank_name,
    this.account_number,
    this.routing_number,
    this.city,
    this.state,
    this.country,
    this.address,
    this.phone_number,
    this.bank_reason,
    this.bank_status,
    this.postal_code,
    this.id,
  });

  factory BankDetailModel.fromJson(Map<String, dynamic> json) {
    return BankDetailModel(
      isSelected: false,
      user_id: json['user_id'].toString(),
      id: json['id'] ?? 0,
      bank_stripe_id: json['bank_stripe_id'].toString(),
      holder_name: json['holder_name'].toString() == "null"
          ? ""
          : json['holder_name'].toString(),
      account_holder_type: json['account_holder_type'].toString(),
      bank_name: json['bank_name'].toString(),
      account_number: json['account_number'].toString(),
      routing_number: json['routing_number'].toString(),
      city: json['city'].toString() == "null" ? "" : json['city'].toString(),
      state: json['state'].toString() == "null" ? "" : json['state'].toString(),
      country: json['country'].toString() == "null"
          ? ""
          : json['country'].toString(),
      address: json['address'].toString() == "null"
          ? ""
          : json['address'].toString(),
      phone_number: json['phone_number'].toString() == "null"
          ? ""
          : json['phone_number'].toString(),
      bank_reason: json['bank_reason'].toString() == "null"
          ? ""
          : json['bank_reason'].toString(),
      bank_status: json['bank_status'].toString() == "null"
          ? ""
          : json['bank_status'].toString(),
      postal_code: json['postal_code'].toString() == "null"
          ? ""
          : json['postal_code'].toString(),
    );
  }
}
