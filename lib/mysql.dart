import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = 'localhost',
                user = 'root',
                password = '1234',
                db ='ezpzPark';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings =  ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db
    );
    return await MySqlConnection.connect(settings);
  }

  Future<void> insertReportData(String email, String location, String zone, String parking_number, String issue) async {
    MySqlConnection connection = await getConnection();
    try {
      await connection.query(
        'INSERT INTO report_data (email, location, zone, parking_number, issue) VALUES (?,?,?,?,?)',
        [email, location, zone, parking_number, issue],
      );
    } catch (e) {
      print('Error inserting report data: $e');
    } finally {

    }
    await connection.close();
  }

  Future<void> insertConditionData(String description, String? image_path) async {
    MySqlConnection connection = await getConnection();
    try {
      if(image_path !=null) {
        await connection.query(
          'INSERT INTO condition_data (description, image_path) VALUES (?, ?)',
          [description, image_path],
        );
      } else {
        await connection.query(
          'INSERT INTO condition_data (description) VALUES (?)',
          [description],
        );
      }
    } catch (e) {
      print('Error inserting condition form data: $e');
    } finally {

    }
    await connection.close();
  }

  Future<void> insertMisuseData(String description,String offender_plate, String time_occured , String? image_path) async {
    MySqlConnection connection = await getConnection();
    try {
      if(image_path != null) {
        await connection.query(
          'INSERT INTO misuse_data (description, offender_plate, time_occured, image_path) VALUES (?, ?, ?, ?)',
          [description, offender_plate, time_occured, image_path],
        );
      } else {
          await connection.query(
            'INSERT INTO misuse_data (description, offender_plate, time_occured) VALUES (?, ?, ?)',
            [description, offender_plate, time_occured],
          );
        }
    } catch (e) {
      print('Error inserting misuse form data: $e');
    } finally {

    }
    await connection.close();
  }

  /*Future<List<Map<String,dynamic>>> fetchUserHistory() async {
    var conn = await MySqlConnection.connect(settings);
    try {
      var results = await conn.query('SELECT * FROM users');
      return results.toList();
    } catch (e) {
      print('Error fetching user history: $e');
      return [];
    } finally {
      await conn.close();
    }
  }*/

}


