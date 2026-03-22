class EarningHistoryModel {
  int? id;
  int? deliveryManId;
  int? orderId;
  double? amount;
  String? method;
  String? ref;
  String? status;
  String? paymentTime;
  String? itemName;
  String? createdAt;
  String? updatedAt;

  EarningHistoryModel({
    this.id,
    this.deliveryManId,
    this.orderId,
    this.amount,
    this.method,
    this.ref,
    this.status,
    this.paymentTime,
    this.itemName,
    this.createdAt,
    this.updatedAt,
  });

  EarningHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryManId = json['delivery_man_id'];
    orderId = json['order_id'];
    amount = json['amount']?.toDouble();
    method = json['method'];
    ref = json['ref'];
    status = json['status'];
    paymentTime = json['payment_time'];
    itemName = json['item_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['delivery_man_id'] = deliveryManId;
    data['order_id'] = orderId;
    data['amount'] = amount;
    data['method'] = method;
    data['ref'] = ref;
    data['status'] = status;
    data['payment_time'] = paymentTime;
    data['item_name'] = itemName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
