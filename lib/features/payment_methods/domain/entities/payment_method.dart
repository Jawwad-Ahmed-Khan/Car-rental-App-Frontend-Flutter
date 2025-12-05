import 'package:equatable/equatable.dart';

/// Enum for payment method types
enum PaymentMethodType {
  cash,
  card,
  applePay,
  googlePay,
  masterCard,
  discover,
  amex,
}

/// Entity representing a payment method
class PaymentMethod extends Equatable {
  final String id;
  final String name;
  final PaymentMethodType type;
  final String? iconPath;
  final bool isSelected;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.type,
    this.iconPath,
    this.isSelected = false,
  });

  PaymentMethod copyWith({
    String? id,
    String? name,
    PaymentMethodType? type,
    String? iconPath,
    bool? isSelected,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      iconPath: iconPath ?? this.iconPath,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, name, type, iconPath, isSelected];
}

/// Entity representing a saved card
class SavedCard extends Equatable {
  final String id;
  final String cardNumber; // Last 4 digits only
  final String cardHolderName;
  final String expiryDate;
  final String cardType; // Visa, Mastercard, etc.

  const SavedCard({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cardType,
  });

  /// Get masked card number display
  String get maskedCardNumber => '**** **** **** $cardNumber';

  @override
  List<Object?> get props => [
    id,
    cardNumber,
    cardHolderName,
    expiryDate,
    cardType,
  ];
}
