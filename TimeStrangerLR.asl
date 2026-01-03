state("Digimon Story Time Stranger")
{
	float load : 		"Digimon Story Time Stranger.exe", 0x1C46638, 0x10, 0x57C; // Seems to be brightness for main scene. 1 = Fully Dark
	byte taxiLoad: 		"Digimon Story Time Stranger.exe", 0x1BEBFC0, 0x5F0, 0xD8, 0x90, 0x88, 0x38, 0x40, 0x198; // Tracks different game states. 8 = Taxi load
	byte partyChange: 	"Digimon Story Time Stranger.exe", 0x1C40500, 0x78, 0x28, 0x0, 0x58, 0xA7; // Textbox upon party change. 1 = Displayed; 0 = Not displayed
	int music: 			"Digimon Story Time Stranger.exe", 0x1F79980, 0x60, 0x0; // Current BGM being played. Used to determine events.
	byte autosave: 		"Digimon Story Time Stranger.exe", 0x1C479E0, 0x50, 0x20, 0x0, 0x46; // 1 = Autosave; 0 otherwise
	int mission: 		"Digimon Story Time Stranger.exe", 0x1C3AB40, 0x718, 0xC0, 0x110, 0x98; // Story flag value. 4294967295 (FFFFFFFF) between missions.
	int ap: 			"Digimon Story Time Stranger.exe", 0x1F7F3B8, 0xA18, 0x188, 0x590, 0x150, 0x40, 0x5C; // Tracks Anomaly Points currently held.
	int yen: 			"Digimon Story Time Stranger.exe", 0x1C3AB40, 0x40, 0x58; // Tracks Yen currently held.
	byte difficulty: 	"Digimon Story Time Stranger.exe", 0x1C3AB40, 0x40, 0x80; // Tracks current difficulty.
	int bossHP: 		"Digimon Story Time Stranger.exe", 0x1C3AB40, 0x80, 0x0, 0x110, 0x118, 0x608; // Tracks Current HP of enemy in Slot 1. Used for splitting.
}

startup
{
	vars.splitHere = false;
	vars.resetOK = false;
	vars.previousMission = 4294967295;
	vars.metalGreyHP = new List<int>{2552,3190,35700,83100};
	vars.vulcanusHP = new List<int>{5144,6430,63510,142860};
	
	//// Settings
	// Bosses
	settings.Add("bosses", true, "Bosses");
	settings.CurrentDefaultParent = "bosses";
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
	settings.Add("chrono", true, "Chronomon");
	settings.CurrentDefaultParent = null;
}

init
{
	timer.IsGameTimePaused = false;
}

split
{
	if (settings["chrono"] && current.music == 65535 && old.music == 952 && current.load == 1) { return true; }
	if (current.music == 214) { vars.splitHere = false; }
	if (current.yen > old.yen && vars.splitHere) { vars.splitHere = false; return true; }

	if (settings["metalGrey"] && vars.metalGreyHP.Contains(current.bossHP) && current.music == 204) { vars.splitHere = true; }
	if (settings["vulcanus"] && vars.vulcanusHP.Contains(current.bossHP) && current.music == 932) { vars.splitHere = true; }
	
}

update
{
	if (current.music == 114) { vars.resetOK = true; }
}

exit
{ timer.IsGameTimePaused = true; }

reset
{ if (current.music == 113 && current.yen == 10000) { vars.resetOK = false; return true; } }

start
{ return current.music == 113 && current.autosave == 1; }

isLoading
{ return current.load == 1 && current.partyChange == 0 || current.load == 0 && current.taxiLoad == 8; }
