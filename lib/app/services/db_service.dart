import 'package:lifelink/app/data/models/models.dart';
import 'package:lifelink/app/modules/donation/controllers/donation_controller.dart';
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

    const createBloodRequestTableSql = '''
      CREATE TABLE IF NOT EXISTS blood_requests (
        id INT AUTO_INCREMENT PRIMARY KEY,
        requestType VARCHAR(255) NOT NULL,
        bloodGroup VARCHAR(255) NOT NULL,
        amount INT NOT NULL,
        pName VARCHAR(255) NOT NULL,
        pContact VARCHAR(255),
        pProblem VARCHAR(255),
        hospital VARCHAR(255) NOT NULL,
        bedNumber VARCHAR(255),
        donationDate VARCHAR(255) NOT NULL,
        donationTime VARCHAR(255) NOT NULL,
        isCritical BOOLEAN NOT NULL,
        requesterId VARCHAR(255) NOT NULL,
        donorId VARCHAR(255),
        status VARCHAR(255) NOT NULL,
        FOREIGN KEY (requesterId) REFERENCES users(mobile),
        FOREIGN KEY (donorId) REFERENCES users(mobile)
      )''';

    const createConversationsTableSql =
        '''CREATE TABLE IF NOT EXISTS conversations (
        id INT AUTO_INCREMENT PRIMARY KEY,
        requesterId VARCHAR(255) NOT NULL,
        donorId VARCHAR(255) NOT NULL,
            createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (requesterId) REFERENCES users(mobile),
        FOREIGN KEY (donorId) REFERENCES users(mobile)
    )''';

    const createMessagesTableSql = '''CREATE TABLE IF NOT EXISTS messages (
        id INT AUTO_INCREMENT PRIMARY KEY,
        conversationId INT NOT NULL,
        message VARCHAR(255) NOT NULL,
        senderId VARCHAR(255) NOT NULL,
        createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (conversationId) REFERENCES conversations(id),
        FOREIGN KEY (senderId) REFERENCES users(mobile)
    )''';

    await dbConnection?.query(createUserTableSql);
    await dbConnection?.query(createBloodRequestTableSql);
    await dbConnection?.query(createConversationsTableSql);
    await dbConnection?.query(createMessagesTableSql);
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

  //======Blood Request =======//
  // Create BloodRequest
  Future<int> createBloodRequest(BloodRequest bloodRequest) async {
    final result = await dbConnection?.query(
      'INSERT INTO blood_requests (requestType, bloodGroup, amount, pName, pContact, pProblem, hospital, bedNumber, donationDate, donationTime, isCritical, requesterId, donorId, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        bloodRequest.requestType,
        bloodRequest.bloodGroup,
        bloodRequest.amount,
        bloodRequest.pName,
        bloodRequest.pContact,
        bloodRequest.pProblem,
        bloodRequest.hospital,
        bloodRequest.bedNumber,
        bloodRequest.donationDate,
        bloodRequest.donationTime,
        bloodRequest.isCritical ? 1 : 0,
        bloodRequest.requesterId,
        bloodRequest.donorId,
        bloodRequest.status
      ],
    );
    return result?.insertId ??
        -1; // Return the auto-incremented ID of the newly inserted row
  }

  Future<BloodRequest?> getBloodRequestById(int id) async {
    try {
      final results = await dbConnection?.query(
        'SELECT * FROM blood_requests WHERE id = ?',
        [id],
      );
      if (results != null && results.isNotEmpty) {
        final row = results.first;
        return BloodRequest.fromMap(row.fields);
      } else {
        return null; // Blood request with the provided ID not found
      }
    } catch (error) {
      printError(info: 'Error fetching blood request: $error');
      return null; // Error occurred while fetching blood request
    }
  }

  // Function to retrieve blood requests by requester ID
  Future<List<BloodRequest>> getBloodRequestsByRequesterId(
      String requesterId) async {
    try {
      final results = await dbConnection?.query(
        'SELECT * FROM blood_requests WHERE requesterId = ?',
        [requesterId],
      );
      final List<BloodRequest> bloodRequests = [];
      if (results != null && results.isNotEmpty) {
        for (final row in results) {
          final bloodRequest = BloodRequest.fromMap(row.fields);
          bloodRequests.add(bloodRequest);
        }
      }
      return bloodRequests;
    } catch (error) {
      printError(info: 'Error fetching blood requests: $error');
      return [];
    }
  }

  Future<List<BloodRequest>> getBloodRequestsByDonorId(String donorId) async {
    try {
      final results = await dbConnection?.query(
        'SELECT * FROM blood_requests WHERE donorId = ?',
        [donorId],
      );
      final List<BloodRequest> bloodRequests = [];
      if (results != null && results.isNotEmpty) {
        for (final row in results) {
          final bloodRequest = BloodRequest.fromMap(row.fields);
          bloodRequests.add(bloodRequest);
        }
      }
      return bloodRequests;
    } catch (error) {
      printError(info: 'Error fetching blood requests: $error');
      return [];
    }
  }

  Future<void> acceptBloodReq(int id, String donorId) async {
    try {
      await dbConnection?.query(
        'UPDATE blood_requests SET donorId = ?, status = ? WHERE id = ?',
        [donorId, DonationStatus.accepted.name, id],
      );
      printInfo(info: 'Blood request accepted successfully');
    } catch (error) {
      printError(info: 'Error accepting blood request: $error');
    }
  }

  Future<List<BloodRequest>> getInprogressDonations() async {
    try {
      final results = await dbConnection?.query(
        'SELECT * FROM blood_requests WHERE status = ?',
        [DonationStatus.inprogress.name],
      );
      final List<BloodRequest> donations = [];
      if (results != null && results.isNotEmpty) {
        for (final row in results) {
          final donation = BloodRequest.fromMap(row.fields);
          donations.add(donation);
        }
      }
      return donations;
    } catch (error) {
      print('Error fetching in-progress donations: $error');
      return [];
    }
  }

  Future<List<Conversation>> genConversations(String id) async {
    try {
      final results = await dbConnection?.query(
        'SELECT * FROM conversations WHERE requesterId = ? OR donorId = ?',
        [id, id],
      );
      final List<Conversation> conversations = [];
      if (results != null && results.isNotEmpty) {
        for (final row in results) {
          final conversation = Conversation.fromMap(row.fields);
          conversations.add(conversation);
        }
      }
      return conversations;
    } catch (error) {
      print('Error fetching conversations: $error');
      return [];
    }
  }

  //========Conversation============/
  Future<void> createConversation(String requesterId, String donorId) async {
    try {
      await dbConnection?.query(
        'INSERT INTO conversations (requesterId, donorId, createdAt) VALUES (?, ?, NOW())',
        [requesterId, donorId],
      );
    } catch (error) {
      print('Error creating conversation: $error');
    }
  }

  Future<int?> getConversation(String requesterId, String donorId) async {
    try {
      final results = await dbConnection?.query(
        'SELECT id FROM conversations WHERE requesterId = ? AND donorId = ?',
        [requesterId, donorId],
      );
      if (results != null && results.isNotEmpty) {
        return results.first['id'] as int;
      }
    } catch (error) {
      print('Error getting conversation: $error');
    }
    return null;
  }

  //==========Message=============//

  Future<void> createMessage(
      int conversationId, String senderId, String message) async {
    try {
      await dbConnection?.query(
        'INSERT INTO messages (conversationId, senderId, message, createdAt) VALUES (?, ?, ?, NOW())',
        [conversationId, senderId, message],
      );
    } catch (error) {
      print('Error creating message: $error');
    }
  }

  Future<List<Message>> getMessages(int conversationId) async {
    try {
      final results = await dbConnection?.query(
        'SELECT * FROM messages WHERE conversationId = ? ORDER BY createdAt ASC',
        [conversationId],
      );
      final List<Message> messages = [];
      if (results != null && results.isNotEmpty) {
        for (final row in results) {
          final message = Message.fromMap(row.fields);
          messages.add(message);
        }
      }
      return messages;
    } catch (error) {
      print('Error getting messages: $error');
      return [];
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
