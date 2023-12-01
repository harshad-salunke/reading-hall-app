class AttendanceModle{
  String? checkin;
  String? checkout;
  String ?name;
  String? month;
  String ?date;
  String? total_study;
  String? id;
  String? timestamp;
  String ? branch;
  String? roll_no;
  String? year;
  AttendanceModle(this.checkin,this.checkout,this.name,this.month,this.date,this.total_study,this.id,this.timestamp,this.branch,this.year,this.roll_no);

  AttendanceModle.fromJson(Map<String, dynamic> json) {
    checkin=json['checkin'];
    checkout=json['checkout'];
    name=json['name'];
    month=json['month'];
    date=json['date'];
    total_study=json['total_study'];
    id=json['id'];
    timestamp=json['timestamp'];
    branch=json['branch'];
    roll_no=json['roll_no'];
    year=json['year'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['checkin']=checkin;
    data['checkout']=checkout;
    data['name']=name;
    data['month']=month;
    data['date']=date;
    data['total_study']=total_study;
    data['id']=id;
    data['timestamp']=timestamp;
    data['branch']=branch;
    data['roll_no']=roll_no;
    data['year']=year;
    return data;
  }


}