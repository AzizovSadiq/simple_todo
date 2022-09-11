
class TodoModel{
  int id;
  String title;
  String description;
  bool status;
  String dateTime;

  TodoModel({required this.id,required this.title,required this.description,required this.status,required this.dateTime})
  {
    id = id;
    title = title;
    description = description;
    status = status;
    dateTime = dateTime;
  }

  toJson(){
    return {
      "id" : id,
      "title": title,
      "description" : description,
      "status" : status,
      "dateTime" : dateTime
    };
  }
  
  fromJson(jsonData){
    return TodoModel(
      id : jsonData['id'],
      title : jsonData['title'],
      description : jsonData['description'],
      status : jsonData['status'],
      dateTime : jsonData['dateTime']
    );
  }
}