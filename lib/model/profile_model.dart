class ProfileModel {
  final String profileId;
  final String name;
  final String company;
  final String email;
  final int publicRepo;
  final String image;
  final String gitUrl;
  final String createdDate;
  final String updatedDate;

  ProfileModel(this.profileId, this.name, this.company, this.email,
      this.publicRepo, this.image, this.gitUrl, this.createdDate, this.updatedDate);
}
