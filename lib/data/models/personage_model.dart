class PersonageModel {
    String id;
    String name;
    List<String> alternateNames;
    String species;
    String gender;
    String house;
    String? dateOfBirth;
    int? yearOfBirth;
    bool wizard;
    String ancestry;
    String eyeColour;
    String hairColour;
    Wand wand;
    String patronus;
    bool hogwartsStudent;
    bool hogwartsStaff;
    String actor;
    List<dynamic> alternateActors;
    bool alive;
    String image;

    PersonageModel({
        required this.id,
        required this.name,
        required this.alternateNames,
        required this.species,
        required this.gender,
        required this.house,
        required this.dateOfBirth,
        required this.yearOfBirth,
        required this.wizard,
        required this.ancestry,
        required this.eyeColour,
        required this.hairColour,
        required this.wand,
        required this.patronus,
        required this.hogwartsStudent,
        required this.hogwartsStaff,
        required this.actor,
        required this.alternateActors,
        required this.alive,
        required this.image,
    });

    factory PersonageModel.fromJson(Map<String, dynamic> json) => PersonageModel(
        id: json["id"],
        name: json["name"],
        alternateNames: List<String>.from(json["alternate_names"].map((x) => x)),
        species: json["species"],
        gender: json["gender"],
        house: json["house"],
        dateOfBirth: json["dateOfBirth"].toString(),
        yearOfBirth: json["yearOfBirth"],
        wizard: json["wizard"],
        ancestry: json["ancestry"],
        eyeColour: json["eyeColour"],
        hairColour: json["hairColour"],
        wand: Wand.fromJson(json["wand"]),
        patronus: json["patronus"],
        hogwartsStudent: json["hogwartsStudent"],
        hogwartsStaff: json["hogwartsStaff"],
        actor: json["actor"],
        alternateActors: List<dynamic>.from(json["alternate_actors"].map((x) => x)),
        alive: json["alive"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternate_names": List<dynamic>.from(alternateNames.map((x) => x)),
        "species": species,
        "gender": gender,
        "house": house,
        "dateOfBirth": dateOfBirth,
        "yearOfBirth": yearOfBirth,
        "wizard": wizard,
        "ancestry": ancestry,
        "eyeColour": eyeColour,
        "hairColour": hairColour,
        "wand": wand.toJson(),
        "patronus": patronus,
        "hogwartsStudent": hogwartsStudent,
        "hogwartsStaff": hogwartsStaff,
        "actor": actor,
        "alternate_actors": List<dynamic>.from(alternateActors.map((x) => x)),
        "alive": alive,
        "image": image,
    };
}

class Wand {
    String wood;
    String core;
    num? length;

    Wand({
        required this.wood,
        required this.core,
        required this.length,
    });

    factory Wand.fromJson(Map<String, dynamic> json) => Wand(
        wood: json["wood"],
        core: json["core"],
        length: json["length"] ,
    );

    Map<String, dynamic> toJson() => {
        "wood": wood,
        "core": core,
        "length": length,
    };
}
