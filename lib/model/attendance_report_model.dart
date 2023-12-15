class AttendanceListModel{
  String? title;
  String? subTitle;
  bool? isSelected;
  String? status;
  String? imageUrl;


  AttendanceListModel({this.title,this.subTitle,this.isSelected,this.status,this.imageUrl});

  factory AttendanceListModel.fromJson(Map<String, dynamic> json) {
    return AttendanceListModel(
      title: json['title'],
      subTitle: json['subTitle'],
      isSelected: json['isSelected'],
      status: json['status'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'title':title,
      'subTitle':subTitle,
      'isSelected':isSelected,
      'status':status,
      'imageUrl':imageUrl
    };
  }

}