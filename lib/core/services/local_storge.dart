import 'package:hive/hive.dart';
import 'package:taskati/core/models/task_model.dart';
//open hive doc + import hive + hive flutter
// init hive in main (await hive.initFlutter())
//open hive box in main (hive.openBox('userBox'))
// use init method from app local storage in main
// in app local storage use cacheData method to cache data (cacheData('key',value))
// to get data use userBox.get('key')
class AppLocalStorage {
static late Box userBox;
static late Box <TaskModel>tasksBox;
 static init(){
  userBox = Hive.box('userBox');
  tasksBox = Hive.box<TaskModel>('tasksBox');
}
 static cacheDataOfUser(String key , dynamic value){
   userBox.put(key, value);
}
static getCachedDataOfUser(String key) {
   return userBox.get(key);
}
static cacheDataOfTasks(String key , TaskModel value){
   tasksBox.put(key, value);
 }
 static TaskModel? getCachedDataOfTasks(String key) {
   return tasksBox.get(key);
 }

}