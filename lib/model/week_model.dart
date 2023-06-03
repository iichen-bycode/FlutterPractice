class WeekModel {
  String textTime;
  String dashText;
  int time;

  WeekModel(this.textTime, this.dashText, this.time);

  @override
  String toString() {
    return 'WeekModel{textTime: $textTime, dashText: $dashText, time: $time}';
  }


}