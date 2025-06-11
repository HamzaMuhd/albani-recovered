import 'package:albani/core/configs/assets/app_vectors.dart';
import 'package:get/get.dart';

class Dua {
  final String arabicText;
  final String translation;
  final String transliteration;

  Dua({
    required this.arabicText,
    required this.translation,
    required this.transliteration,
  });
}

class Category {
  final String name;
  final String icon;
  final List<Dua> duas;

  Category({
    required this.name,
    this.icon = AppVectors.prayer,
    required this.duas,
  });
}

class AzkarController extends GetxController {
  final RxList<Category> categories = [
    Category(
      name: "Morning Azkar",
      duas: [
        Dua(
          arabicText:
              "أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ. اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَىْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ",
          translation:
              "I seek refuge in Allah from Satan the outcast. - Allah! There is none worthy of worship but He, the Ever Living, the One Who sustains and protects all that exists. Neither slumber nor sleep overtakes Him. To Him belongs whatever is in the heavens and whatever is on the earth. Who is he that can intercede with Him except with His Permission? He knows what happens to them in this world, and what will happen to them in the Hereafter. And they will never encompass anything of His Knowledge except that which He wills. His Throne extends over the heavens and the earth, and He feels no fatigue in guarding and preserving them. And He is the Most High, the Most Great.(Whoever says this when he rises in the morning will be protected from jinns until he retires in the evening, and whoever says it when retiring in the evening will be protected from them until he rises in the morning.)",
          transliteration:
              "A 'oothu billaahi minash-Shaytaanir-rajeem. Allaahu laa 'ilaaha 'illaa Huwal-Hayyul-Qayyoom, laa ta'khuthuhu sinatun wa laa nawm, lahu maa fis-samaawaati wa maa fil-'ardh, man thai-lathee yashfa'u 'indahu 'illaa bi'ithnih, ya'lamu maa bayna 'aydeehim wa maa khalfahum, wa laa yuheetoona bishay'im-min 'ilmihi 'illaa bimaa shaa'a, wasi'a kursiyyuhus samaawaati wal'ardh, wa laa ya'ooduhu hifdhuhumaa, wa Huwal- 'Aliyyul- 'Adheem.",
        ),
        Dua(
            arabicText:
                "قُلْ هُوَ اللَّـهُ أَحَدٌ، اللَّـهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ  قُلْ أَعُوذُ بِرَ‌بِّ الْفَلَقِ، مِن شَرِّ‌ مَا خَلَقَ، وَمِن شَرِّ‌ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ‌ النَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ‌ حَاسِدٍ إِذَا حَسَدَ  قُلْ أَعُوذُ بِرَ‌بِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَـٰهِ النَّاسِ، مِن شَرِّ‌ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ‌ النَّاسِ، مِنَ الْجِنَّةِ وَالنَّاسِ.",
            translation:
                "Recite Al-Ikhlas, Al-Falaq and An-Nas.(Whoever recites these Three times in the morning and in the evening, they will suffice him (as a protection) against everything.)",
            transliteration:
                "Qul huwa Allahu ahad, Allahu assamad, Lam yalid walam yoolad, Walam yakun lahu kufuwan ahad. Qul a'aoothu birabbi alfalaq, Min sharri ma khalaq, Wamin sharri ghasiqin ithawaqab, Wamin sharri annaffathatifee al'uqad, Wamin sharri hasidin itha hasad. Qul a'aoothu birabbi annas, Maliki annas, Ilahi annas, Min sharri alwaswasi alkhannas, Allathee yuwaswisu fee sudoori annas, Mina aljinnati wannas."),
        Dua(
            arabicText:
                "أَصْبَحْنَا وَأَصْبَحَ (اَمْسَيْنَا وَاَمْسَ) الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِيْ هَذَا الْيَوْمِ (اللَّيْلَةِ) وَخَيْرَ مَا بَعْدَهُ، وَأَعُوْذُ بِكَ مِنْ شَرِّ مَا فِي هَذَا الْيَوْمِ (اللَّيْلَةِ) وَشَرِّ مَا بَعْدَهُ، رَبِّ أَعُوْذُ بِكَ مِنَ الْكَسَلِ، وَسُوءِ الْكِبَرِ، رَبِّ أَعُوْذُ بِكَ مِنْ عَذَابٍ فِيْ النَّارِ وَعَذَابٍ فِيْ الْقَبْرِ",
            transliteration:
                "Asbahnaa wa 'asbahal-mulku ('Amsaynaa wa'amsal-mulku) lillaahi walhamdu lillaahi, laa 'ilaaha 'illallaahu wahdahu laa shareeka lahu, lahul-mulku wa lahul-hamdu wa Huwa 'alaa kulli shay'in Qadeer. Rabbi 'as'aluka khayra maa fee haathal-yawmi wa khayra maa ba'dahu wa 'a'oothu bika min sharri maa fee haathal-yawmi wa sharri maa ba'dahu, Rabbi 'a'oothu bika minal-kasali, wa soo'il-kibari, Rabbi 'a'oothu bika min 'athaabin fin-naari wa 'athaabin fil-qabri.",
            translation:
                "We have entered the morning (evening) and with it all dominion is Allah's. Praise is to Allah. None has the right to be worshiped but Allah alone, Who has no partner. To Allah belongs the dominion, and to Him is the praise and He is Able to do all things. My Lord, I ask You for the goodness of this day and of the days that come after it, and I seek refuge in You from the evil of this day and of the days that come after it. My Lord, I seek refuge in You from laziness and helpless old age. My Lord, I seek refuge in You from the punishment of Hell-fire, and from the punishment of the grave. (Recite in the bracket in the evening.)"),
        Dua(
            arabicText:
                "اللَّهُمَّ بِكَ أَصْبَحْنَا (أَمْسَـينا)، وَبِكَ أَمْسَيْنَا (أَصْبَحْنَا)، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ",
            translation:
                "O Allah, by You we enter the morning (evening) and by You we enter the evening (morning), by You we live and and by You we die, and to You is our resurrection. (Recite in the bracket in the evening.)",
            transliteration:
                "Allaahumma bika 'asbahnaa ('amsaynaa), wa bika 'amsaynaa, wa bika nahyaa, wa bika namootu wa 'ilaykan-nushoor."),
        Dua(
            arabicText:
                "اللَّهُمَّ أَنْتَ رَبِّي لَّا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِر لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ",
            translation:
                "O Allah, You are my Lord, there is none worthy of worship but You. You created me and I am your slave. I keep Your covenant, and my pledge to You so far as I am able. I seek refuge in You from the evil of what I have done. I admit to Your blessings upon me, and I admit to my misdeeds. Forgive me, for there is none who may forgive sins but You.(Whoever recites this with conviction in the evening and dies during that night shall enter Paradise, and whoever recites it with conviction in the morning and dies during that day shall enter Paradise.)",
            transliteration:
                "Allaahumma 'Anta Rabbee laa 'ilaaha 'illaa 'Anta, khalaqtanee wa 'anaa 'abduka, wa 'anaa 'alaa 'ahdika wa wa'dika mas-tata'tu, 'a'oothu bika min sharri maa sana'tu, 'aboo'u laka bini'matika 'alayya, wa 'aboo'u bithanbee faghfir lee fa'innahu laa yaghfiruth-thunooba 'illaa 'Anta."),
        Dua(
            arabicText:
                "اللَّهُمَّ إِنِّي أَصْبَحْتُ (اَمْسَيْتُ) أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ",
            translation:
                "O Allah, I have entered the morning (evening) and I witness You and witness the bearers of Your Throne, and Your angels and all of Your creation to witness that You are Allah, there is none worthy of worship but You alone, You have no partners, and that Muhammad is Your slave and Your Messenger. (Recite in the bracket in the evening.) (Allah will spare whoever says this four times in the morning or evening from the fire of Hell.)",
            transliteration:
                "Allaahumma 'innee 'asbahtu ('amsaytu) 'ush-hiduka wa 'ush-hidu hamalata 'arshika, wa malaa'ikataka wajamee'a khalqika, 'annaka 'Antallaahu laa 'ilaaha 'illaa 'Anta wahdaka laa shareeka laka, wa 'anna Muhammadan 'abduka wa Rasooluka. "),
        Dua(
            arabicText:
                "اللَّهُمَّ مَا أَصْبَحَ(أََمْسَ) بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لَا شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ",
            translation:
                "O Allah, I have entered the morning (evening) and I witness You and witness the bearers of Your Throne, and Your angels and all of Your creation to witness that You are Allah, there is none worthy of worship but You alone, You have no partners, and that Muhammad is Your slave and Your Messenger. (Recite in the bracket in the evening.) (Allah will spare whoever says this four times in the morning or evening from the fire of Hell.)",
            transliteration:
                "Allaahumma maa 'asbaha ('amsaa) bee min ni'matin 'aw bi'ahadin min khalqika faminka wahdaka laa shareeka laka, falakal-hamdu wa lakash-shukru. "),
        Dua(
            arabicText:
                "اللَّهُمَّ عَافِـني فِي بَدَنِي، اللَّهُمَّ عَافِـنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَهَ إلاَّ أَنْتَ. اللَّهُمَّ إِنِّي أَعُوذُبِكَ مِنَ الْكُفْر، وَالفَقْرِ، وَأَعُوذُبِكَ مِنْ عَذَابِ الْقَبْرِ ، لَا إلَهَ إلاَّ أَنْتَ",
            translation:
                "O Allah, make me healthy in my body. O Allah, preserve for me my hearing. O Allah, preserve for me my sight. There is none worthy of worship but You. O Allah, I seek refuge in You from disbelief and poverty and I seek refuge in You from the punishment of the grave. There is none worthy of worship but You. (Three times)",
            transliteration:
                "Allaahumma 'aafinee fee badanee, Allaahumma 'aafinee fee sam'ee, Allaahumma 'aafinee fee basaree, laa 'ilaaha 'illaa 'Anta (three times).Allaahumma 'innee 'a'oothu bika minal-kufri, walfaqri, wa 'a'oothu bika min 'athaabil-qabri, laa 'ilaaha 'illaa 'Anta."),
        Dua(
            arabicText:
                "حَسْبِيَ اللَّهُ لَآ إِلَهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ",
            translation:
                "Allah is sufficient for me. There is none worthy of worship but Him. I have placed my trust in Him, He is Lord of the Majestic Throne. (Seven times)(Allah will grant whoever recites this Seven times in the morning or evening whatever he desires from this world or the next.)",
            transliteration:
                "Hasbiyallaahu laa 'ilaaha 'illaa Huwa 'alayhi tawakkaltu wa Huwa Rabbul-'Arshil-'Adheem ."),
        Dua(
            arabicText:
                "اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ، اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي دِينِي، وَدُنْيَايَ، وَأَهْلِي، وَمَالِي، اللَّهُمَّ اسْتُرْ عَوْرَاتِي، وَآمِنْ رَوْعَاتِي، اللَّهُمَّ احْفَظْنِي مِنْ بَيْنِ يَدَيَّ، وَمِنْ خَلْفِي، وَعَنْ يَمِينِي، وَعَنْ شِمَالِي، وَمِنْ فَوْقِي، وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِيَ",
            translation:
                "O Allah, I seek Your forgiveness and Your protection in this world and the next. O Allah, I seek Your forgiveness and Your protection in my religion, in my worldly affairs, in my family and in my wealth. O Allah, conceal my secrets and preserve me from anguish. O Allah, guard me from what is in front of me and behind me, from my left, and from my right, and from above me. I seek refuge in Your Greatness from being struck down from beneath me.",
            transliteration:
                "Allaahumma 'innee 'as'alukal-'afwa wal'aafiyata fid-dunyaa wal'aakhirati, Allaahumma 'innee 'as'alukal-'afwa wal'aafiyata fee deenee wa dunyaaya wa 'ahlee, wa maalee , Allaahum-mastur 'awraatee, wa 'aamin raw'aatee, Allaahum-mahfadhnee min bayni yadayya, wa min khalfee, wa 'an yameenee, wa 'an shimaalee, wa min fawqee, wa 'a'oothu bi'adhamatika 'an 'ughtaala min tahtee. "),
        Dua(
            arabicText:
                "اللَّهُمَّ عَالِمَ الْغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّماوَاتِ وَالْأَرْضِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا أَنْتَ، أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي، وَمِنْ شَرِّ الشَّيْطَانِ وَشِرْكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءاً أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ",
            translation:
                "O Allah, Knower of the unseen and the evident , Maker of the heavens and the earth, Lord of everything and its Possessor, I bear witness that there is none worthy of worship but You. I seek refuge in You from the evil of my soul and from the evil of Satan and his helpers. (I seek refuge in You) from bringing evil upon my soul and from harming any Muslim.",
            transliteration:
                "Allaahumma 'Aalimal-ghaybi wash-shahaadati faatiras-samaawaati wal'ardhi, Rabba kulli shay'in wa maleekahu, 'ash-hadu 'an laa 'ilaaha 'illaa 'Anta, 'a'oothu bika min sharri nafsee, wa min sharrish-shaytaani wa shirkihi, wa 'an 'aqtarifa 'alaa nafsee soo'an, 'aw 'ajurrahu 'ilaa Muslimin."),
        Dua(
            arabicText:
                "بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الَْأرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ",
            translation:
                "In the Name of Allah, Who with His Name nothing can cause harm in the earth nor in the heavens, and He is the All-Hearing, the All-Knowing. (Three times)(Whoever recites it in the morning will not be afflicted by any calamity before evening, and whoever recites it in the evening will not be overtaken by any calamity before morning.)",
            transliteration:
                "Bismillaahil-lathee laa yadhurru ma'as-mihi shay'un fil-'ardhi wa laa fis-samaa'i wa Huwas-Samee 'ul- 'Aleem."),
        Dua(
            arabicText:
                "رَضِيتُ باللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِيناً، وَبِمُحَمَّدٍ صَلَى اللَّهُ عَلِيهِ وَسَلَّمَ نَبِيَّاً",
            translation:
                "I am pleased with Allah as my Lord, with Islam as my religion and with Muhammad (peace and blessings of Allah be upon him) as my Prophet. (Three times)(Allah has promised that anyone who says every morning or evening will be pleased on the Day of Resurrection.)",
            transliteration:
                "Radheetu billaahi Rabban, wa bil-'Islaami deenan, wa bi-Muhammadin (sallallaahu 'alayhi wa sallama) Nabiyyan."),
        Dua(
            arabicText:
                "يَاحَيُّ، يَا قَيُّومُ، بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ، وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ",
            translation:
                "O Ever Living One, O Eternal One, by Your mercy I call on You to set right all my affairs. Do not place me in charge of my soul even for the blinking of an eye.",
            transliteration:
                "Yaa Hayyu yaa Qayyoomu birahmatika 'astagheethu 'aslih lee sha'nee kullahu wa laa takilnee 'ilaa nafsee tarfata 'aynin."),
        Dua(
            arabicText:
                "أَصْبَحْنَا وَأَصْبَحَ (أَمْسَيْنا وَأَمْسَى) الْمُلْكُ لِلَّهِ رَبِّ الْعَالَمِينَ، اللَّهُمَّ إِنِّـي أَسْأَلُكَ خَـيْرَ هَذَا الْـيَوْمِ (اللَّـيْلَة)، فَتْحَهُ، وَنَصْرَهُ، وَنُورَهُ وَبَرَكَتَهُ، وَهُدَاهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِيهِ وَشَرِّ مَا بَعْدَهُ",
            translation:
                "We have entered the morning (evening) and with it all the dominion which belongs to Allah, Lord of all that exists. O Allah, I ask You for the goodness of this day, its victory, its help, its light, its blessings, and its guidance. I seek refuge in You from the evil that is in it and from the evil that follows it.(Recite in the bracket in the evening.)",
            transliteration:
                "Asbahnaa wa 'asbahal-mulku (Amsaynaa wa 'amsal-mulku) lillaahi Rabbil-'aalameen, Allaahumma 'innee 'as'aluka khayra haathal-yawmi (laylati), Fathahu wa nasrahu wa noorahu, wa barakatahu, wa hudaahu, wa'a'oothu bika min sharri maafeehi wa sharri maa ba'dahu."),
        Dua(
            arabicText:
                "أَصْبَحْنَا (أَمْسَيْنَا) عَلَى فِطْرَةِ الْإِسْلَامِ، وَعَلَى كَلِمَةِ الإِخْلَاصِ، وَعَلَى دِينِ نَبِـيِّنَا مُحَمَّدٍ، وَعَاـَى مِلَّـةِ أَبِينَا إِبْـرَاهِيـمَ، حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ الْمُشْرِكِينَ",
            translation:
                "We have entered the morning (evening) upon the natural religion of Islam, the word of sincere devotion, the religion of our Prophet Muhammad (peace and blessings of Allah be upon him), and the faith of our father Ibrahim. He was upright (in worshipping Allah), and a Muslim. He was not of those who worship others besides Allah. (Recite in the bracket in the evening.)",
            transliteration:
                "Asbahnaa ('Amsaynaa) 'alaa fitratil-'Islaami wa 'alaa kalimatil-'ikhlaasi, wa 'alaa deeni Nabiyyinaa Muhammadin, wa 'alaa millati 'abeenaa 'Ibraaheema, haneefan Musliman wa maa kaana minal-mushrikeen."),
        Dua(
            arabicText: "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ",
            translation:
                "Glory is to Allah and praise is to Him. (100 times)(Whoever recites this one hundred times in the morning and in the evening will not be surpassed on the Day of Resurrection by anyone having done better than this except for someone who had recited it more.)",
            transliteration: "Subhaanallaahi wa bihamdihi."),
        Dua(
            arabicText:
                "لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ",
            translation:
                "None has the right to be worshiped but Allah alone, Who has no partner. His is the dominion and His is the praise and He is Able to do all things. (10 times or once if tired.)",
            transliteration:
                "Laa 'ilaaha 'illallaahu wahdahu laa shareeka lahu, lahul-mulku wa lahul-hamdu, wa Huwa 'alaa kulli shay'in Qadeer."),
        Dua(
            arabicText:
                "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ",
            translation:
                "Glory is to Allah and praise is to Him, by the multitude of His creation, by His Pleasure, by the weight of His Throne, and by the extent of His Words. (Three times in the morning.)",
            transliteration:
                "Subhaanallaahi wa bihamdihi: 'Adada khalqihi, wa ridhaa nafsihi, wa zinata 'arshihi wa midaada kalimaatihi."),
        Dua(
            arabicText:
                "اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْماً نَافِعاً، وَ رِزْقاً طَيِّباً، وَ عَمَلاً مُتَقَبَّلاً",
            translation:
                "O Allah, I ask You for knowledge that is of benefit, a good provision, and deeds that will be accepted. (Recite in the morning.)",
            transliteration:
                "Allaahumma 'innee 'as'aluka 'ilman naafi'an, wa rizqan tayyiban, wa 'amalan mutaqabbalan."),
        Dua(
            arabicText: "أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ",
            translation:
                "I seek the forgiveness of Allah and repent to Him. (100 times during the day.)",
            transliteration: "Astaghfirullaaha wa 'atoobu 'ilayhi."),
        Dua(
            arabicText:
                "أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ",
            translation:
                "I seek refuge in the Perfect Words of Allah from the evil of what He has created. (Three times in the evening.)(Whoever recites this Three times in the evening will be protected from insect stings.)",
            transliteration:
                "A'oothu bikalimaatil-laahit-taammaati min sharri maa khalaqa."),
        Dua(
            arabicText: "اللَّهُمَّ صَلِّ وَسَلَّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ",
            translation:
                "Oh Allah, we ask you for peace and blessings upon our prophet Muhammad. (Ten times)(The Prophet saw said: 'Who recites blessings upon me 10 times in the morning and 10 times in the evening will obtain my intercession on the Day of Resurrection'.)",
            transliteration:
                "Allahumma salli wa sallim 'alaa nabiyyinaa Muhammadin")
      ],
    ),
    Category(
      name: "Evening Azkar",
      duas: [
        Dua(
          arabicText:
              "أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ. اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَىْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ",
          translation:
              "I seek refuge in Allah from Satan the outcast. - Allah! There is none worthy of worship but He, the Ever Living, the One Who sustains and protects all that exists. Neither slumber nor sleep overtakes Him. To Him belongs whatever is in the heavens and whatever is on the earth. Who is he that can intercede with Him except with His Permission? He knows what happens to them in this world, and what will happen to them in the Hereafter. And they will never encompass anything of His Knowledge except that which He wills. His Throne extends over the heavens and the earth, and He feels no fatigue in guarding and preserving them. And He is the Most High, the Most Great.(Whoever says this when he rises in the morning will be protected from jinns until he retires in the evening, and whoever says it when retiring in the evening will be protected from them until he rises in the morning.)",
          transliteration:
              "A 'oothu billaahi minash-Shaytaanir-rajeem. Allaahu laa 'ilaaha 'illaa Huwal-Hayyul-Qayyoom, laa ta'khuthuhu sinatun wa laa nawm, lahu maa fis-samaawaati wa maa fil-'ardh, man thai-lathee yashfa'u 'indahu 'illaa bi'ithnih, ya'lamu maa bayna 'aydeehim wa maa khalfahum, wa laa yuheetoona bishay'im-min 'ilmihi 'illaa bimaa shaa'a, wasi'a kursiyyuhus samaawaati wal'ardh, wa laa ya'ooduhu hifdhuhumaa, wa Huwal- 'Aliyyul- 'Adheem.",
        ),
        Dua(
            arabicText:
                "قُلْ هُوَ اللَّـهُ أَحَدٌ، اللَّـهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ  قُلْ أَعُوذُ بِرَ‌بِّ الْفَلَقِ، مِن شَرِّ‌ مَا خَلَقَ، وَمِن شَرِّ‌ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ‌ النَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ‌ حَاسِدٍ إِذَا حَسَدَ  قُلْ أَعُوذُ بِرَ‌بِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَـٰهِ النَّاسِ، مِن شَرِّ‌ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ‌ النَّاسِ، مِنَ الْجِنَّةِ وَالنَّاسِ.",
            translation:
                "Recite Al-Ikhlas, Al-Falaq and An-Nas.(Whoever recites these Three times in the morning and in the evening, they will suffice him (as a protection) against everything.)",
            transliteration:
                "Qul huwa Allahu ahad, Allahu assamad, Lam yalid walam yoolad, Walam yakun lahu kufuwan ahad. Qul a'aoothu birabbi alfalaq, Min sharri ma khalaq, Wamin sharri ghasiqin ithawaqab, Wamin sharri annaffathatifee al'uqad, Wamin sharri hasidin itha hasad. Qul a'aoothu birabbi annas, Maliki annas, Ilahi annas, Min sharri alwaswasi alkhannas, Allathee yuwaswisu fee sudoori annas, Mina aljinnati wannas."),
        Dua(
            arabicText:
                "أَصْبَحْنَا وَأَصْبَحَ (اَمْسَيْنَا وَاَمْسَ) الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِيْ هَذَا الْيَوْمِ (اللَّيْلَةِ) وَخَيْرَ مَا بَعْدَهُ، وَأَعُوْذُ بِكَ مِنْ شَرِّ مَا فِي هَذَا الْيَوْمِ (اللَّيْلَةِ) وَشَرِّ مَا بَعْدَهُ، رَبِّ أَعُوْذُ بِكَ مِنَ الْكَسَلِ، وَسُوءِ الْكِبَرِ، رَبِّ أَعُوْذُ بِكَ مِنْ عَذَابٍ فِيْ النَّارِ وَعَذَابٍ فِيْ الْقَبْرِ",
            transliteration:
                "Asbahnaa wa 'asbahal-mulku ('Amsaynaa wa'amsal-mulku) lillaahi walhamdu lillaahi, laa 'ilaaha 'illallaahu wahdahu laa shareeka lahu, lahul-mulku wa lahul-hamdu wa Huwa 'alaa kulli shay'in Qadeer. Rabbi 'as'aluka khayra maa fee haathal-yawmi wa khayra maa ba'dahu wa 'a'oothu bika min sharri maa fee haathal-yawmi wa sharri maa ba'dahu, Rabbi 'a'oothu bika minal-kasali, wa soo'il-kibari, Rabbi 'a'oothu bika min 'athaabin fin-naari wa 'athaabin fil-qabri.",
            translation:
                "We have entered the morning (evening) and with it all dominion is Allah's. Praise is to Allah. None has the right to be worshiped but Allah alone, Who has no partner. To Allah belongs the dominion, and to Him is the praise and He is Able to do all things. My Lord, I ask You for the goodness of this day and of the days that come after it, and I seek refuge in You from the evil of this day and of the days that come after it. My Lord, I seek refuge in You from laziness and helpless old age. My Lord, I seek refuge in You from the punishment of Hell-fire, and from the punishment of the grave. (Recite in the bracket in the evening.)"),
        Dua(
            arabicText:
                "اللَّهُمَّ بِكَ أَصْبَحْنَا (أَمْسَـينا)، وَبِكَ أَمْسَيْنَا (أَصْبَحْنَا)، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ",
            translation:
                "O Allah, by You we enter the morning (evening) and by You we enter the evening (morning), by You we live and and by You we die, and to You is our resurrection. (Recite in the bracket in the evening.)",
            transliteration:
                "Allaahumma bika 'asbahnaa ('amsaynaa), wa bika 'amsaynaa, wa bika nahyaa, wa bika namootu wa 'ilaykan-nushoor."),
        Dua(
            arabicText:
                "اللَّهُمَّ أَنْتَ رَبِّي لَّا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِر لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ",
            translation:
                "O Allah, You are my Lord, there is none worthy of worship but You. You created me and I am your slave. I keep Your covenant, and my pledge to You so far as I am able. I seek refuge in You from the evil of what I have done. I admit to Your blessings upon me, and I admit to my misdeeds. Forgive me, for there is none who may forgive sins but You.(Whoever recites this with conviction in the evening and dies during that night shall enter Paradise, and whoever recites it with conviction in the morning and dies during that day shall enter Paradise.)",
            transliteration:
                "Allaahumma 'Anta Rabbee laa 'ilaaha 'illaa 'Anta, khalaqtanee wa 'anaa 'abduka, wa 'anaa 'alaa 'ahdika wa wa'dika mas-tata'tu, 'a'oothu bika min sharri maa sana'tu, 'aboo'u laka bini'matika 'alayya, wa 'aboo'u bithanbee faghfir lee fa'innahu laa yaghfiruth-thunooba 'illaa 'Anta."),
        Dua(
            arabicText:
                "اللَّهُمَّ إِنِّي أَصْبَحْتُ (اَمْسَيْتُ) أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ",
            translation:
                "O Allah, I have entered the morning (evening) and I witness You and witness the bearers of Your Throne, and Your angels and all of Your creation to witness that You are Allah, there is none worthy of worship but You alone, You have no partners, and that Muhammad is Your slave and Your Messenger. (Recite in the bracket in the evening.) (Allah will spare whoever says this four times in the morning or evening from the fire of Hell.)",
            transliteration:
                "Allaahumma 'innee 'asbahtu ('amsaytu) 'ush-hiduka wa 'ush-hidu hamalata 'arshika, wa malaa'ikataka wajamee'a khalqika, 'annaka 'Antallaahu laa 'ilaaha 'illaa 'Anta wahdaka laa shareeka laka, wa 'anna Muhammadan 'abduka wa Rasooluka. "),
        Dua(
            arabicText:
                "اللَّهُمَّ مَا أَصْبَحَ(أََمْسَ) بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لَا شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ",
            translation:
                "O Allah, I have entered the morning (evening) and I witness You and witness the bearers of Your Throne, and Your angels and all of Your creation to witness that You are Allah, there is none worthy of worship but You alone, You have no partners, and that Muhammad is Your slave and Your Messenger. (Recite in the bracket in the evening.) (Allah will spare whoever says this four times in the morning or evening from the fire of Hell.)",
            transliteration:
                "Allaahumma maa 'asbaha ('amsaa) bee min ni'matin 'aw bi'ahadin min khalqika faminka wahdaka laa shareeka laka, falakal-hamdu wa lakash-shukru. "),
        Dua(
            arabicText:
                "اللَّهُمَّ عَافِـني فِي بَدَنِي، اللَّهُمَّ عَافِـنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَهَ إلاَّ أَنْتَ. اللَّهُمَّ إِنِّي أَعُوذُبِكَ مِنَ الْكُفْر، وَالفَقْرِ، وَأَعُوذُبِكَ مِنْ عَذَابِ الْقَبْرِ ، لَا إلَهَ إلاَّ أَنْتَ",
            translation:
                "O Allah, make me healthy in my body. O Allah, preserve for me my hearing. O Allah, preserve for me my sight. There is none worthy of worship but You. O Allah, I seek refuge in You from disbelief and poverty and I seek refuge in You from the punishment of the grave. There is none worthy of worship but You. (Three times)",
            transliteration:
                "Allaahumma 'aafinee fee badanee, Allaahumma 'aafinee fee sam'ee, Allaahumma 'aafinee fee basaree, laa 'ilaaha 'illaa 'Anta (three times).Allaahumma 'innee 'a'oothu bika minal-kufri, walfaqri, wa 'a'oothu bika min 'athaabil-qabri, laa 'ilaaha 'illaa 'Anta."),
        Dua(
            arabicText:
                "حَسْبِيَ اللَّهُ لَآ إِلَهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ",
            translation:
                "Allah is sufficient for me. There is none worthy of worship but Him. I have placed my trust in Him, He is Lord of the Majestic Throne. (Seven times)(Allah will grant whoever recites this Seven times in the morning or evening whatever he desires from this world or the next.)",
            transliteration:
                "Hasbiyallaahu laa 'ilaaha 'illaa Huwa 'alayhi tawakkaltu wa Huwa Rabbul-'Arshil-'Adheem ."),
        Dua(
            arabicText:
                "اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ، اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي دِينِي، وَدُنْيَايَ، وَأَهْلِي، وَمَالِي، اللَّهُمَّ اسْتُرْ عَوْرَاتِي، وَآمِنْ رَوْعَاتِي، اللَّهُمَّ احْفَظْنِي مِنْ بَيْنِ يَدَيَّ، وَمِنْ خَلْفِي، وَعَنْ يَمِينِي، وَعَنْ شِمَالِي، وَمِنْ فَوْقِي، وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِيَ",
            translation:
                "O Allah, I seek Your forgiveness and Your protection in this world and the next. O Allah, I seek Your forgiveness and Your protection in my religion, in my worldly affairs, in my family and in my wealth. O Allah, conceal my secrets and preserve me from anguish. O Allah, guard me from what is in front of me and behind me, from my left, and from my right, and from above me. I seek refuge in Your Greatness from being struck down from beneath me.",
            transliteration:
                "Allaahumma 'innee 'as'alukal-'afwa wal'aafiyata fid-dunyaa wal'aakhirati, Allaahumma 'innee 'as'alukal-'afwa wal'aafiyata fee deenee wa dunyaaya wa 'ahlee, wa maalee , Allaahum-mastur 'awraatee, wa 'aamin raw'aatee, Allaahum-mahfadhnee min bayni yadayya, wa min khalfee, wa 'an yameenee, wa 'an shimaalee, wa min fawqee, wa 'a'oothu bi'adhamatika 'an 'ughtaala min tahtee. "),
        Dua(
            arabicText:
                "اللَّهُمَّ عَالِمَ الْغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّماوَاتِ وَالْأَرْضِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا أَنْتَ، أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي، وَمِنْ شَرِّ الشَّيْطَانِ وَشِرْكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءاً أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ",
            translation:
                "O Allah, Knower of the unseen and the evident , Maker of the heavens and the earth, Lord of everything and its Possessor, I bear witness that there is none worthy of worship but You. I seek refuge in You from the evil of my soul and from the evil of Satan and his helpers. (I seek refuge in You) from bringing evil upon my soul and from harming any Muslim.",
            transliteration:
                "Allaahumma 'Aalimal-ghaybi wash-shahaadati faatiras-samaawaati wal'ardhi, Rabba kulli shay'in wa maleekahu, 'ash-hadu 'an laa 'ilaaha 'illaa 'Anta, 'a'oothu bika min sharri nafsee, wa min sharrish-shaytaani wa shirkihi, wa 'an 'aqtarifa 'alaa nafsee soo'an, 'aw 'ajurrahu 'ilaa Muslimin."),
        Dua(
            arabicText:
                "بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الَْأرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ",
            translation:
                "In the Name of Allah, Who with His Name nothing can cause harm in the earth nor in the heavens, and He is the All-Hearing, the All-Knowing. (Three times)(Whoever recites it in the morning will not be afflicted by any calamity before evening, and whoever recites it in the evening will not be overtaken by any calamity before morning.)",
            transliteration:
                "Bismillaahil-lathee laa yadhurru ma'as-mihi shay'un fil-'ardhi wa laa fis-samaa'i wa Huwas-Samee 'ul- 'Aleem."),
        Dua(
            arabicText:
                "رَضِيتُ باللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِيناً، وَبِمُحَمَّدٍ صَلَى اللَّهُ عَلِيهِ وَسَلَّمَ نَبِيَّاً",
            translation:
                "I am pleased with Allah as my Lord, with Islam as my religion and with Muhammad (peace and blessings of Allah be upon him) as my Prophet. (Three times)(Allah has promised that anyone who says every morning or evening will be pleased on the Day of Resurrection.)",
            transliteration:
                "Radheetu billaahi Rabban, wa bil-'Islaami deenan, wa bi-Muhammadin (sallallaahu 'alayhi wa sallama) Nabiyyan."),
        Dua(
            arabicText:
                "يَاحَيُّ، يَا قَيُّومُ، بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ، وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ",
            translation:
                "O Ever Living One, O Eternal One, by Your mercy I call on You to set right all my affairs. Do not place me in charge of my soul even for the blinking of an eye.",
            transliteration:
                "Yaa Hayyu yaa Qayyoomu birahmatika 'astagheethu 'aslih lee sha'nee kullahu wa laa takilnee 'ilaa nafsee tarfata 'aynin."),
        Dua(
            arabicText:
                "أَصْبَحْنَا وَأَصْبَحَ (أَمْسَيْنا وَأَمْسَى) الْمُلْكُ لِلَّهِ رَبِّ الْعَالَمِينَ، اللَّهُمَّ إِنِّـي أَسْأَلُكَ خَـيْرَ هَذَا الْـيَوْمِ (اللَّـيْلَة)، فَتْحَهُ، وَنَصْرَهُ، وَنُورَهُ وَبَرَكَتَهُ، وَهُدَاهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِيهِ وَشَرِّ مَا بَعْدَهُ",
            translation:
                "We have entered the morning (evening) and with it all the dominion which belongs to Allah, Lord of all that exists. O Allah, I ask You for the goodness of this day, its victory, its help, its light, its blessings, and its guidance. I seek refuge in You from the evil that is in it and from the evil that follows it.(Recite in the bracket in the evening.)",
            transliteration:
                "Asbahnaa wa 'asbahal-mulku (Amsaynaa wa 'amsal-mulku) lillaahi Rabbil-'aalameen, Allaahumma 'innee 'as'aluka khayra haathal-yawmi (laylati), Fathahu wa nasrahu wa noorahu, wa barakatahu, wa hudaahu, wa'a'oothu bika min sharri maafeehi wa sharri maa ba'dahu."),
        Dua(
            arabicText:
                "أَصْبَحْنَا (أَمْسَيْنَا) عَلَى فِطْرَةِ الْإِسْلَامِ، وَعَلَى كَلِمَةِ الإِخْلَاصِ، وَعَلَى دِينِ نَبِـيِّنَا مُحَمَّدٍ، وَعَاـَى مِلَّـةِ أَبِينَا إِبْـرَاهِيـمَ، حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ الْمُشْرِكِينَ",
            translation:
                "We have entered the morning (evening) upon the natural religion of Islam, the word of sincere devotion, the religion of our Prophet Muhammad (peace and blessings of Allah be upon him), and the faith of our father Ibrahim. He was upright (in worshipping Allah), and a Muslim. He was not of those who worship others besides Allah. (Recite in the bracket in the evening.)",
            transliteration:
                "Asbahnaa ('Amsaynaa) 'alaa fitratil-'Islaami wa 'alaa kalimatil-'ikhlaasi, wa 'alaa deeni Nabiyyinaa Muhammadin, wa 'alaa millati 'abeenaa 'Ibraaheema, haneefan Musliman wa maa kaana minal-mushrikeen."),
        Dua(
            arabicText: "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ",
            translation:
                "Glory is to Allah and praise is to Him. (100 times)(Whoever recites this one hundred times in the morning and in the evening will not be surpassed on the Day of Resurrection by anyone having done better than this except for someone who had recited it more.)",
            transliteration: "Subhaanallaahi wa bihamdihi."),
        Dua(
            arabicText:
                "لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ",
            translation:
                "None has the right to be worshiped but Allah alone, Who has no partner. His is the dominion and His is the praise and He is Able to do all things. (10 times or once if tired.)",
            transliteration:
                "Laa 'ilaaha 'illallaahu wahdahu laa shareeka lahu, lahul-mulku wa lahul-hamdu, wa Huwa 'alaa kulli shay'in Qadeer."),
        Dua(
            arabicText:
                "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ",
            translation:
                "Glory is to Allah and praise is to Him, by the multitude of His creation, by His Pleasure, by the weight of His Throne, and by the extent of His Words. (Three times in the morning.)",
            transliteration:
                "Subhaanallaahi wa bihamdihi: 'Adada khalqihi, wa ridhaa nafsihi, wa zinata 'arshihi wa midaada kalimaatihi."),
        Dua(
            arabicText:
                "اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْماً نَافِعاً، وَ رِزْقاً طَيِّباً، وَ عَمَلاً مُتَقَبَّلاً",
            translation:
                "O Allah, I ask You for knowledge that is of benefit, a good provision, and deeds that will be accepted. (Recite in the morning.)",
            transliteration:
                "Allaahumma 'innee 'as'aluka 'ilman naafi'an, wa rizqan tayyiban, wa 'amalan mutaqabbalan."),
        Dua(
            arabicText: "أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ",
            translation:
                "I seek the forgiveness of Allah and repent to Him. (100 times during the day.)",
            transliteration: "Astaghfirullaaha wa 'atoobu 'ilayhi."),
        Dua(
            arabicText:
                "أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ",
            translation:
                "I seek refuge in the Perfect Words of Allah from the evil of what He has created. (Three times in the evening.)(Whoever recites this Three times in the evening will be protected from insect stings.)",
            transliteration:
                "A'oothu bikalimaatil-laahit-taammaati min sharri maa khalaqa."),
        Dua(
            arabicText: "اللَّهُمَّ صَلِّ وَسَلَّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ",
            translation:
                "Oh Allah, we ask you for peace and blessings upon our prophet Muhammad. (Ten times)(The Prophet saw said: 'Who recites blessings upon me 10 times in the morning and 10 times in the evening will obtain my intercession on the Day of Resurrection'.)",
            transliteration:
                "Allahumma salli wa sallim 'alaa nabiyyinaa Muhammadin")
      ],
    ),
    // Add more categories with Duas here
  ].obs;

  // Fetch Duas by category name
  List<Dua> getDuasByCategory(String categoryName) {
    return categories
        .firstWhere(
          (category) => category.name == categoryName,
          orElse: () =>
              Category(name: categoryName, duas: []), // Handles null cases
        )
        .duas;
  }
}
