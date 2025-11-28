'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "395b1d2780e7c2fed9b9f0b4455a07ad",
"version.json": "f6efeb07c8c5b5062bae24a668ea6a3a",
"index.html": "c3f8fdf74c8e68a863d51ac0b3a7128c",
"/": "c3f8fdf74c8e68a863d51ac0b3a7128c",
"main.dart.js": "d6bd1a583d358aa27406d7f2c043bd0b",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "a725ad08a4d1b340f280f2ff1c01d864",
"assets/AssetManifest.json": "db01de75d83725ae15b8faf6dbd313f7",
"assets/NOTICES": "e7e0854194f3e183c0d06f4342a53e41",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "2ebc19ac4efd11767e7ce2bb3cf2b8ab",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "316fe8fec50eb29d29fcbe7a7baf266b",
"assets/fonts/MaterialIcons-Regular.otf": "bfe9d107648309f1da039324da76af63",
"assets/data/sdb/aetzende-reiniger.json": "6c6b5bf4f77e5523ba78bf34facae50d",
"assets/data/sdb/uhu-plus-endfest-300.json": "74b8fd78a50df10afe9e8f261c4be2c8",
"assets/data/sdb/test-product.json": "c0ed213e4468d98e61044837d8af202b",
"assets/data/sdb/index.json": "ab0de72bdce5bdd4428ea342f5061a9e",
"assets/assets/pictograms/Verbotszeichen/P001-Allgemeines-Verbotszeichen.jpg": "2b166177d8f801082a93479eeedcac6d",
"assets/assets/pictograms/Verbotszeichen/P005-Kein-Trinkwasser.jpg": "76491f424579cc9360d31aa776e4c3b1",
"assets/assets/pictograms/Verbotszeichen/P013-Eingeschaltete-Mobiltelefone-verboten.jpg": "129c66b8b04a326f3a48f2e44f6f952b",
"assets/assets/pictograms/Verbotszeichen/P004-Fuer-Fussgaenger-verboten.jpg": "1a4a6a2131ebba0417168dc7185ca4f8",
"assets/assets/pictograms/Verbotszeichen/P002-Rauchen-verboten.jpg": "29a5b7eb0433448c662f1775996878a5",
"assets/assets/pictograms/Verbotszeichen/P031-Schalten-verboten.jpg": "4dfc3ce82b1a200d1dade9fe7d97869c",
"assets/assets/pictograms/Verbotszeichen/P020-Aufzug-im-Brandfall-nicht-benutzen.jpg": "b1af60b049d64a33385e6fbfe18035e1",
"assets/assets/pictograms/Verbotszeichen/WSP001-Laufen-verboten.jpg": "fef5015f20d5c366adc828a15e41202b",
"assets/assets/pictograms/Verbotszeichen/P042-Fuer-schwangere-Frauen-verboten.jpg": "69103f41e4bd2cb57f1eab6d0fb33f72",
"assets/assets/pictograms/Verbotszeichen/P012-keine-schwere-Last.jpg": "c1b6905c9ccafead0676f819b1ab03b7",
"assets/assets/pictograms/Verbotszeichen/P024-Betreten-der-Flaeche-verboten.jpg": "1f1bf72549c7a6734395437fed9986b7",
"assets/assets/pictograms/Verbotszeichen/P016-Mit-Wasser-spritzen-verboten.jpg": "f2262c35cb9e837a3f402cfc2065663b",
"assets/assets/pictograms/Verbotszeichen/P007-Kein-Zutritt-fuer-Personen-mit-Herzschrittmachern.jpg": "27c1d49dabdc285dc274def9d58342b1",
"assets/assets/pictograms/Verbotszeichen/P014-Kein-Zutritt-fuer-Personen-mit-Implantaten.jpg": "334565db27b550eacf1d7b7e2c7f83f1",
"assets/assets/pictograms/Verbotszeichen/D-P022-Besteigen-fuer-Unbefugte-verboten.jpg": "5c9d81df0393b0bf4bf8bbf247718766",
"assets/assets/pictograms/Verbotszeichen/P006-Fuer-Flurfoerderzeuge-verboten.jpg": "eb401af8ce68bbac547aa18b6e591c5a",
"assets/assets/pictograms/Verbotszeichen/P023-Abstellen-oder-Lagern-verboten.jpg": "2daf306078ab51a2fb705e77c356dfac",
"assets/assets/pictograms/Verbotszeichen/P021-Mitfuehren-von-Hunden-verboten.jpg": "97a3ce831c73bfc10303a82ce9e2f9e1",
"assets/assets/pictograms/Verbotszeichen/P003-Keine-offene-Flamme.jpg": "7b6bc0a11318896af03c340d92a56353",
"assets/assets/pictograms/Verbotszeichen/P022-Essen-und-Trinken-verboten.jpg": "7871db08c0cf9ba4461bb3d72c65ece8",
"assets/assets/pictograms/Verbotszeichen/P011-Mit-Wasser-loeschen-verboten.jpg": "63777ddace5af4d80e0b2b0a4dd32174",
"assets/assets/pictograms/Verbotszeichen/P028-Benutzen-von-Handschuhen-verboten.jpg": "638c969aee876d7f382e846b819dc6b7",
"assets/assets/pictograms/Verbotszeichen/P015_Hineinfassen_verboten.jpg": "751e88da2d5bb9b0b189a6064526651f",
"assets/assets/pictograms/Verbotszeichen/P027-Personenbefoerderung-verboten.jpg": "f7478f1e5b9717510fcaa9fb56c392b0",
"assets/assets/pictograms/Verbotszeichen/D-P006-Zutritt-fuer-Unbefugte-verboten.jpg": "91c47bda343aca28f332ba8352c6abfa",
"assets/assets/pictograms/Verbotszeichen/P010-Beruehren-verboten.jpg": "2b92826e34d132370eabe1b5e2ee399e",
"assets/assets/pictograms/Gebotszeichen/M015_Warnweste-benutzen.jpg": "e6bae9c9dccbbce5da5ebb1b88310f42",
"assets/assets/pictograms/Gebotszeichen/M022-Hautschutzmittel-benutzen.jpg": "1d131369c3a394b9c9641896950176f8",
"assets/assets/pictograms/Gebotszeichen/M010_Schutzkleidung-benutzen.jpg": "56ae34a4c06ffd1a4055dd6b394ff4cb",
"assets/assets/pictograms/Gebotszeichen/M024-Fussgaengerweg-benutzen.jpg": "6bae75055433e040d0d611ba0762635c",
"assets/assets/pictograms/Gebotszeichen/M012_Handlauf-benutzen.jpg": "39f0ef8c1b21a8cd585b3f5707582d05",
"assets/assets/pictograms/Gebotszeichen/M023-Uebergang-benutzen.jpg": "0f41d44d50c8bc47db6e506ec84a8986",
"assets/assets/pictograms/Gebotszeichen/M020-Rueckhaltesystem-benutzen.jpg": "9f8d5f24c86405caadb2249cffbb1e7a",
"assets/assets/pictograms/Gebotszeichen/M008_Fussschutz-benutzen.jpg": "c9d20f524e8bc13061bbdeabcf6998e8",
"assets/assets/pictograms/Gebotszeichen/M013_Gesichtsschutz-benutzen.jpg": "f9276b69cbe8387f35fad41eb9474f59",
"assets/assets/pictograms/Gebotszeichen/M018-Auffanggurt-benutzen.jpg": "a9823ed230ee08922dfa006fb1baf580",
"assets/assets/pictograms/Gebotszeichen/M004_Augenschutz-benutzen.jpg": "f2d9283bf6e05b8e6b99d1e8865aede5",
"assets/assets/pictograms/Gebotszeichen/M003_Gehoerschutz-benutzen.jpg": "fc34ebca1ad445d319005d7a7538a7d0",
"assets/assets/pictograms/Gebotszeichen/WSM001-Rettungsweste-benutzen.jpg": "648ff920b97a0e4353df6a275f44b1b9",
"assets/assets/pictograms/Gebotszeichen/M001_Allgemeines-Gebotszeichen.jpg": "ff9fcb3f06e4d53fb64ff9240006208b",
"assets/assets/pictograms/Gebotszeichen/M017_Atemschutz-benutzen.jpg": "20071fe39c5abd93391dad61901045fc",
"assets/assets/pictograms/Gebotszeichen/M009_Handschutz_benutzen.jpg": "e31c71fa188930d83a544b0a97e1153d",
"assets/assets/pictograms/Gebotszeichen/M011-Haende-waschen.jpg": "d57b62e35c61afa146ae0d3c382a7003",
"assets/assets/pictograms/Gebotszeichen/M026-Schutzschuerze-benutzen.jpg": "b9a785a5d3071d29bf2e009c6d8e5c42",
"assets/assets/pictograms/Gebotszeichen/M021-Vor-Wartung-oder-Reparatur-freischalten.jpg": "2d3e4ba1a6bcf97fdb78848cbc608e4c",
"assets/assets/pictograms/Gebotszeichen/M014_Kopfschutz-benutzen.jpg": "5dd16031db53b038391de83d9f09c8af",
"assets/assets/pictograms/Brandschutz/F006-Brandmeldetelefon.jpg": "cced22c2b2df9bd1bbde1bcd264e7881",
"assets/assets/pictograms/Brandschutz/Reichtungspfeil_rechts.jpg": "e79c10c7f997a1ff4bbaeb3f579bc61e",
"assets/assets/pictograms/Brandschutz/F005-Brandmelder.jpg": "052730c8f873042da429b3d44f64f041",
"assets/assets/pictograms/Brandschutz/F001-Feuerloescher.jpg": "9aca68473845835daa005943b042a9df",
"assets/assets/pictograms/Brandschutz/Richtungspfeil_rechts_unten.jpg": "1f8008943303f0e0f93aec726021b454",
"assets/assets/pictograms/Brandschutz/F004-Mittel-und-Geraete-zur-Brandbekaempfung.jpg": "a47539dea237a5133f44a41447bf3b05",
"assets/assets/pictograms/Brandschutz/F002-Loeschschlauch.jpg": "e63abc65947656baa51563ee92c9391e",
"assets/assets/pictograms/Brandschutz/F003-Feuerleiter.jpg": "b7ef6789501e8d8521c1b0166e7c842a",
"assets/assets/pictograms/Warnzeichen/W003_Warnung_vor_radioaktiven_Stoffen_oder_ionisierender_Strahlung.jpg": "025343f53c8087c17bdab26ede3e9b82",
"assets/assets/pictograms/Warnzeichen/W006%2520Warnung%2520vor%2520magnetischem%2520Feld.jpg": "13a50188087e4c54a0718e759cf63d3e",
"assets/assets/pictograms/Warnzeichen/W024-Warnung-vor-Handverletzungen.jpg": "afc11b133e46f2e2d8230a49da94b869",
"assets/assets/pictograms/Warnzeichen/W007%2520Warnung%2520vor%2520Hindernissen%2520am%2520Boden.jpg": "81ed2d7a634f08e4a938a3df5e1a2b8a",
"assets/assets/pictograms/Warnzeichen/W025-Warnung-vor-gegenlaeufigen-Rollen.jpg": "397d253ac56dad5694b1d08341c5af69",
"assets/assets/pictograms/Warnzeichen/W017-Warnung-vor-heisser-Oberflaeche.jpg": "43acf3f83802d377216025d8e1f2d5a4",
"assets/assets/pictograms/Warnzeichen/W002%2520Warnung%2520vor%2520explosionsgefa%25CC%2588hrlichen%2520Stoffen.jpg": "c1a6461625d755055ae0b741391a4983",
"assets/assets/pictograms/Warnzeichen/W004-Warnung-vor-Laserstrahl.jpg": "7522067a4617175eb87d81c85d14cf63",
"assets/assets/pictograms/Warnzeichen/W021-Warnung-vor-feuergefaehrlichen.jpg": "7dd9235fcc6daede1a611588822ef2e6",
"assets/assets/pictograms/Warnzeichen/W010-Warnung-vor-niedriger-Temperatur-Frost.jpg": "68596c7694694f44aad44fd3603b2720",
"assets/assets/pictograms/Warnzeichen/W009%2520Warnung%2520vor%2520Biogefa%25CC%2588hrdung.jpg": "a005eab915ecb4001d5588da99c10bce",
"assets/assets/pictograms/Warnzeichen/W014-Warnung-vor-Flurfoerderzeugen.jpg": "0d5b3da3126264160b01503dbab102dc",
"assets/assets/pictograms/Warnzeichen/W026-Warnung-vor-Gefahren-durch-das-Aufladen-von-Batterien.jpg": "337b3ed7c6441039eb0894ce03eaa9d2",
"assets/assets/pictograms/Warnzeichen/W012-Warnung-vor-elektrischer-Spannung.jpg": "4ca4ac488269fd7d04d632ea6f8fe0d6",
"assets/assets/pictograms/Warnzeichen/W028-Warnung-vor-brandfoerdernden-Stoffen.jpg": "3a6156799f7150d659850420cf61c321",
"assets/assets/pictograms/Warnzeichen/W011-Warnung-vor-Rutschgefahr.jpg": "0ec91589c0f6a1fc3ef17cd168b28278",
"assets/assets/pictograms/Warnzeichen/W001-Allgemeines-Warnzeichen.jpg": "f19add45f359aa9971249639e417a028",
"assets/assets/pictograms/Warnzeichen/W015-Warnung-vor-schwebender-Last.jpg": "55da20eead2eb952c72f685fa917f26a",
"assets/assets/pictograms/Warnzeichen/W005%2520Warnung%2520vor%2520nicht%2520ionisierender%2520Strahlung.jpg": "c8ee1998cd8337acbdb30f7847fcf83d",
"assets/assets/pictograms/Warnzeichen/W027-Warnung-vor-optischer-Strahlung.jpg": "083e065ba6880b3a4237dcbc3971e88c",
"assets/assets/pictograms/Warnzeichen/W023-Warnung-vor-aetzenden-Stoffen.jpg": "0bd3a44975efd7eb6243c7182bfe18db",
"assets/assets/pictograms/Warnzeichen/D-W021-Warnung-vor-explosionsfaehiger-Atmosphaere.jpg": "ea22dad4a055e66ff3aeb2d57c135990",
"assets/assets/pictograms/Warnzeichen/W041-Warnung-vor-Erstickungsgefahr.jpg": "3ede655855cf30bbe4db096f6696d763",
"assets/assets/pictograms/Warnzeichen/W018-Warnung-vor-automatischem-Anlauf.jpg": "2e9ca72f822526dca79f9a1f8b54ec54",
"assets/assets/pictograms/Warnzeichen/W016-Warnung-vor-giftigen-Stoffen.jpg": "687f12e9e6b1a9d990a97cc35e26a965",
"assets/assets/pictograms/Warnzeichen/W029-Warnung-vor-Gasflaschen.jpg": "2fe8243886af53f4c0c4e5e021bc86bd",
"assets/assets/pictograms/Warnzeichen/w011.jpg": "0ec91589c0f6a1fc3ef17cd168b28278",
"assets/assets/pictograms/Warnzeichen/W019-Warnung-vor-Quetschgefahr.jpg": "39bd907b58ab0f7716015b26da34d679",
"assets/assets/pictograms/Warnzeichen/w014.jpg": "0d5b3da3126264160b01503dbab102dc",
"assets/assets/pictograms/Warnzeichen/W008%2520Warnung%2520vor%2520Absturzgefahr.jpg": "797c59d0e866184c935edd9c5920800a",
"assets/assets/pictograms/Kennzeichnung-von-Gefahrstoffen/GHS_02_gr.gif": "83061bef259a2be9868c53ac02690013",
"assets/assets/pictograms/Kennzeichnung-von-Gefahrstoffen/GHS_08_gr.gif": "bc58e532e9fccf4239fdaee352079c69",
"assets/assets/pictograms/Kennzeichnung-von-Gefahrstoffen/GHS_04_gr.gif": "3cb5b0e61dee874309a80798d689b046",
"assets/assets/pictograms/Kennzeichnung-von-Gefahrstoffen/GHS_06_gr.gif": "bc8b2fa109a8c2ada2832b6379d6a5fc",
"assets/assets/pictograms/Kennzeichnung-von-Gefahrstoffen/GHS_03_gr.gif": "e15687f826d3d382fad74dd430113e18",
"assets/assets/pictograms/Kennzeichnung-von-Gefahrstoffen/GHS_01_gr.gif": "12e02de6314983d25384dc548c210307",
"assets/assets/pictograms/Kennzeichnung-von-Gefahrstoffen/GHS_09_gr.gif": "0af938401f9cac31d101b81d73f901c3",
"assets/assets/pictograms/Kennzeichnung-von-Gefahrstoffen/GHS_05_gr.gif": "73ce9078396144cdabfc8926249c9152",
"assets/assets/pictograms/Kennzeichnung-von-Gefahrstoffen/GHS_07_gr.gif": "74d8e1fa11f8056ee2aad499daf03320",
"assets/assets/pictograms/Piktogramme-Leitern/PI009_Die_obersten_4_Sprossen_nicht_besteigen.jpg": "f03b05d1ec1bd9a9e77da5a07ab45b51",
"assets/assets/pictograms/Piktogramme-Leitern/PI007_Nur_an_sichere_Flaechen_anlegen.jpg": "03c76e0e65fd72fa94db7811d6ed29b4",
"assets/assets/pictograms/Piktogramme-Leitern/PI005_Witterungsbedingungen.jpg": "5a33a94f0351a4aabd459ec1e02b915c",
"assets/assets/pictograms/Piktogramme-Leitern/PI008_Die_obersten_3_Sprossen_nicht_besteigen.jpg": "5f8bbc8b7da11e6c096d75664751ea97",
"assets/assets/pictograms/Piktogramme-Leitern/PI001_Maximale_Belastung.jpg": "dd49ef74143cf48148488476bbb167b7",
"assets/assets/pictograms/Piktogramme-Leitern/PI004_Ebener_und_tragfaehiger_Untergrund.jpg": "df851c6a3bd05245ad987c80339b5c74",
"assets/assets/pictograms/Piktogramme-Leitern/PI013_Gespannte_Spreizvorrichtung.jpg": "e8eca12d4cfd22a3211f6b6032354f9c",
"assets/assets/pictograms/Piktogramme-Leitern/PI014_Nicht_als_Anlegeleiter_nutzen.jpg": "648bbb7cfb21052d06d8847cc06d0bae",
"assets/assets/pictograms/Piktogramme-Leitern/PI015_Nicht_uebersteigen.jpg": "60d9d9d4e76c00fee6fefdf6fc7a853c",
"assets/assets/pictograms/Piktogramme-Leitern/PI010_Mindestens_1m_UEberstand.jpg": "34d3d132d8dbf34fe2fc8fc0caf432ea",
"assets/assets/pictograms/Piktogramme-Leitern/PI011_Stahlspitzen_auf_nachgiebigem_Untergrund.jpg": "89a1b73910cde0c32525b007e649f3b9",
"assets/assets/pictograms/Piktogramme-Leitern/PI003_Nicht_hinauslehnen.jpg": "37da2d9c693fe47e4f47e1a89c80203c",
"assets/assets/pictograms/Piktogramme-Leitern/PI002_Nur_eine_Person.jpg": "28bd6061bed4adc9cfccbb4dbf76837a",
"assets/assets/pictograms/Piktogramme-Leitern/PI012_Nicht_uebertreten.jpg": "4754d8a50d7a7ff94d13d96a4268467b",
"assets/assets/pictograms/Piktogramme-Leitern/PI016_Spreizsicherung_einlegen.jpg": "96fc3669fb375e5ee13056658e676a6f",
"assets/assets/pictograms/Piktogramme-Leitern/PI006_Anlegewinkel_beachten.jpg": "5e54098fbac52000d9ace665c5f76963",
"assets/assets/pictograms/Rettungszeichen/E016-Notausstieg-mit-Fluchtleiter.jpg": "7a70f49c4eb483d74351db4a3b0e9803",
"assets/assets/pictograms/Rettungszeichen/Reichtungspfeil_Rettung_rechts.jpg": "357358e57a30697496b191756ae73ba0",
"assets/assets/pictograms/Rettungszeichen/E012-Notdusche.jpg": "07a85f9c6fa8389a0a23caeee13d6986",
"assets/assets/pictograms/Rettungszeichen/E009-Arzt.jpg": "87138e12049e88e14ccc90a3ab11710c",
"assets/assets/pictograms/Rettungszeichen/E004-Notruftelefon.jpg": "6a33c44c82f8589bfe22bd60cab40896",
"assets/assets/pictograms/Rettungszeichen/E007-Sammelstelle.jpg": "9754f59927c7176d9171963c6e59871a",
"assets/assets/pictograms/Rettungszeichen/E017-Rettungsausstieg.jpg": "94eafc2de9dc45b0cdc2c0fad2ddd804",
"assets/assets/pictograms/Rettungszeichen/Rettungsweg-Notausgang-E002-Zusatzzeichen.jpg": "f9ae3f71b12762eaa2a69c01cc2285ca",
"assets/assets/pictograms/Rettungszeichen/Beispiel-Rettungsweg-Notausgang-E002-Zusatzzeichen.jpg": "2d55aebc6892c8c10075f65f73fd9676",
"assets/assets/pictograms/Rettungszeichen/E001-Rettungsweg-Notausgang-links.jpg": "e0f7d675ebe345665bc88256aa9aeb31",
"assets/assets/pictograms/Rettungszeichen/Richtungspfeil_Rettung_rechts_unten.jpg": "56fc53ac00b04f6f6e1707ac6a43d8fb",
"assets/assets/pictograms/Rettungszeichen/E002-Rettungsweg-Notausgang-rechts.jpg": "cb04c043150c762b1eb150d483bc0b28",
"assets/assets/pictograms/Rettungszeichen/E003-Erste-Hilfe.jpg": "48e21df0ac5e0fcc609b756b4b5e1f5a",
"assets/assets/pictograms/Rettungszeichen/E013-Krankentrage.jpg": "055edb1fcb918a2a2744d7f6fe48558d",
"assets/assets/pictograms/Rettungszeichen/D-E019_Notausstieg.jpg": "882002ddceadd39c60599499eeacc0b3",
"assets/assets/pictograms/Rettungszeichen/E010-Automatisierter-Externer-Defibrillator-AED.jpg": "f7db8964471b766e1fc8cb7a18074449",
"assets/assets/pictograms/Rettungszeichen/WSE001-Oeffentliche-Rettungsausruestung.jpg": "9a6ad73bc375d1f0d688ad20975bf127",
"assets/assets/pictograms/Rettungszeichen/E011-Augenspueleinrichtung.jpg": "82623a95746a3d030464ad3e9687a3ad",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
