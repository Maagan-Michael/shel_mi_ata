class Person{

  Person(this.personId, this.firstName, this.lastName, this.nickName, this.imageUrl, this.parentPartnershipId, this.partnershipsId, this.birthDate, this.gender, this.tags, this.certificates);

  final String personId;
  final String firstName;
  final String lastName;
  final String nickName;
  final String imageUrl;
  final String parentPartnershipId;
  final List<String> partnershipsId;
  final DateTime birthDate;
  final String gender;
  final List<String> tags;
  final List<String> certificates;
}