local version = "PickleSpammer\nv1.5.5"

 WhisperedApps = {}

where = GetRandomArgument(
"2");
-- put your ids for "where" here


local IsRandom = false;
--  set this to false if you want to randomly select PVP things

local pve = false;
local pvp = false;

-- this setting is to do PVP or PVE queues (all Legion raids/dungeons) or ALL pvp settings (randomly)
-- if you set both to true, it will do both.

local luaunlocked = true;
-- set this to TRUE if you're using this tool
-- also this will include an anti-afk mechanism if set true
-- http://www.ownedcore.com/forums/world-of-warcraft/world-of-warcraft-bots-programs/503852-no-memory-write-lua-unlocker-anti-afk.html

local WhisperSetting = true;
--  set this to false if you don't want to whisper players

local whispermessage = "3";


local timedur = 10;

--  Set this to how many seconds to sit in queue.


--  You can have unlimited titles (obviously, just match the pattern of array)
--  Title: has a maximum of 41 characters (including spaces)
title2 = GetRandomArgument(
"1");


--  You can have unlimited titles (obviously, just match the pattern of array)
--  Maximum of about 150 characters (haven't checked)
desc = GetRandomArgument(
"2");




-- 1.  Creating the Spam
 --  What we need to get started:
 --  /run spam(where) 
 --  where = the activity ID (you can see it down below in more comments)

-- 2.  Creating your Titles/Description
 -- Titles = title =  41 Characters or less (Please count yourself, I didn't add functions for that yet)
 -- Description = desc = Maximum of ~150 characters.  I haven't documented that, just be safe

-- 3.  Settings
 -- IsRandom = 
 -- if true it will randomly select from the list i created, you may want to do 15 second groups if you do this
 -- if false you can pick from the list of activity ids here (mind you this is US, I can't check EU - no account)
 --      ---- full activity ID list (https://docs.google.com/spreadsheets/d/1p5u_apEjdpe0IEpY9qLqk8ObVOcf6NsdCP42eOcKRBU)



-- Todo:
-- - implement the settings ✓ done
-- - build the whisper function on event trigger, not 5 seconds  
-- - turn whispermessage into an array random selector
-- - autoresponder (keyword)

--
--

function checkplayer(name)

local people = WhisperedApps;
for i = 1,#people do
	--print(people[i]);
	if(people[i] == name)then
	return true;
		end
	end
end  -- end function





function whisperapps(msg)

local applicants = C_LFGList.GetApplicants(); -- get applicant table

if(applicants == nil)then
	local applicants = 5;
end
 -- ^ the above if statement is just to break loops if needed

for i=1, #applicants do      -- loop through them
   local id, status, pendingStatus, numMembers, isNew, comment = C_LFGList.GetApplicantInfo(applicants[i]);
   for i=1, numMembers do  -- get number of 
    	  local name, class, localizedClass, level, itemLevel, honorLevel, tank, healer, damage, assignedRole, relationship = C_LFGList.GetApplicantMemberInfo(id, i);
    	  local displayName = name;
      	  if(displayName == nil) then
     	  	local displayName = "playernulled";
     	  elseif
     	  	(checkplayer(displayName) == true)then
     	  		local displayName = "playernulled"
     	  	else
    	  print(displayName.." - Whispering new applicant");
     	  SendChatMessage(msg, "WHISPER", nil, displayName)
     	  tinsert(WhisperedApps,displayName);
   			end
   		end   -- end members loop
	end -- end applicants loop
end
-- end whipser function



local frame = CreateFrame("FRAME", "PicklesSpammer");
frame:RegisterEvent("LFG_LIST_APPLICANT_UPDATED");
local function eventHandler(self, event, ...)
 whisperapps(whispermessage)
end
frame:SetScript("OnEvent", eventHandler);

-- ^  Creates whisper loop


local leaveframe = CreateFrame("FRAME", "PicklesSpammer");
leaveframe:RegisterEvent("GROUP_LEFT");
local function eventHandler(self, event, ...)
 				C_Timer.After(1, function()
						print("requeued")
						spam(where)
						--JumpOrAscendStart();
					end)
end
leaveframe:SetScript("OnEvent", eventHandler);

-- ^  Creates requeue loop


SLASH_SPAM1 = "/spam"
SlashCmdList["SPAM"] = function(msg)
spam(where);
end

function spam(where)



if(IsRandom == true)then
	if(pvp == true)then
 	where = GetRandomArgument(6,7,14,15,17,19,351,352,353,354,355,356,357,358,359,360,361,386,389,390,391,392,393,394);
 	-- for pvp
 	else if (pve == true)then
 	where = GetRandomArgument(425, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81)
 	-- for pve
 	end
  end 
end



C_LFGList.CreateListing(where,title2,0,0,"",desc,false)



C_Timer.After(timedur, function()
	C_LFGList.RemoveListing()
	LeaveParty()
		print("Left Group - Requeue");
		if(luaunlocked == true)then
				C_Timer.After(3, function()
						--print("requeued")
						--spam(dur,where)
						--JumpOrAscendStart();
					end)
			end
	end)
end



-- ## Here's a list of all the US configured ID's 
-- ## I don't have an EU account, so if someone wants to dump the list
-- ## I can explain how to use the function below 





-- function peep()
-- for i=1,1000 do
--    local name = C_LFGList.GetActivityInfo(i);
--    if(name == nil)then
--    	local name = "taco";
--    else
--    tinsert(LFGDumperr,name.." - "..i)
-- 			end
-- 		end
-- end

-- US Activity IDs (thanks Smitten for linking me the correct function)

-- Teldrassil - 2
-- Westfall - 3
-- Siege of Orgrimmar (Normal) - 4
-- Arena (2v2) - 6
-- Arena (3v3) - 7
-- Molten Core - 9
-- Arena Skirmish (2v2) - 14
-- Battlegrounds - 15
-- Custom PvE - 16
-- Custom PvP - 17
-- Deadmines (Normal) - 18
-- Rated Battlegrounds - 19
-- Random Pandaria Scenario (Normal) - 20
-- Bloodmaul Slag Mines (Normal) - 21
-- Iron Docks (Normal) - 22
-- Auchindoun (Normal) - 23
-- Skyreach (Normal) - 24
-- Grimrail Depot (Normal) - 25
-- The Everbloom (Normal) - 26
-- Shadowmoon Burial Grounds (Normal) - 27
-- Upper Blackrock Spire (Normal) - 28
-- Bloodmaul Slag Mines (Heroic) - 29
-- Iron Docks (Heroic) - 30
-- Auchindoun (Heroic) - 31
-- Skyreach (Heroic) - 32
-- Grimrail Depot (Heroic) - 33
-- The Everbloom (Heroic) - 34
-- Shadowmoon Burial Grounds (Heroic) - 35
-- Upper Blackrock Spire (Heroic) - 36
-- Highmaul (Normal) - 37
-- Highmaul (Heroic) - 38
-- Blackrock Foundry (Normal) - 39
-- Blackrock Foundry (Heroic) - 40
-- Siege of Orgrimmar (Heroic) - 41
-- Siege of Orgrimmar (Mythic) - 42
-- Naxxramas (10 Player) - 43
-- Naxxramas (25 Player) - 44
-- Karazhan - 45
-- Icecrown Citadel (10 Normal) - 46
-- Icecrown Citadel (10 Heroic) - 47
-- Icecrown Citadel (25 Normal) - 48
-- Icecrown Citadel (25 Heroic) - 49
-- Wailing Caverns (Normal) - 50
-- Scholomance (Normal) - 51
-- Ragefire Chasm (Normal) - 52
-- Shadowfang Keep (Normal) - 53
-- Blackfathom Deeps (Normal) - 54
-- Stormwind Stockade (Normal) - 55
-- Gnomeregan (Normal) - 56
-- Razorfen Kraul (Normal) - 57
-- Razorfen Downs (Normal) - 58
-- Uldaman (Normal) - 59
-- Zul'Farrak (Normal) - 60
-- Maraudon (Normal) - 61
-- Sunken Temple (Normal) - 62
-- Blackrock Depths (Normal) - 63
-- Lower Blackrock Spire (Normal) - 64
-- Dire Maul (Normal) - 65
-- Stratholme (Normal) - 66
-- Hellfire Ramparts (Normal) - 67
-- Blood Furnace (Normal) - 68
-- Shattered Halls (Normal) - 69
-- Slave Pens (Normal) - 70
-- Underbog (Normal) - 71
-- The Steamvault (Normal) - 72
-- Mana-Tombs (Normal) - 73
-- Auchenai Crypts (Normal) - 74
-- Sethekk Halls (Normal) - 75
-- Shadow Labyrinth (Normal) - 76
-- Scarlet Halls (Normal) - 77
-- Scarlet Monastery (Normal) - 78
-- The Escape from Durnholde (Normal) - 79
-- Opening of the Dark Portal (Normal) - 80
-- The Mechanar (Normal) - 81
-- The Botanica (Normal) - 82
-- The Arcatraz (Normal) - 83
-- Auchenai Crypts (Heroic) - 84
-- Mana-Tombs (Heroic) - 85
-- Sethekk Halls (Heroic) - 86
-- Shadow Labyrinth (Heroic) - 87
-- Opening of the Dark Portal (Heroic) - 88
-- The Escape from Durnholde (Heroic) - 89
-- Slave Pens (Heroic) - 90
-- The Steamvault (Heroic) - 91
-- Underbog (Heroic) - 92
-- Blood Furnace (Heroic) - 93
-- Hellfire Ramparts (Heroic) - 94
-- Shattered Halls (Heroic) - 95
-- The Arcatraz (Heroic) - 96
-- The Botanica (Heroic) - 97
-- The Mechanar (Heroic) - 98
-- Magisters' Terrace (Normal) - 99
-- Magisters' Terrace (Heroic) - 100
-- Utgarde Keep (Normal) - 101
-- Utgarde Pinnacle (Normal) - 102
-- Azjol-Nerub (Normal) - 103
-- The Oculus (Normal) - 104
-- Halls of Lightning (Normal) - 105
-- Halls of Stone (Normal) - 106
-- The Culling of Stratholme (Normal) - 107
-- Drak'Tharon Keep (Normal) - 108
-- Gundrak (Normal) - 109
-- Ahn'kahet: The Old Kingdom (Normal) - 110
-- Violet Hold (Normal) - 111
-- The Nexus (Normal) - 112
-- Trial of the Champion (Normal) - 113
-- The Forge of Souls (Normal) - 114
-- Pit of Saron (Normal) - 115
-- Halls of Reflection (Normal) - 116
-- Utgarde Pinnacle (Heroic) - 117
-- The Culling of Stratholme (Heroic) - 118
-- The Oculus (Heroic) - 119
-- Halls of Lightning (Heroic) - 120
-- Halls of Stone (Heroic) - 121
-- Drak'Tharon Keep (Heroic) - 122
-- Gundrak (Heroic) - 123
-- Ahn'kahet: The Old Kingdom (Heroic) - 124
-- Violet Hold (Heroic) - 125
-- The Nexus (Heroic) - 126
-- Azjol-Nerub (Heroic) - 127
-- Utgarde Keep (Heroic) - 128
-- Trial of the Champion (Heroic) - 129
-- The Forge of Souls (Heroic) - 130
-- Pit of Saron (Heroic) - 131
-- Halls of Reflection (Heroic) - 132
-- Throne of the Tides (Normal) - 133
-- Blackrock Caverns (Normal) - 134
-- Grim Batol (Normal) - 135
-- Halls of Origination (Normal) - 136
-- The Stonecore (Normal) - 137
-- The Vortex Pinnacle (Normal) - 138
-- Lost City of the Tol'vir (Normal) - 139
-- The Vortex Pinnacle (Heroic) - 140
-- The Stonecore (Heroic) - 141
-- Halls of Origination (Heroic) - 142
-- Grim Batol (Heroic) - 143
-- Blackrock Caverns (Heroic) - 144
-- Throne of the Tides (Heroic) - 146
-- Lost City of the Tol'vir (Heroic) - 147
-- Deadmines (Heroic) - 148
-- Shadowfang Keep (Heroic) - 149
-- Zul'Gurub (Heroic) - 150
-- Zul'Aman (Heroic) - 151
-- End Time (Heroic) - 152
-- Well of Eternity (Heroic) - 153
-- Hour of Twilight (Heroic) - 154
-- Temple of the Jade Serpent (Normal) - 155
-- Stormstout Brewery (Normal) - 156
-- Shado-Pan Monastery (Normal) - 157
-- Mogu'shan Palace (Normal) - 158
-- Siege of Niuzao Temple (Normal) - 159
-- Gate of the Setting Sun (Normal) - 160
-- Temple of the Jade Serpent (Heroic) - 163
-- Stormstout Brewery (Heroic) - 164
-- Shado-Pan Monastery (Heroic) - 165
-- Mogu'shan Palace (Heroic) - 166
-- Gate of the Setting Sun (Heroic) - 167
-- Scholomance (Heroic) - 168
-- Scarlet Monastery (Heroic) - 169
-- Scarlet Halls (Heroic) - 170
-- Siege of Niuzao Temple (Heroic) - 171
-- Frostfire Ridge - 172
-- Shadowmoon Valley (Draenor) - 173
-- Gorgrond - 174
-- Talador - 175
-- Spires of Arak - 176
-- Nagrand (Draenor) - 177
-- Bloodmaul Slag Mines (Challenge) - 179
-- Iron Docks (Challenge) - 180
-- Auchindoun (Challenge) - 181
-- Skyreach (Challenge) - 182
-- Grimrail Depot (Challenge) - 183
-- The Everbloom (Challenge) - 184
-- Shadowmoon Burial Grounds (Challenge) - 185
-- Upper Blackrock Spire (Challenge) - 186
-- New Tinkertown - 187
-- Coldridge Valley - 188
-- Northshire - 189
-- Gilneas City - 190
-- Sunstrider Isle - 191
-- Deathknell - 192
-- Dun Morogh - 193
-- Tirisfal Glades - 194
-- Eversong Woods - 195
-- Elwynn Forest - 196
-- Gilneas - 197
-- Loch Modan - 198
-- Ghostlands - 199
-- Silverpine Forest - 200
-- Ruins of Gilneas - 201
-- Redridge Mountains - 202
-- Wetlands - 203
-- Duskwood - 204
-- Hillsbrad Foothills - 205
-- Arathi Highlands - 206
-- Northern Stranglethorn - 207
-- The Cape of Stranglethorn - 208
-- The Hinterlands - 209
-- Stranglethorn Vale - 210
-- Western Plaguelands - 211
-- Burning Steppes - 212
-- Searing Gorge - 213
-- Badlands - 214
-- Eastern Plaguelands - 215
-- Twilight Highlands - 217
-- Vashj'ir - 219
-- Isle of Quel'Danas - 221
-- Blasted Lands - 222
-- Plaguelands: The Scarlet Enclave - 223
-- Swamp of Sorrows - 224
-- Deadwind Pass - 225
-- Blackrock Mountain - 226
-- Shadowglen - 227
-- Ammen Vale - 228
-- Valley of Trials - 229
-- Echo Isles - 230
-- Camp Narache - 231
-- Azuremyst Isle - 232
-- Mulgore - 234
-- Durotar - 235
-- Darkshore - 236
-- Bloodmyst Isle - 237
-- Northern Barrens - 238
-- Tanaris - 239
-- Thousand Needles - 240
-- Feralas - 241
-- Dustwallow Marsh - 242
-- Desolace - 243
-- Southern Barrens - 244
-- Stonetalon Mountains - 245
-- Ashenvale - 246
-- Moonglade - 247
-- Azshara - 248
-- Molten Front - 249
-- Uldum - 250
-- Mount Hyjal - 251
-- Silithus - 252
-- Winterspring - 253
-- Un'Goro Crater - 254
-- Felwood - 255
-- Hellfire Peninsula - 256
-- Zangarmarsh - 257
-- Terokkar Forest - 258
-- Nagrand - 259
-- Blade's Edge Mountains - 260
-- Netherstorm - 261
-- Shadowmoon Valley - 262
-- Borean Tundra - 263
-- Howling Fjord - 264
-- Dragonblight - 265
-- Grizzly Hills - 266
-- Sholazar Basin - 267
-- Zul'Drak - 268
-- Icecrown - 269
-- The Storm Peaks - 270
-- Hrothgar's Landing - 271
-- Crystalsong Forest - 272
-- Wintergrasp - 273
-- Tol Barad - 274
-- Tol Barad Peninsula - 275
-- Deepholm - 276
-- Darkmoon Island - 277
-- Kezan - 278
-- The Lost Isles - 279
-- The Wandering Isle - 280
-- The Jade Forest - 281
-- Krasarang Wilds - 282
-- Kun-Lai Summit - 283
-- Valley of the Four Winds - 284
-- The Veiled Stair - 285
-- Townlong Steppes - 286
-- Dread Wastes - 287
-- Isle of Giants - 288
-- Vale of Eternal Blossoms - 289
-- Isle of Thunder - 290
-- Timeless Isle - 291
-- Blackwing Lair - 293
-- Ruins of Ahn'Qiraj - 294
-- Ahn'Qiraj Temple - 295
-- Gruul's Lair - 296
-- Magtheridon's Lair - 297
-- Serpentshrine Cavern - 298
-- Tempest Keep - 299
-- Black Temple - 300
-- The Sunwell - 301
-- Ulduar (10 Player) - 302
-- Ulduar (25 Player) - 303
-- Trial of the Crusader (10 Normal) - 304
-- Trial of the Crusader (10 Heroic) - 305
-- Trial of the Crusader (25 Normal) - 306
-- Trial of the Crusader (25 Heroic) - 307
-- The Ruby Sanctum (10 Normal) - 308
-- The Ruby Sanctum (10 Heroic) - 309
-- The Ruby Sanctum (25 Normal) - 310
-- The Ruby Sanctum (25 Heroic) - 311
-- Blackwing Descent (10 Normal) - 313
-- Blackwing Descent (25 Normal) - 316
-- Blackwing Descent (10 Heroic) - 317
-- Blackwing Descent (25 Heroic) - 318
-- The Bastion of Twilight (10 Normal) - 319
-- The Bastion of Twilight (10 Heroic) - 320
-- The Bastion of Twilight (25 Heroic) - 321
-- The Bastion of Twilight (25 Normal) - 322
-- Throne of the Four Winds (10 Normal) - 323
-- Throne of the Four Winds (10 Heroic) - 324
-- Throne of the Four Winds (25 Heroic) - 325
-- Throne of the Four Winds (25 Normal) - 326
-- Firelands (10 Normal) - 327
-- Firelands (10 Heroic) - 328
-- Firelands (25 Normal) - 329
-- Firelands (25 Heroic) - 330
-- Dragon Soul (10 Normal) - 331
-- Dragon Soul (10 Heroic) - 332
-- Dragon Soul (25 Heroic) - 333
-- Dragon Soul (25 Normal) - 334
-- Mogu'shan Vaults (10 Normal) - 335
-- Mogu'shan Vaults (10 Heroic) - 336
-- Mogu'shan Vaults (25 Normal) - 337
-- Mogu'shan Vaults (25 Heroic) - 338
-- Heart of Fear (10 Normal) - 339
-- Heart of Fear (10 Heroic) - 340
-- Heart of Fear (25 Normal) - 341
-- Heart of Fear (25 Heroic) - 342
-- Terrace of Endless Spring (10 Normal) - 343
-- Terrace of Endless Spring (10 Heroic) - 344
-- Terrace of Endless Spring (25 Normal) - 345
-- Terrace of Endless Spring (25 Heroic) - 346
-- Throne of Thunder (10 Normal) - 347
-- Throne of Thunder (10 Heroic) - 348
-- Throne of Thunder (25 Heroic) - 349
-- Throne of Thunder (25 Normal) - 350
-- Battlegrounds - 351
-- Battlegrounds - 352
-- Battlegrounds - 353
-- Battlegrounds - 354
-- Battlegrounds - 355
-- Battlegrounds - 356
-- Battlegrounds - 357
-- Battlegrounds - 358
-- Battlegrounds - 359
-- Arena Skirmish (3v3) - 360
-- Ashran - 361
-- Random Pandaria Scenario (Heroic) - 362
-- Random Pandaria Dungeon (Normal) - 363
-- Random Pandaria Dungeon (Heroic) - 364
-- Theramore's Fall - 365
-- Battle on the High Seas (Normal) - 366
-- Battle on the High Seas (Heroic) - 367
-- Blood in the Snow (Normal) - 368
-- Blood in the Snow (Heroic) - 369
-- A Brewing Storm (Normal) - 370
-- A Brewing Storm (Heroic) - 371
-- Brewmoon Festival - 372
-- Dagger in the Dark - 373
-- Domination Point - 374
-- Lion's Landing - 375
-- Crypt of Forgotten Kings (Normal) - 376
-- Crypt of Forgotten Kings (Heroic) - 377
-- Greenstone Village - 378
-- Unga Ingoo - 379
-- Assault on Zan'vess - 380
-- Dark Heart of Pandaria (Normal) - 381
-- Dark Heart of Pandaria (Heroic) - 382
-- A Little Patience - 383
-- The Secrets of Ragefire (Normal) - 384
-- The Secrets of Ragefire (Heroic) - 385
-- Arena of Annihilation - 386
-- Arena Skirmish (2v2) - 389
-- Arena Skirmish (3v3) - 390
-- Arena Skirmish (2v2) - 391
-- Arena Skirmish (3v3) - 392
-- Arena Skirmish (2v2) - 393
-- Arena Skirmish (3v3) - 394
-- Random Warlords Dungeon (Normal) - 395
-- Random Warlords Dungeon (Heroic) - 396
-- World Bosses (Pandaria) - 397
-- World Bosses (Draenor) - 398
-- Highmaul (Mythic) - 399
-- Blackrock Foundry (Mythic) - 400
-- Bloodmaul Slag Mines (Mythic) - 401
-- Iron Docks (Mythic) - 402
-- Auchindoun (Mythic) - 403
-- Skyreach (Mythic) - 404
-- Grimrail Depot (Mythic) - 405
-- The Everbloom (Mythic) - 406
-- Shadowmoon Burial Grounds (Mythic) - 407
-- Upper Blackrock Spire (Mythic) - 408
-- Hellfire Citadel (Normal) - 409
-- Hellfire Citadel (Heroic) - 410
-- Tanaan Jungle - 411
-- Hellfire Citadel (Mythic) - 412
-- Emerald Nightmare (Normal) - 413
-- Emerald Nightmare (Heroic) - 414
-- The Nighthold (Normal) - 415
-- The Nighthold (Heroic) - 416
-- Random Legion Dungeon (Normal) - 417
-- Random Legion Dungeon (Heroic) - 418
-- Azsuna - 419
-- Val'sharah - 420
-- Highmountain - 421
-- Stormheim - 422
-- Suramar - 423
-- Battlegrounds - 424
-- Eye of Azshara (Normal) - 425
-- Darkheart Thicket (Normal) - 426
-- Halls of Valor (Normal) - 427
-- Neltharion's Lair (Normal) - 428
-- Assault on Violet Hold (Normal) - 429
-- Black Rook Hold (Normal) - 430
-- Vault of the Wardens (Normal) - 431
-- Maw of Souls (Normal) - 432
-- Court of Stars (Normal) - 433
-- The Arcway (Normal) - 434
-- Eye of Azshara (Heroic) - 435
-- Darkheart Thicket (Heroic) - 436
-- Halls of Valor (Heroic) - 437
-- Neltharion's Lair (Heroic) - 438
-- Assault on Violet Hold (Heroic) - 439
-- Black Rook Hold (Heroic) - 440
-- Vault of the Wardens (Heroic) - 441
-- Maw of Souls (Heroic) - 442
-- Court of Stars (Heroic) - 443
-- The Arcway (Heroic) - 444
-- Eye of Azshara (Mythic) - 445
-- Darkheart Thicket (Mythic) - 446
-- Halls of Valor (Mythic) - 447
-- Neltharion's Lair (Mythic) - 448
-- Assault on Violet Hold (Mythic) - 449
-- Black Rook Hold (Mythic) - 450
-- Vault of the Wardens (Mythic) - 451
-- Maw of Souls (Mythic) - 452
-- Court of Stars (Mythic) - 453
-- The Arcway (Mythic) - 454
-- Return to Karazhan (Mythic) - 455
-- Trial of Valor (Normal) - 456
-- Trial of Valor (Heroic) - 457
-- World Bosses (Legion) - 458
-- Eye of Azshara (Mythic Keystone) - 459
-- Darkheart Thicket (Mythic Keystone) - 460
-- Halls of Valor (Mythic Keystone) - 461
-- Neltharion's Lair (Mythic Keystone) - 462
-- Black Rook Hold (Mythic Keystone) - 463
-- Vault of the Wardens (Mythic Keystone) - 464
-- Maw of Souls (Mythic Keystone) - 465
-- Court of Stars (Mythic Keystone) - 466
-- The Arcway (Mythic Keystone) - 467
-- Emerald Nightmare (Mythic) - 468
-- Broken Shore - 469
-- Lower Karazhan (Heroic) - 470
-- Lower Karazhan (Mythic Keystone) - 471
-- Upper Karazhan (Heroic) - 472
-- Upper Karazhan (Mythic Keystone) - 473
-- Cathedral of Eternal Night (Heroic) - 474
-- Cathedral of Eternal Night (Mythic) - 475
-- Cathedral of Eternal Night (Mythic Keystone) - 476
-- Dreadscar Rift - 477
-- Tomb of Sargeras (Heroic) - 478
-- Tomb of Sargeras (Normal) - 479
-- Trial of Valor (Mythic) - 480
-- The Nighthold (Mythic) - 481


local ShowPatreon = false;

-- set to this to fall if you're a patreon user.  please subscribe, it's like only $1/mo to help me

StaticPopupDialogs["Patreon"] = {
  text = version.."\n\nHi! "..UnitName("player").."\n Thanks for using my addon.  Please consider supporting my patreon for faster updates and feature requests! \n\n\n ~Love,\n SniffingPickles\n\n\n",
  button1 = "Close",
  OnAccept = function()
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  maxLetters = 144,
  editBoxWidth = 350,
  preferredIndex = 3,  
  OnShow = function (self, data)
    self.editBox:SetText("https://www.patreon.com/sniffingpickles")
end,
OnAccept = function (self, data, data2)
    local text = self.editBox:GetText()
         print("To get started, please see the thread on Ownedcore OR Read through my guides at my blog https://sniffingpickles.com/blog")
end,
hasEditBox = true
}

if(ShowPatreon == true)then
StaticPopup_Show ("Patreon")
end

