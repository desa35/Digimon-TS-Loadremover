state("Digimon Story Time Stranger")
{
	float load : "Digimon Story Time Stranger.exe", 0x1C46638, 0x10, 0x57C; // Brightness for main scene. 1 = Fully Dark.
	byte taxiLoad: "Digimon Story Time Stranger.exe", 0x1BEBFC0, 0x5F0, 0xD8, 0x90, 0x88, 0x38, 0x40, 0x198; // Tracks different game states. 8 = Taxi load
	byte partyChange: "Digimon Story Time Stranger.exe", 0x1C40500, 0x78, 0x28, 0x0, 0x58, 0xA7; // Textbox upon party change. 1 = Displayed; 0 = Not displayed.
	int music: "Digimon Story Time Stranger.exe", 0x1F79980, 0x60, 0x0; // Current BGM being played. Used to determine events.
	byte autosave: "Digimon Story Time Stranger.exe", 0x1C479E0, 0x50, 0x20, 0x0, 0x46; // 1 = Autosave; 0 otherwise.
	int mission: "Digimon Story Time Stranger.exe", 0x1F70878, 0x138, 0x40, 0x50, 0x60, 0xF8, 0x40, 0x148; // Story flag value. -1 between missions.
	int ap: "Digimon Story Time Stranger.exe", 0x1F7F3B8, 0xA18, 0x188, 0x590, 0x150, 0x40, 0x5C; // Tracks Anomaly Points currently held.
	int yen: "Digimon Story Time Stranger.exe", 0x1C3AB40, 0x40, 0x58; // Tracks Yen currently held.
	byte difficulty: "Digimon Story Time Stranger.exe", 0x1C3AB40, 0x40, 0x80; // Tracks current difficulty.
	int bossHP: "Digimon Story Time Stranger.exe", 0x1C3AB40, 0x80, 0x0, 0x110, 0x118, 0x608; // Tracks Current HP of enemy in Slot 1. Used for splitting.
}


