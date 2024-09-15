part of 'models.dart';

class UserProfile {
  final String firstName;
  final String lastName;
  final String phone;
  final String location;
  final String shippingAddress;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.location,
    required this.shippingAddress,
  });

  // Método para convertir la instancia a un mapa (opcional)
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'location': location,
      'shippingAddress': shippingAddress,
    };
  }

  // Método para crear una instancia desde un mapa (opcional)
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      firstName: map['firstName'],
      lastName: map['lastName'],
      phone: map['phone'],
      location: map['location'],
      shippingAddress: map['shippingAddress'],
    );
  }
  Map<String, dynamic> formKeyToMap(GlobalKey<FormBuilderState> formKey) {
    return {
      for (var key in formKey.currentState!.fields.keys)
        key: formKey.currentState!.fields[key]!.value,
    };
  }
}
