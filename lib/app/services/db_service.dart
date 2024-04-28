import 'package:lifelink/app/data/models/models.dart';
import 'package:mysql1/mysql1.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

class DbService extends GetxService {
  var settings = ConnectionSettings(
      host: '10.0.2.2',
      port: 3306,
      user: 'group2',
      password: 'group2password',
      db: 'lifelink_db');

  MySqlConnection? dbConnection;

  @override
  void onInit() {
    super.onInit();
    initDb();
  }

  Future<void> initDb() async {
    try {
      dbConnection = await MySqlConnection.connect(settings);
      printInfo(info: 'DB => Connection Success! :)');
    } catch (err) {
      printError(info: 'DB => Connection Failed: $err');
    }
    await createTables()
        .then((value) => printInfo(info: 'DB => Table Creation Success! :)'))
        .onError((error, stackTrace) =>
            printError(info: 'DB => Table Creation Failed: $error'));
  }

  Future<void> createTables() async {
    //User Table
    const createUserTableSql = """CREATE TABLE IF NOT EXISTS users (
      mobile VARCHAR(255) PRIMARY KEY,
      pass VARCHAR(255) NOT NULL,
      name VARCHAR(255) NOT NULL,
      bloodGroup VARCHAR(255) NOT NULL
    )""";
    await dbConnection?.query(createUserTableSql);
  }

  Future<void> createUser(User user) async {
    const insertUserSql =
        'INSERT INTO users (mobile, pass, name, bloodGroup) VALUES (?, ?, ?, ?)';
    await dbConnection?.query(
        insertUserSql, [user.mobile, user.pass, user.name, user.bloodGroup]);
  }

  Future<User?> findUserByMobile(String mobile) async {
    const selectUserSql = 'SELECT * FROM users WHERE mobile = ?';

    final results = await dbConnection?.query(selectUserSql, [mobile]);

    if (results != null && results.isNotEmpty) {
      return User(
        mobile: results.first['mobile'] as String,
        pass: results.first['pass'] as String,
        name: results.first['name'] as String,
        bloodGroup: results.first['bloodGroup'] as String,
      );
    } else {
      return null;
    }
  }

  Future<List<User>> findUsersByBloodGroup(String bloodGroup) async {
    const selectUsersSql = 'SELECT * FROM users WHERE bloodGroup = ?';

    final results = await dbConnection?.query(selectUsersSql, [bloodGroup]);

    final List<User> users = [];

    if (results != null && results.isNotEmpty) {
      for (final row in results) {
        final user = User(
          mobile: row['mobile'] as String,
          pass: row['pass'] as String,
          name: row['name'] as String,
          bloodGroup: row['bloodGroup'] as String,
        );
        users.add(user);
      }
    }
    return users;
  }

  Future<bool> existByMobile(String mobile) async {
    const selectUserSql =
        'SELECT COUNT(*) as count FROM users WHERE mobile = ?';

    final results = await dbConnection?.query(selectUserSql, [mobile]);

    if (results != null && results.isNotEmpty) {
      final count = results.first['count'] as int;
      return count > 0;
    } else {
      return false;
    }
  }

  Future<bool> existUserByMobileAndPassword(String mobile, String pass) async {
    const selectUserSql =
        'SELECT COUNT(*) as count FROM users WHERE mobile = ? AND pass = ?';

    final results = await dbConnection?.query(selectUserSql, [mobile, pass]);

    if (results != null && results.isNotEmpty) {
      final count = results.first['count'] as int;
      return count > 0;
    } else {
      return false;
    }
  }

  Future<void> closeDb() async {
    await dbConnection?.close();
  }

  @override
  void onClose() {
    closeDb();
    super.onClose();
  }
}
