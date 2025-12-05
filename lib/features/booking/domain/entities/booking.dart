import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final int vehicleId;
  final String name;
  final String email;
  final String phone;
  final String cnic;
  final String pickupDate;
  final String returnDate;
  final String pickupLocation;
  final String returnLocation;
  final String serviceType;
  final String priceModel;

  final int? id;

  const Booking({
    this.id,
    required this.vehicleId,
    required this.name,
    required this.email,
    required this.phone,
    required this.cnic,
    required this.pickupDate,
    required this.returnDate,
    required this.pickupLocation,
    required this.returnLocation,
    required this.serviceType,
    required this.priceModel,
  });

  @override
  List<Object?> get props => [
    id,
    vehicleId,
    name,
    email,
    phone,
    cnic,
    pickupDate,
    returnDate,
    pickupLocation,
    returnLocation,
    serviceType,
    priceModel,
  ];
}
