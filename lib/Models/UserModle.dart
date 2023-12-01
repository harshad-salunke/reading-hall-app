
class UserModel{
  String? phone_number;
  String? name;
  String? roll_no;
  String? uid;
  String? join_date;
  String? clg_name;
   String? clg_year;
  String ?clg_branch;
  String? gender;

  UserModel(this.phone_number,this.name,this.roll_no,this.uid,this.join_date,this.clg_name,this.clg_year,this.clg_branch,this.gender);
  UserModel.fromJson(Map<String, dynamic> json) {
   phone_number=json['phone_number'];
   name=json['name'];
   roll_no=json['roll_no'];
   uid=json['uid'];
   join_date=json['join_date'];
   clg_name=json['clg_name'];
   clg_year=json['clg_year'];
   clg_branch=json['clg_branch'];
   gender=json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['phone_number']=phone_number;
    data['name']=name;
    data['roll_no']=roll_no;
    data['uid']=uid;
    data['join_date']=join_date;
    data['clg_name']=clg_name;
    data['clg_year']=clg_year;
    data['clg_branch']=clg_branch;
    data['gender']=gender;
    return data;
  }

}