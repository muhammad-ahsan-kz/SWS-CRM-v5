class CustomersListModel {
  final String customerId;
  final String fullName;
  final String phone;
  final String mobile;
  final String email;
  final String address;

  CustomersListModel({
    required this.customerId,
    required this.fullName,
    required this.phone,
    required this.mobile,
    required this.email,
    required this.address,
  });

  factory CustomersListModel.fromMap(Map<String, dynamic> map) {
    return CustomersListModel(
      customerId: map['Customer ID'] ?? '',
      fullName: map['Full Name'] ?? '',
      phone: map['Phone'] ?? '',
      mobile: map['Mobile'] ?? '',
      email: map['Email'] ?? '',
      address: map['Address'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Customer ID': customerId,
      'Full Name': fullName,
      'Phone': phone,
      'Mobile': mobile,
      'Email': email,
      'Address': address,
    };
  }

  @override
  String toString() {
    return 'Customer(customerId: $customerId, fullName: $fullName, phone: $phone, mobile: $mobile, email: $email, address: $address)';
  }

  // Dummy Customers List
  static List<CustomersListModel> customerList = [
    CustomersListModel(
      customerId: "3FE887D3",
      fullName: "TRYGGE TOVEN",
      phone: "2536779841",
      mobile: "",
      email: "TTOVEN@GMAIL.COM",
      address: "11540 CUMPSTON ST, NORTH HOLLYWOOD, CA 91601, USA",
    ),
    CustomersListModel(
      customerId: "4D6B4F35",
      fullName: "WALTER LI",
      phone: "9513688308",
      mobile: "",
      email: "WOW1328@YAHOO.COM",
      address: "5640 FARNA AVE, ARCADIA, CA 91006, USA",
    ),
    CustomersListModel(
      customerId: "FA9A200D",
      fullName: "MANUEL GOMEZ",
      phone: "3233603642",
      mobile: "",
      email: "MANUELCH.SBVL@GMAIL.COM",
      address: "1341 W 121ST ST, LOS ANGELES, CA 90044, USA",
    ),
    CustomersListModel(
      customerId: "10F46CD4",
      fullName: "RENE TELLEZ",
      phone: "6262221113",
      mobile: "",
      email: "MTELLEZ19@GMAIL.COM",
      address: "4916 N CLYBOURN AVE, COVINA, CA 91722, USA",
    ),
    CustomersListModel(
      customerId: "01ACBB26",
      fullName: "ALMA YESENIA DE LOS SANTOS",
      phone: "8184701567",
      mobile: "",
      email: "ABRAHAM.DELOSSANTOS",
      address: "13700 MERCER ST, PACOIMA, CA 91331, USA",
    ),
    CustomersListModel(
      customerId: "5C19CDC6",
      fullName: "LUIS ROBERTO ACOSTA",
      phone: "3232364853",
      mobile: "",
      email: "ACOSTALUIS@LIVE.COM",
      address: "311 S CONCORD ST, LOS ANGELES, CA 90063, USA",
    ),
    CustomersListModel(
      customerId: "C649FD1D",
      fullName: "HECTOR LUA",
      phone: "8189822693",
      mobile: "",
      email: "HECTORLUA075@GMAIL.COM",
      address: "7363 CARTWRIGHT AVE, SUN VALLEY, CA 91352, USA",
    ),
    CustomersListModel(
      customerId: "8EB48B1D",
      fullName: "ANDREA MELENDEZ ASTELLANOS",
      phone: "8184866556",
      mobile: "",
      email: "ANDREAMELENDEZ478",
      address: "12148 HOYT ST, SYLMAR, CA 91342, USA",
    ),
    CustomersListModel(
      customerId: "7E5A5FC9",
      fullName: "LI QUI",
      phone: "6263405158",
      mobile: "",
      email: "MINCEDMMINT@GMAIL.COM",
      address: "32 E LOS HIGOS ST, ALHAMBRA, CA 91801, USA",
    ),
    CustomersListModel(
      customerId: "8E60E4CF",
      fullName: "MARTHA AGUILAR DE MACHADO",
      phone: "6264333432",
      mobile: "",
      email: "MARTHA.MACHADO1015",
      address: "4556 PHELAN AVE, BALDWIN PARK, CA 91706, USA",
    ),
    CustomersListModel(
      customerId: "BFE74810",
      fullName: "LUIS MEDINA",
      phone: "8186319453",
      mobile: "",
      email: "LMEDINA1948ZACATECAS",
      address: "11020 LONGFORD ST, SYLMAR, CA 91342, USA",
    ),
    CustomersListModel(
      customerId: "A42C6F3F",
      fullName: "ERIKA MARTINEZ",
      phone: "6263206771",
      mobile: "",
      email: "MARTINEZ.ERIKA91",
      address: "11525 HEMLOCK ST, EL MONTE, CA 91732, USA",
    ),
    CustomersListModel(
      customerId: "C4F9A852",
      fullName: "HOVSEP KRKEYAN",
      phone: "8189706050",
      mobile: "",
      email: "MARIETAKRKEYAN",
      address: "13922 RUNNYMEDE ST, VAN NUYS, CA 91405",
    ),
    CustomersListModel(
      customerId: "0DA156C3",
      fullName: "JOSE BATALLA",
      phone: "7142703395",
      mobile: "",
      email: "JLSALGADO216@GMAIL.COM",
      address: "3111 W MONROE AVE, ANAHEIM, CA 92801, USA",
    ),
    CustomersListModel(
      customerId: "05A2E55E",
      fullName: "ASLANPOUR GHAHERI",
      phone: "8187107811",
      mobile: "",
      email: "7811BABA@GMAIL.COM",
      address: "5336 ORRVILLE AVE, WOODLAND HILLS, CA 91367, USA",
    ),
    CustomersListModel(
      customerId: "26A72145",
      fullName: "YOEL REP",
      phone: "8184213602",
      mobile: "",
      email: "YOELREP@NOEMAIL.COM",
      address: "631 PALMS BLVD, VENICE, CA 90291, USA",
    ),
    CustomersListModel(
      customerId: "E8CA00E",
      fullName: "EUGENE ALVARADO",
      phone: "2133084987",
      mobile: "",
      email: "EUGINEOALVARADO0847",
      address: "10346 BROADMEAD ST, SOUTH EL MONTE, CA 91733",
    ),
    CustomersListModel(
      customerId: "3F65DB79",
      fullName: "CLINTON SCOTT",
      phone: "8184008029",
      mobile: "",
      email: "KLANDERS@ACRISURE.COM",
      address: "10330 COLUMBUS AVE, MISSION HILLS, CA 91345, USA",
    ),
    CustomersListModel(
      customerId: "101F830B",
      fullName: "JORGE ENRIQUE MENENDEZ",
      phone: "8184295329",
      mobile: "",
      email: "MENENDEZJ55@YAHOO.COM",
      address: "22055 COVELLO ST, CANOGA PARK, CA 91303",
    ),
    CustomersListModel(
      customerId: "9BC6177F",
      fullName: "AADIP DESAI",
      phone: "3104024224",
      mobile: "",
      email: "AADIPD@GMAIL.COM",
      address: "2333 LOY LN LOS ANGELES, CA 90041",
    ),
    CustomersListModel(
      customerId: "2B3F5C8B",
      fullName: "MARK FISHER",
      phone: "8185714522",
      mobile: "",
      email: "MOMFISH19@GMAIL.COM",
      address: "7923 KYLE ST, SUNLAND, CA 91040, USA",
    ),
  ];
}
