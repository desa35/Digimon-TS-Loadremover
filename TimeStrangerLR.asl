state("Digimon Story Time Stranger")
{
	float load : "Digimon Story Time Stranger.exe", 0x1C46638, 0x10, 0x57C; // Seems to be brightness for main scene. 1 = Fully Dark
	byte taxiLoad: "Digimon Story Time Stranger.exe", 0x1BEBFC0, 0x5F0, 0xD8, 0x90, 0x88, 0x38, 0x40, 0x198; // Tracks different game states. 8 = Taxi load
}


init
{
	timer.IsGameTimePaused = false;
}

exit
{
	timer.IsGameTimePaused = true;
}

isLoading
{
	return current.load == 1 || current.load == 0 && current.taxiLoad == 8;
}

