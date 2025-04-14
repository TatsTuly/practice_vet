class Doctor {
  final int doctorId;
  final String name, specialist, about, location, image;
  final int price;
  final int color;
  final List<String> treatsAnimals; // Types of animals the vet treats

  const Doctor({
    required this.doctorId,
    required this.name,
    required this.specialist,
    required this.about,
    required this.location,
    required this.image,
    required this.color,
    required this.price,
    required this.treatsAnimals,
  });
}

List<Doctor> doctors = [
  Doctor(
    doctorId: 1,
    name: "Dr. Rafiqul Islam",
    specialist: "Small Animal Medicine",
    about: about,
    location: "House 23, Road 5, Dhanmondi, Dhaka",
    price: 1500,
    image: "https://cdn3d.iconscout.com/3d/premium/thumb/doctor-3d-icon-download-in-png-blend-fbx-gltf-file-formats--hospital-clinic-man-avatars-pack-people-icons-8772456.png",
    color: 0xFFffcdcf,
    treatsAnimals: ["Dogs", "Cats", "Rabbits"],
  ),
  Doctor(
    doctorId: 2,
    name: "Dr. Nusrat Jahan",
    specialist: "Feline Medicine",
    about: about,
    location: "Plaza 34, Gulshan Avenue, Dhaka",
    price: 1200,
    image: "https://static.vecteezy.com/system/resources/previews/028/029/048/non_2x/female-doctor-3d-profession-avatars-illustrations-free-png.png",
    color: 0xFFf9d8b9,
    treatsAnimals: ["Cats", "Kittens"],
  ),
  Doctor(
    doctorId: 3,
    name: "Dr. Taslima Begum",
    specialist: "Orthopedic Surgery",
    about: about,
    location: "Medical Center, GEC Circle, Chittagong",
    price: 1300,
    image: "https://cdni.iconscout.com/illustration/premium/thumb/female-doctor-illustration-download-in-svg-png-gif-file-formats--woman-lady-people-avatar-pack-illustrations-4926803.png",
    color: 0xFFccd1fa,
    treatsAnimals: ["Dogs", "Cats", "Birds"],
  ),
  Doctor(
    doctorId: 4,
    name: "Dr. Mahmud Hasan",
    specialist: "Exotic Animal Medicine",
    about: about,
    location: "Medical Complex, Kazir Dewri, Chittagong",
    price: 1800,
    image: "https://cdn3d.iconscout.com/3d/premium/thumb/doctor-avatar-3d-icon-download-in-png-blend-fbx-gltf-file-formats--medical-medicine-profession-pack-people-icons-8179550.png?f=webp",
    color: 0xFFe1edf8,
    treatsAnimals: ["Birds", "Rabbits"],
  ),
  Doctor(
    doctorId: 5,
    name: "Dr. Abdul Karim",
    specialist: "Emergency Veterinary Care",
    about: about,
    location: "City Center, Agrabad, Chittagong",
    price: 2000,
    image: "https://static.vecteezy.com/system/resources/thumbnails/024/585/358/small_2x/3d-happy-cartoon-doctor-cartoon-doctor-on-transparent-background-generative-ai-png.png",
    color: 0xFFe1edf8,
    treatsAnimals: ["Dogs", "Cats", "Birds", "Rabbits"],
  ),
  Doctor(
    doctorId: 6,
    name: "Dr. Farida Akhtar",
    specialist: "Canine Neurology",
    about: about,
    location: "Medical Square, Sylhet City",
    price: 1400,
    image: "https://static.vecteezy.com/system/resources/previews/028/251/987/non_2x/doctor-3d-icon-illustration-free-png.png",
    color: 0xFF11583c,
    treatsAnimals: ["Dogs", "Puppies"],
  ),
  Doctor(
    doctorId: 7,
    name: "Dr. Mahbubur Rahman",
    specialist: "Animal Behavior",
    about: about,
    location: "Health Complex, Khulna City",
    price: 1750,
    image: "https://static.vecteezy.com/system/resources/previews/028/251/981/non_2x/doctor-3d-icon-illustration-free-png.png",
    color: 0xFFf9d8b9,
    treatsAnimals: ["Dogs", "Cats", "Birds"],
  ),
  Doctor(
    doctorId: 8,
    name: "Dr. Kamrul Hassan",
    specialist: "Cardiology",
    about: about,
    location: "Medical Tower, Mirpur 10, Dhaka",
    price: 1600,
    image: "https://static.vecteezy.com/system/resources/previews/028/213/351/non_2x/doctor-3d-icon-illustration-free-png.png",
    color: 0xFFffcdcf,
    treatsAnimals: ["Dogs", "Cats", "Rabbits"],
  ),
  Doctor(
    doctorId: 9,
    name: "Dr. Shahriar Ahmed",
    specialist: "Avian Medicine",
    about: about,
    location: "City Hospital Road, Uttara, Dhaka",
    price: 1450,
    image: "https://static.vecteezy.com/system/resources/previews/028/196/369/non_2x/doctor-3d-icon-illustration-free-png.png",
    color: 0xFFf9d8b9,
    treatsAnimals: ["Birds", "Parrots", "Canaries"],
  ),
  Doctor(
    doctorId: 10,
    name: "Dr. Sabina Yasmin",
    specialist: "Dermatology",
    about: about,
    location: "Green Road Medical Center, Farmgate, Dhaka",
    price: 1350,
    image: "https://static.vecteezy.com/system/resources/previews/028/238/992/non_2x/doctor-3d-icon-illustration-free-png.png",
    color: 0xFFffcdcf,
    treatsAnimals: ["Dogs", "Cats", "Rabbits"],
  ),
];

const about =
    "is an experienced veterinarian who is passionate about animal health care and constantly working on improving their skills to provide better treatment for your pets.";