startup
{
	vars.splitHere = false; // Used to determine if the AutoSplitter is allowed to split for Bosssplits.
	vars.lateStart = false; // Used as a failsave in case the automatic start doesn't react appropriately

	// Used to determine splitting behavior. Arrays all follow this pattern: {storyHP, balancedHP/hardHP, megaHP, mega+HP, bgm}
	vars.metalGreyHP = new List<int>{2552,3190,35700,83100,204};
	vars.kuwagaHP = new List<int>{3624,4530,67860,160020,312};
	vars.rareHP = new List<int>{4528,5660,71250,166800,807};
	vars.vadeHP = new List<int>{2640,3300,43065,100980,201};
	vars.cycloneHP = new List<int>{4568,5710,69390,162180,807};
	vars.greyHP = new List<int>{14112,17640,107190,238680,204};
	vars.blackCatHP = new List<int>{2752,3440,40470,94440,401};
	vars.titaHP = new List<int>{16472,20590,153270,306540,206};
	vars.ogreSewersHP = new List<int>{5792,7240,45840,102480,222};
	vars.parrotHP = new List<int>{20120,25150,145800,321000,204};
	vars.vulcanusHP = new List<int>{5144,6430,63510,142860,932};
	vars.sharkHP = new List<int>{19704,24630,150270,316500,930};
	vars.okuwaHP = new List<int>{14320,17900,103920,224040,207};
	vars.tyrantDungeonHP = new List<int>{5168,6460,26400,52800,954};
	vars.ogrePalaceHP = new List<int>{6048,7560,45000,95040,207};
	vars.coredraHP = new List<int>{4000,5000,29880,65040,805};
	vars.titaBerserkHP = new List<int>{11384,14230,90480,180960,806};
	vars.skullHP = new List<int>{21944,27430,152970,315060,930};
	vars.lanaHP = new List<int>{10336,12920,88980,181200,204};
	vars.calmaraHP = new List<int>{21032,26290,129090,259800,806};
	vars.witchHP = new List<int>{22360,27950,131640,263280,930};
	vars.tyrantBossHP = new List<int>{16496,20620,113160,228120,806};
	vars.grapHP = new List<int>{12032,15040,63600,127200,313};
	vars.callisHP = new List<int>{23712,29640,121320,242640,806};
	vars.venomHP = new List<int>{15928,19910,104970,209940,806};
	vars.zombieHP = new List<int>{26880,33600,150720,301440,931};
	vars.kugaHP = new List<int>{15128,18910,86130,172260,204};
	vars.apolloHP = new List<int>{27008,33760,133710,267420,932};
	vars.dianaHP = new List<int>{25248,31560,127110,254220,932};
	vars.soraHP = new List<int>{11296,14120,56160,112320,931};
	vars.junoHP = new List<int>{30992,38740,151860,303720,931};
	vars.giantHP = new List<int>{35520,44400,133200,266400,206};
	vars.barbaHP = new List<int>{19328,24160,105780,211560,931};
	vars.creepyHP = new List<int>{20272,25340,106620,213240,931};
	vars.lilithHP = new List<int>{21872,27340,102420,204840,931};
	vars.leviaHP = new List<int>{26912,33640,141720,283440,931};
	vars.luceHP = new List<int>{25712,32140,118170,236340,931};
	vars.beelzeHP = new List<int>{25312,31640,129720,259440,931};
	vars.belpheHP = new List<int>{14208,17760,75030,150060,931};
	
	//// Settings. All follow the pattern: {id, initiallyActive, displayedName}
	// Bosses
	settings.Add("bosses", true, "Bosses");
	settings.CurrentDefaultParent = "bosses"; // Removes necessity of stating Parent every time
	settings.Add("metalGrey", true, "MetalGreymon");
	settings.Add("kuwaga", true, "Kuwagamon");
	settings.Add("rare", true, "Raremon");
	settings.Add("vade", false, "Vademon");
	settings.Add("cyclone", true, "Cyclonemon");
	settings.Add("grey", true, "Greymon");
	settings.Add("blackCat", false, "BlackGatomon");
	settings.Add("tita", true, "Titamon");
	settings.Add("ogreSewers", true, "Ogremon 1");
	settings.Add("parrot", true, "Parrotmon");
	settings.Add("vulcanus", true, "Vulcanusmon");
	settings.Add("shark", true, "Sharkmon");
	settings.Add("okuwa", true, "Okuwamon");
	settings.Add("tyrantDungeon", true, "TyrantKabuterimon Outer Dungeon");
	settings.Add("ogrePalace", true, "Ogremon 2");
	settings.Add("coredra", false, "Coredramon (Green)");
	settings.Add("titaBerserk", true, "Titamon (Berserk)");
	settings.Add("skull", true, "SkullSeadramon");
	settings.Add("lana", false, "Lanamon");
	settings.Add("calmara", true, "Calmaramon");
	settings.Add("witch", true, "Witchmon");
	settings.Add("tyrantBoss", true, "TyrantKabuterimon");
	settings.Add("grap", false, "GrapLeomon");
	settings.Add("callis", true, "Callismon");
	settings.Add("venom", true, "VenomMyotismon");
	settings.Add("zombie", true, "ZombiePlutomon");
	settings.Add("kuga", true, "Power Loader");
	settings.Add("apollo", false, "Apollomon");
	settings.Add("diana", true, "Dianamon");
	settings.Add("sora", true, "ClavisAngemon");
	settings.Add("juno", true, "Junomon HM");
	settings.Add("giant", true, "Giant Slayer");
	settings.Add("barba", false, "Barbamon");
	settings.Add("creepy", false, "Creepymon");
	settings.Add("lilith", true, "Lilithmon");
	settings.Add("levia", false, "Leviamon");
	settings.Add("luce", false, "Lucemon SM");
	settings.Add("beelze", false, "Beelzemon BM");
	settings.Add("belphe", true, "Belphemon SM");
	settings.Add("chrono1", false, "Chronomon Phase 1");
	settings.Add("chrono2", false, "Chronomon Phase 2");
	settings.CurrentDefaultParent = null; // Resets default parentsplit

	// Chapters
	settings.Add("chapters", false, "Chapters");
	settings.CurrentDefaultParent = "chapters"; // Removes necessity of stating parentsplit every time
	settings.Add("ch10", true, "ADAMAS");
	settings.Add("ch20", true, "Signs of an Anomally");
	settings.Add("ch30", true, "The View after the End");
	settings.Add("ch40", true, "Reunions Bring Trouble");
	settings.Add("ch50", true, "The Time Stranger");
	settings.Add("ch60", true, "Resonating Thoughts");
	settings.Add("ch70", true, "Genius or Crackpot?");
	settings.Add("ch80", true, "A Vow Made on a Starry Sky");
	settings.Add("ch90", true, "Shinjuku Rhapsody");
	settings.Add("ch100", true, "The In-Between");
	settings.Add("ch110", true, "Truth Born from an Egg");
	settings.Add("ch120", true, "To the Untrodden World");
	settings.Add("ch130", true, "Rumble in the Underground");
	settings.Add("ch140", true, "Gathering Storm Clouds");
	settings.Add("ch150", true, "Incoming Conflict");
	settings.Add("ch160", true, "Audience with an Oracle");
	settings.Add("ch170", true, "On the Shores of Another World");
	settings.Add("ch180", true, "The World Tree's City");
	settings.Add("ch190", true, "War!");
	settings.Add("ch200", true, "The Beginning of the End");
	settings.Add("ch210", true, "The Defense of Nishi-Shinjuku");
	settings.Add("ch220", true, "Revelation in the White Light");
	settings.Add("ch230", true, "Re: The Time Stranger");
	settings.Add("ch235", true, "8 Years");
	settings.Add("ch240", true, "On My Life");
	settings.Add("ch250", true, "Metamorphosis");
	settings.Add("ch260", true, "Red Seas and Regret");
	settings.Add("ch280", true, "A Promise on a Scarf");
	settings.Add("ch285", true, "Class-S Anomalies");
	settings.Add("ch290", true, "Too Late");
	settings.Add("ch300", true, "The Titans' Grudge");
	settings.Add("ch310", true, "The Destruction of All Order");
	settings.Add("ch320", true, "The Paradise Colosseum");
	settings.Add("ch330", true, "The Violence of Humans");
	settings.Add("ch340", true, "Where did the Ribbon go?");
	settings.Add("ch350", true, "The God of Speed's Wish");
	settings.Add("ch360", true, "Throne of the Underworld");
	settings.Add("ch390", true, "No Cuer for Stupidity");
	settings.Add("ch400", true, "Fire and Ice at War");
	settings.Add("ch410", true, "The Mad Oracle");
	settings.Add("ch420", true, "The Cycle of Time");
	settings.Add("ch440", true, "The Final Battle over the Natural Order");
	settings.CurrentDefaultParent = null; // Resets default parentsplit

	
}

