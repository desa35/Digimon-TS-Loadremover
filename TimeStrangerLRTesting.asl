state("Digimon Story Time Stranger")
{
	float load : "Digimon Story Time Stranger.exe", 0x1C46638, 0x10, 0x57C;
	byte taxiLoad: "Digimon Story Time Stranger.exe", 0x1BEBFC0, 0x5F0, 0xD8, 0x90, 0x88, 0x38, 0x40, 0x198;
	byte partyChange: "Digimon Story Time Stranger.exe", 0x1B61B88, 0x32C, 0x268, 0x10, 0xA7;
	byte music: "Digimon Story Time Stranger.exe", 0x1F79980, 0x60, 0x0;
	byte autosave: "Digimon Story Time Stranger.exe", 0x1C479E0, 0x50, 0x20, 0x0, 0x46;
	byte test1: "Digimon Story Time Stranger.exe", 0x1C40500, 0x78, 0x28, 0x0, 0x58, 0xA7;
	byte test2: "Digimon Story Time Stranger.exe", 0x1F6BE88, 0x1F0, 0x120, 0x268, 0x10, 0xA7;
	byte test3: "Digimon Story Time Stranger.exe", 0x1C40500, 0x70, 0x8, 0x28, 0x0, 0x58, 0xA7;
	byte test4: "Digimon Story Time Stranger.exe", 0x1F7FC68, 0x2F8, 0x20, 0x0, 0x10, 0xE8, 0xA7;
	byte test5: "Digimon Story Time Stranger.exe", 0x1688EA90, 0x28, 0x80, 0x28, 0x138, 0x58, 0xA7;
	byte test6: "Digimon Story Time Stranger.exe", 0x1F6CF48, 0x274, 0xF8, 0x120, 0x268, 0x10, 0xA7;
	byte test7: "Digimon Story Time Stranger.exe", 0x1C3B068, 0x258, 0x370, 0x180, 0x60, 0x40, 0x30, 0xE8, 0xA7;
	byte test8: "Digimon Story Time Stranger.exe", 0x1C3B058, 0x448, 0x370, 0x180, 0x40, 0x70, 0x70, 0x78, 0xA7;
}


init
{
	timer.IsGameTimePaused = false;
}

exit
{
	timer.IsGameTimePaused = true;
}

start
{
	return current.music == 113 && current.autosave == 1;
}

gameTime
{
	if (current.test1 == 1 && current.load == 1)
		return TimeSpan.FromSeconds(3);
	else if (current.test2 == 1 && current.load == 1)
		return TimeSpan.FromSeconds(30);
	else if (current.test3 == 1 && current.load == 1)
		return TimeSpan.FromSeconds(300);
	else if (current.test4 == 1 && current.load == 1)
		return TimeSpan.FromSeconds(3000);
	else if (current.test5 == 1 && current.load == 1)
		return TimeSpan.FromSeconds(6);
	else if (current.test6 == 1 && current.load == 1)
		return TimeSpan.FromSeconds(60);
	else if (current.test7 == 1 && current.load == 1)
		return TimeSpan.FromSeconds(600);
	else if (current.test8 == 1 && current.load == 1)
		return TimeSpan.FromSeconds(6000);
	else
		return TimeSpan.FromSeconds(1);
}

isLoading
{
	return current.load == 1 || current.load == 0 && current.taxiLoad == 8;
}
