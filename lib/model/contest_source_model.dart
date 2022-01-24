class ContestSource {
  String title;
  String key;
  bool isSelected;
  String imgSrc;

  ContestSource({required this.title, required this.key,required this.isSelected,required this.imgSrc});
}


List<ContestSource> allContestList = [
  ContestSource(
      key: "codeforces",
      title: 'CodeForces',
      isSelected: false,
      imgSrc: "assets/images/code_forces.png"),
  ContestSource(
      title: "CodeForces Gym",
      key: "codeforces_gym",
      isSelected: false,
      imgSrc: "assets/images/code_forces_gym.png"),
  ContestSource(
      title: "TopCoder",
      key: "top_coder",
      isSelected: false,
      imgSrc: "assets/images/top_coder.jpg"),
  ContestSource(
      title: "AtCoder",
      key: "at_coder",
      isSelected: false,
      imgSrc: "assets/images/at_coders.png"),
  ContestSource(
      title: "CodeChef",
      key: "code_chef",
      isSelected: false,
      imgSrc: "assets/images/code_chef.jpg"),
  ContestSource(
      title: "CS Academy",
      key: "cs_academy",
      isSelected: false,
      imgSrc: "assets/images/cs_acadmy.png"),
  ContestSource(
      title: "HackerRank",
      key: "hacker_rank",
      isSelected: false,
      imgSrc: "assets/images/hacker_rank.png"),
  ContestSource(
      title: "HackerEarth",
      key: "hacker_earth",
      isSelected: false,
      imgSrc: "assets/images/hacker_earth.png"),
  ContestSource(
      title: "Kick Start",
      key: "kick_start",
      isSelected: false,
      imgSrc: "assets/images/kick_start.jpg"),
  ContestSource(
      title: "LeetCode",
      key: "leet_code",
      isSelected: false,
      imgSrc: "assets/images/leet_code.png"),
];