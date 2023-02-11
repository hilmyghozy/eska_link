class BaseResponse {
  dynamic data;
  dynamic support;

  BaseResponse({this.data, this.support});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    support = json['support'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (support != null) {
      data['support'] = support!.toJson();
    }
    return data;
  }
}
