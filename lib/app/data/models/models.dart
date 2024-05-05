import 'package:lifelink/app/modules/donation/controllers/donation_controller.dart';

class User {
  String mobile;
  String pass;
  String name;
  String bloodGroup;

  User({required this.mobile,
    required this.pass,
    required this.name,
    required this.bloodGroup});
}

class BloodRequest {
  int id;
  String requestType;
  String bloodGroup;
  int amount;
  String pName;
  String? pContact;
  String? pProblem;
  String hospital;
  String? bedNumber;
  String donationDate;
  String donationTime;
  bool isCritical;
  String requesterId;
  String? donorId;
  String status;

  BloodRequest

  (this.id, {
  required this.requestType,
  required this.bloodGroup,
  required this.amount,
  required this.pName,
  this.pContact,
  this.pProblem,
  required this.hospital,
  this.bedNumber,
  required this.donationDate,
  required,
  required this.donationTime,
  required this.isCritical,
  required this.requesterId,
  this.donorId,
  required this.status,
  });

  // Constructor for creating BloodRequest from a map
  BloodRequest.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
  requestType = map['requestType'] as String,
  bloodGroup = map['bloodGroup'] as String,
  amount = map['amount'] as int,
  pName = map['pName'] as String,
  pContact = map['pContact'] as String?,
  pProblem = map['pProblem'] as String?,
  hospital = map['hospital'] as String,
  bedNumber = map['bedNumber'] as String?,
  donationDate = map['donationDate'] as String,
  donationTime = map['donationTime'] as String,
  isCritical = (map['isCritical'] as int) == 1,
  requesterId = map['requesterId'] as String,
  donorId = map['donorId'] as String?,
  status = map['status'] as String;
}


class Conversation {
  int id;
  String requesterId;
  String donorId;
  DateTime createdAt = DateTime.now();

  Conversation(this.id, {required this.donorId, required this.requesterId});

  // Constructor for creating Conversation from a map
  Conversation.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        requesterId = map['requesterId'] as String,
        donorId = map['donorId'] as String,
        createdAt = map['createdAt'] as DateTime;
}

class Message {
  int id;
  int conversationId;
  String message;
  String senderId;
  DateTime createdAt = DateTime.now();

  Message(this.id, this.conversationId,
      {required this.senderId, required this.message});

  // Constructor for creating Message from a map
  Message.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        conversationId = map['conversationId'] as int,
        message = map['message'] as String,
        senderId = map['senderId'] as String,
        createdAt = map['createdAt'] as DateTime;
}

