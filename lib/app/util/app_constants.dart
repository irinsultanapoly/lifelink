import 'package:flutter/material.dart';

//App
const kOrgId = "64c355f4393e7f8cd1798375";
const kBloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

///Locales
const kDefaultLocale = Locale('en', 'US');
const kFallbackLocale = Locale('en', 'US');

///Auth const
const kAuthTypeLogin = 0;
const kAuthTypeSignup = 1;

//Dashboard
const khFeaturedAnimation = 130.0;
const kDashBoardDateFormat = 'EEEE, d MMM';

//Section
const kCurrentSelectedCategoryIdKey = "kCurrentSelectedCategoryIdKey";

//Subject
const kCurrentSelectedSubKey = "kCurrentSelectedSubKey";
//Lesson
const kCurrentSelectedLessonKey = "kCurrentSelectedLessonKey";
//Note
const kCurrentSelectedNoteKey = "kCurrentSelectedNoteKey";
const kDateFormat = 'dd-MM-yyyy';
const kDonationDateFormat = 'dd-MM-yyyy hh:mm a';
const kLastUpdatedNoteTimestamp = "kLastUpdatedNoteTimestamp";

//Language
const kCurrentLangCode = "kCurrentLangCode";

//Selector
const kOtherSelection = 'Other';
const kSelectionInstruction = 'Please Select';

//Note Request
const kNoteReqDateFormat = "HH:mm d MMM yy";

//DateTime
const firstEpoch = 0000000000000;

//Otp
// Define the range of digits for the OTP (0 to 9)
const kOtpMinRange = 1000; // Minimum value (inclusive)
const kOtpMaxRange = 9999; // Maximum value (inclusive)
const kOtpRetryIntervalSeconds = 30; //3m
const kOtpResetIntervalSeconds = 3 * 60; //30m
const kOtpMaxRetryCount = 3;

const kOtpResponseCodeSuccess = 202;
const kOtpResponseCodeInvalidNumber = 1001;

const kLastOtpSentTimeKey = 'kLastOtpSentTime';
const kOtpTryCountKey = 'kOtpTryCount';
const kLastSentOtpKey = 'kLastSentOtp';