split
{

	// Activates splitHere during final phase of Chronomon
	if (current.music == 952 && !vars.splitHere) { vars.splitHere = true; }

	// Acts as the final split. Always active as the timer stops here.
	if (current.mission == 440 && current.music == 65535 && current.load == 1 && vars.splitHere) { return true; }
	
	//// Bosssplits
	// First Titamon fight. Doesn't give Yen and therefore splits on finishing the current mission which happens ~2 seconds later.
	if (old.mission == 110 && old.mission != current.mission && vars.splitHere) { return true; }

	// All fights except the final boss and Titamon increase yen upon victory. If splitHere is active it will split.
	if (current.yen > old.yen && vars.splitHere) { vars.splitHere = false; return true; }

	// Giving up on a battle plays SongID 214. Reset splitHere to avoid potential edgecases that leave splitHere active.
	if ((current.music == 214 || current.music == 0) && vars.splitHere) { vars.splitHere = false; }

	// Chronomon has three distinct phases. Each phase change the music changes which times the split.
	if (settings["chrono1"] && old.music == 950 && current.music == 951) { return true; }
	if (settings["chrono2"] && old.music == 951 && current.music == 952) { return true; }
	
	// Activates splitHere if the selected split is active, the main enemy has a specified HP value, the game plays the (Phase 1) boss battle theme and splitHere is inactive.
	if (settings["metalGrey"] && vars.metalGreyHP.Contains(current.bossHP) && vars.metalGreyHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["kuwaga"] && vars.kuwagaHP.Contains(current.bossHP) && vars.kuwagaHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["rare"] && vars.rareHP.Contains(current.bossHP) && vars.rareHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["vade"] && vars.vadeHP.Contains(current.bossHP) && vars.vadeHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["cyclone"] && vars.cycloneHP.Contains(current.bossHP) && vars.cycloneHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["grey"] && vars.greyHP.Contains(current.bossHP) && vars.greyHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["blackCat"] && vars.blackCatHP.Contains(current.bossHP) && vars.blackCatHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["tita"] && vars.titaHP.Contains(current.bossHP) && vars.titaHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["ogreSewers"] && vars.ogreSewersHP.Contains(current.bossHP) && vars.ogreSewersHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["parrot"] && vars.parrotHP.Contains(current.bossHP) && vars.parrotHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["vulcanus"] && vars.vulcanusHP.Contains(current.bossHP) && vars.vulcanusHP.Contains(current.music) && !vars.splitHere) { vars.splitHere = true; }
	if (settings["shark"] && vars.sharkHP.Contains(current.bossHP) && vars.sharkHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["okuwa"] && vars.okuwaHP.Contains(current.bossHP) && vars.okuwaHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["tyrantDungeon"] && vars.tyrantDungeonHP.Contains(current.bossHP) && vars.tyrantDungeonHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["ogrePalace"] && vars.ogrePalaceHP.Contains(current.bossHP) && vars.ogrePalaceHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["coredra"] && vars.coredraHP.Contains(current.bossHP) && vars.coredraHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["titaBerserk"] && vars.titaBerserkHP.Contains(current.bossHP) && vars.titaBerserkHP.Contains(current.music) && !vars.splitHere) { vars.splitHere = true; }
	if (settings["skull"] && vars.skullHP.Contains(current.bossHP) && vars.skullHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["lana"] && vars.lanaHP.Contains(current.bossHP) && vars.lanaHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["calmara"] && vars.calmaraHP.Contains(current.bossHP) && vars.calmaraHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["witch"] && vars.witchHP.Contains(current.bossHP) && vars.witchHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["tyrantBoss"] && vars.tyrantBossHP.Contains(current.bossHP) && vars.tyrantBossHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["grap"] && vars.grapHP.Contains(current.bossHP) && vars.grapHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["callis"] && vars.callisHP.Contains(current.bossHP) && vars.callisHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["venom"] && vars.venomHP.Contains(current.bossHP) && vars.venomHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["zombie"] && vars.zombieHP.Contains(current.bossHP) && vars.zombieHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["kuga"] && vars.kugaHP.Contains(current.bossHP) && vars.kugaHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["apollo"] && vars.apolloHP.Contains(current.bossHP) && vars.apolloHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["diana"] && vars.dianaHP.Contains(current.bossHP) && vars.dianaHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["sora"] && vars.soraHP.Contains(current.bossHP) && vars.soraHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["juno"] && vars.junoHP.Contains(current.bossHP) && vars.junoHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["giant"] && vars.giantHP.Contains(current.bossHP) && vars.giantHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["barba"] && vars.barbaHP.Contains(current.bossHP) && vars.barbaHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["creepy"] && vars.creepyHP.Contains(current.bossHP) && vars.creepyHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["lilith"] && vars.lilithHP.Contains(current.bossHP) && vars.lilithHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["levia"] && vars.leviaHP.Contains(current.bossHP) && vars.leviaHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["luce"] && vars.luceHP.Contains(current.bossHP) && vars.luceHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["beelze"] && vars.beelzeHP.Contains(current.bossHP) && vars.beelzeHP.Contains(current.music)) { vars.splitHere = true; }
	if (settings["belphe"] && vars.belpheHP.Contains(current.bossHP) && vars.belpheHP.Contains(current.music)) { vars.splitHere = true; }


	//// Chaptersplits
	// Splits when specific chapter is selected and a chapter conclused. Conclusion of a chapter causes mission to change to 4294967295
	if (settings["ch10"] && old.mission == 10 && old.mission != current.mission) { return true; }
	if (settings["ch20"] && old.mission == 20 && old.mission != current.mission) { return true; }
	if (settings["ch30"] && old.mission == 30 && old.mission != current.mission) { return true; }
	if (settings["ch40"] && old.mission == 40 && old.mission != current.mission) { return true; }
	if (settings["ch50"] && old.mission == 50 && old.mission != current.mission) { return true; }
	if (settings["ch60"] && old.mission == 60 && old.mission != current.mission) { return true; }
	if (settings["ch70"] && old.mission == 70 && old.mission != current.mission) { return true; }
	if (settings["ch80"] && old.mission == 80 && old.mission != current.mission) { return true; }
	if (settings["ch90"] && old.mission == 90 && old.mission != current.mission) { return true; }
	if (settings["ch100"] && old.mission == 100 && old.mission != current.mission) { return true; }
	if (settings["ch110"] && old.mission == 110 && old.mission != current.mission) { return true; }
	if (settings["ch120"] && old.mission == 120 && old.mission != current.mission) { return true; }
	if (settings["ch130"] && old.mission == 130 && old.mission != current.mission) { return true; }
	if (settings["ch140"] && old.mission == 140 && old.mission != current.mission) { return true; }
	if (settings["ch150"] && old.mission == 150 && old.mission != current.mission) { return true; }
	if (settings["ch160"] && old.mission == 160 && old.mission != current.mission) { return true; }
	if (settings["ch170"] && old.mission == 170 && old.mission != current.mission) { return true; }
	if (settings["ch180"] && old.mission == 180 && old.mission != current.mission) { return true; }
	if (settings["ch190"] && old.mission == 190 && old.mission != current.mission) { return true; }
	if (settings["ch200"] && old.mission == 200 && old.mission != current.mission) { return true; }
	if (settings["ch210"] && old.mission == 210 && old.mission != current.mission) { return true; }
	if (settings["ch220"] && old.mission == 220 && old.mission != current.mission) { return true; }
	if (settings["ch230"] && old.mission == 230 && old.mission != current.mission) { return true; }
	if (settings["ch235"] && old.mission == 235 && old.mission != current.mission) { return true; }
	if (settings["ch240"] && old.mission == 240 && old.mission != current.mission) { return true; }
	if (settings["ch250"] && old.mission == 250 && old.mission != current.mission) { return true; }
	if (settings["ch260"] && old.mission == 260 && old.mission != current.mission) { return true; }
	if (settings["ch280"] && old.mission == 280 && old.mission != current.mission) { return true; }
	if (settings["ch285"] && old.mission == 285 && old.mission != current.mission) { return true; }
	if (settings["ch290"] && old.mission == 290 && old.mission != current.mission) { return true; }
	if (settings["ch300"] && old.mission == 300 && old.mission != current.mission) { return true; }
	if (settings["ch310"] && old.mission == 310 && old.mission != current.mission) { return true; }
	if (settings["ch320"] && old.mission == 320 && old.mission != current.mission) { return true; }
	if (settings["ch330"] && old.mission == 330 && old.mission != current.mission) { return true; }
	if (settings["ch340"] && old.mission == 340 && old.mission != current.mission) { return true; }
	if (settings["ch350"] && old.mission == 350 && old.mission != current.mission) { return true; }
	if (settings["ch360"] && old.mission == 360 && old.mission != current.mission) { return true; }
	if (settings["ch390"] && old.mission == 390 && old.mission != current.mission) { return true; }
	if (settings["ch400"] && old.mission == 400 && old.mission != current.mission) { return true; }
	if (settings["ch410"] && old.mission == 410 && old.mission != current.mission) { return true; }
	if (settings["ch420"] && old.mission == 420 && old.mission != current.mission) { return true; }
	if (settings["ch440"] && old.mission == 440 && old.mission != current.mission) { return true; }
}

init
{
	timer.IsGameTimePaused = false;
}

exit
{
	timer.IsGameTimePaused = true;
}

gameTime
{
	if (vars.lateStart) { vars.lateStart = false; return TimeSpan.FromSeconds(9.8); }
}

reset
{
	if (old.music != current.music && current.music == 113) { vars.splitHere = false; return true; }
}

start
{
	if (current.music == 113 && current.autosave == 1 && timer.CurrentPhase != TimerPhase.Running) { return true; }
	if (old.music == 113 && current.music != old.music && timer.CurrentPhase != TimerPhase.Running) { vars.lateStart = true; return true; }
}

isLoading
{
	return current.load == 1 && current.partyChange == 0 || current.load == 0 && current.taxiLoad == 8;
}


