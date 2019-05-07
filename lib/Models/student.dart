class Student {
    int id;
    String firstName;
    String lastName;
    String birthDate;
    String city;
    String email;
    String year;
    String imgUrl;

    Student({
        this.id,
        this.firstName,
        this.lastName,
        this.birthDate,
        this.city,
        this.email,
        this.year,
        this.imgUrl,
    });

    factory Student.fromJson(Map<String, dynamic> data) => Student(
        id: data["id"],
        firstName: data["first_name"],
        lastName: data["last_name"],
        birthDate: data["birth_date"],
        city: data["city"],
        email: data["email"],
        year:  data["year"],
        imgUrl: data["imgUrl"],

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "birth_date": birthDate,
        "city": city,
        "email": email,
        "year": year,
        "imgUrl": imgUrl,
    };
}