class Partnership{
  Partnership(this.partnershipId, this.parent_1_Id, this.parent_2_Id, this.childrenId, this.active);

  final String partnershipId;
  final String parent_1_Id;
  final String parent_2_Id;
  final List<String> childrenId;
  final bool active;
}