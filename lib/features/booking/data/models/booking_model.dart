import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  const BookingModel({
    super.id,
    required super.vehicleId,
    required super.name,
    required super.email,
    required super.phone,
    required super.cnic,
    required super.pickupDate,
    required super.returnDate,
    required super.pickupLocation,
    required super.returnLocation,
    required super.serviceType,
    required super.priceModel,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      vehicleId: json['vehicleId'] ?? 0,
      name: json['name'] ?? json['Name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      cnic: json['cnic'] ?? '',
      pickupDate: json['pickupDate'] ?? '',
      returnDate: json['returnDate'] ?? '',
      pickupLocation: json['pickupLocation'] ?? '',
      returnLocation: json['returnLocation'] ?? '',
      serviceType: json['serviceType'] ?? '',
      priceModel: json['priceModel'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'vehicleId': vehicleId,
      'Name': name,
      'email': email,
      'phone': phone,
      'cnic': cnic,
      'pickupDate': pickupDate,
      'returnDate': returnDate,
      'pickupLocation': pickupLocation,
      'returnLocation': returnLocation,
      'serviceType': serviceType,
      'priceModel': priceModel,
    };
  }
}
