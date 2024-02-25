class DescriptionResponse {
  Obj? data;

  DescriptionResponse({this.data});

  DescriptionResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Obj.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Obj {
  String? title;
  String? content;

  Obj({this.title, this.content});

  Obj.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}
