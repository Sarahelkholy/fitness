class SocialUser {
  final String id;
  final String? email;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? photo;
  final String? phone;

  SocialUser({
    required this.id,
    this.email,
    this.name,
    this.firstName,
    this.lastName,
    this.photo,
    this.phone,
  });

  @override
  String toString() {
    return 'SocialUser(id: $id, email: $email, name: $name, firstName: $firstName, lastName: $lastName, photo: $photo, phone: $phone)';
  }
}
