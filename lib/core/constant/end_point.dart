abstract class EndPoints {
  static const String baseUrl = "https://my-bus.storage-te.com/api/";
  static const String sendOtp = "auth/send-otp";
  static const String verifyOtp = "auth/verify-otp";
  static const String resendOtp = "auth/resend-otp";
  static const String passengerInfo = "auth/resend-otp";
static const String addDriverInfo=  "driver/profile";
static const String addVehicleInfo=  "driver/vehicles";
static const String  seats=  "bus-types";
static const String  cities=  "cities";
static const String  createTrip=  "trips";
static const String  profile= "auth/profile";
static const String  logOut= "auth/logout";
static const String  previousTrip= "trips";

 static String reserveSeat(String tripId, String seatId) {
    return "trips/$tripId/seats/$seatId/reserve";
  }

}
