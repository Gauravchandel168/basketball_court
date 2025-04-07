//const String BASE_URL = "https://biblequiz-latest.onrender.com";
//const String BASE_URL = "https://d61e-223-185-52-55.ngrok-free.app";
const String BASE_URL = "https://viblyne.onrender.com";
const String SIGN_UP_URL = BASE_URL + "/signup";
const String SIGN_IN_URL = BASE_URL + "/signin";
const String GET_PROFILE_URL = BASE_URL + "/profile";
const String GET_ALL_LEARNING_URL = BASE_URL + "/learnings";
const String GET_ALL_PRIZE_URL = BASE_URL + "/prizes";
const String GET_SHIPMENT_URL = BASE_URL + "/shipments";

String MARK_LEARNING_COMPLETED_URL({required String learningId}) {
  return "$BASE_URL/learnings/$learningId/completed";
}

String MARK_QUIZ_COMPLETED_URL({required String learningId, required quizId}) {
  return "$BASE_URL/learnings/$learningId/quiz/$quizId/completed";
}

String BUY_PRIZES_URL({required String prizeId}) {
  return "$BASE_URL/prizes/$prizeId/buy";
}
String GET_AGORA_CREATE_CAHNNEL_TOKEN_URL({required String userId}) {
  return "$BASE_URL/agora/create/channel/${userId}";
}
