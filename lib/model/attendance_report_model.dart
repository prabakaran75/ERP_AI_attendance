class AttendanceListModel{
  String? title;
  bool? isSelected;
  String? status;
  String? imageUrl;


  AttendanceListModel({this.title,this.isSelected,this.status,this.imageUrl});

  factory AttendanceListModel.fromJson(Map<String, dynamic> json) {
    return AttendanceListModel(
      title: json['title'],
      isSelected: json['isSelected'],
      status: json['status'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'title':title,
      'isSelected':isSelected,
      'status':status,
      'imageUrl':imageUrl
    };
  }

}