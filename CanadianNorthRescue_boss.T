% JENNIFER TRAN
% MRS. EAGLES
% CANADIAN NORTH RESCUE - FINAL PROJECT - JUNE 22nd 2009
% CANADIANNORTHRESCUE.T
% This program's purpose is to entertain and to amuse.
% If your computer does not have plenty of memory, this game may not work for you.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

import GUI % allows for buttons

View.Set ("Title:CANADIAN NORTH RESCUE") % change title of program

setscreen ("nocursor") % no flashing cursor displayed
setscreen ("nobuttonbar") % no bar displayed at the top
setscreen ("position:center;center,graphics:500;500") % set position and size of window

%%%%% VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% FONTS
var font : int := Font.New ("Comic Sans MS:18:bold") % level and health font
var fontpu : int := Font.New ("Comic Sans MS:6:bold") % items font

%%%%%%%%%%%%%%%%%%%%%%%% CONTROLS
var chars : array char of boolean % main key for Matt movement
var x, y : int := 220 % x and y coordinates of Matt sprite, 220 stands for beginning position
var fail : boolean := false % for Matt's health; true means 0 health which means death
var boss : boolean := false % for if player made it to boss
var coldstop : boolean := false % for cold temperature drop; true means health freezes
var goodd : boolean := false % for snow piles's proximity; true means it is too close
var goodpaw : boolean := false % for paw's proximity to Matt; true means too close
var goodml : boolean := false % for power-up's proximity to Matt; true means too close
var goodmnd : boolean := false % for snow mounds's proximity; true means too close
var goodice : boolean := false % for ice's proximity; true means too close
var epicwin : int % for how many times boss battle is won; 5 is max
var level : int % for level number
var levelS : string % converted level number to string

%%%%%%%%%%%%%%%%%%%%%%%% OBSTACLES
var x1, y1 : int % x and y coordinates of paw print
var xx, yy, kindd : array 1 .. 50 of int % x and y coordinates of snow piles, plus variable to determine image
var act : array 1 .. 50 of boolean % snow pile's boolean whether it has been activated or not
var ilvl : int := 5 % level to determine when ice is obstacle
var x2, y2, kind2 : array 1 .. 45 of int % x and y coordinates of snow mound, plus variable to determine image
var x3, y3 : array 1 .. 45 of int % x and y coordinates of ice
var slvl : int := 10 % level to determine when landmines are obstacles
var amount : int % amount of obstacles for normal levels
var amount2 : int % amount of obstacles for boss levels

%%%%%%%%%%%%%%%%%%%%%%%% INTERFACE VARIABLES
var health : int % health variable
var healthS : string % converted health amount to string
var healthcol : int % colour of health bar
var ml : int % determines whether power-up appears
var ml2 : int % determines which kind of power-up appears
var mx, my : int % x and y coorindates of power-up
var ml2_11 : boolean % variable whether maple leaf was used or not
var ml2_22 : boolean % variable whether Tim Hortons cup was used or not
var ml2_1 : int % quantity of maple leafs
var ml2_2 : int % quantity of Tim Hortons cups
var ml2_3 : int % quantity of bacon
var ml2_4 : int % quantity of poutine
var ml2_5 : int % quantity of pancakes
var ml2_1S, ml2_2S, ml2_3S, ml2_4S, ml2_5S : string := "0" % converted item quantity to string
var mlpic : int := Pic.FileNew ("sprites/ml.bmp") % maple leaf power-up image
var mlpic2 : int := Pic.FileNew ("sprites/ml2.bmp") % after maple leaf is picked up
var thpic : int := Pic.FileNew ("sprites/th.bmp") % Tim Hortons cup power-up image
var thpic2 : int := Pic.FileNew ("sprites/th2.bmp") % after Tim Hortons cup is picked up
var bpic : int := Pic.FileNew ("sprites/bacon.bmp") % bacon power-up image
var bpic2 : int := Pic.FileNew ("sprites/bacon2.bmp") % after bacon is picked up
var popic : int := Pic.FileNew ("sprites/poutine.bmp") % poutine power-up image
var popic2 : int := Pic.FileNew ("sprites/poutine2.bmp") % after poutine power-up
var papic : int := Pic.FileNew ("sprites/pancake.bmp") % pancakes power-up image
var papic2 : int := Pic.FileNew ("sprites/pancake2.bmp") % after pancakes is picked up
var bar : int := Pic.FileNew ("img/bar.jpg") % main interface bar
var PAUSE : boolean := false % variable for whether game is paused or not
var QUIT : boolean := false % variable whether player want to quit or not

%%%%%%%%%%%%%%%%%%%%%%%% LOAD STATUS IMAGES
var status : array 0 .. 10 of int % array for all status images
for a : 0 .. 10 % 10 images, 1 image for every 10 health points
    status (a) := Pic.FileNew ("img/status/" + intstr (a) + ".jpg")
end for

%%%%%%%%%%%%%%%%%%%%%%%% MAP IMAGES
var patch : int := Pic.FileNew ("sprites/patch1.bmp") % snow pile image
var patchb : int := Pic.FileNew ("sprites/patch2.bmp") % snow pile image 2
var bad : int := Pic.FileNew ("sprites/snow1.bmp") % snow mound image
var badb : int := Pic.FileNew ("sprites/snow1b.bmp") % snow mound image 2
var bad2 : int := Pic.FileNew ("sprites/ice.bmp") % ice image

%%%%%%%%%%%%%%%%%%%%%%%% BUTTONS
var buttonStartimg : int := Pic.FileNew ("img/buttonstart.jpg") % loads Start button image
var buttonStart : int := GUI.CreatePictureButton (30, 30, buttonStartimg, GUI.Quit)
GUI.Hide (buttonStart)
var buttonRightimg : int := Pic.FileNew ("img/buttonright.jpg") % loads right button image
var buttonRight : int := GUI.CreatePictureButton (378, 30, buttonRightimg, GUI.Quit)
GUI.Hide (buttonRight)

%%%%% SPRITES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% MATT MOVEMENT
var candownpics : array 0 .. 3 of int % down
var candown : int
for i : 1 .. 4
    candownpics (i - 1) := Pic.FileNew ("sprites/can_down" + intstr (i - 1) + ".bmp")
end for
candown := Sprite.New (candownpics (0))
var canrightpics : array 0 .. 3 of int % right
var canright : int
for i : 1 .. 4
    canrightpics (i - 1) := Pic.FileNew ("sprites/can_right" + intstr (i - 1) + ".bmp")
end for
canright := Sprite.New (canrightpics (0))
var canleftpics : array 0 .. 3 of int % left
var canleft : int
for i : 1 .. 4
    canleftpics (i - 1) := Pic.FileNew ("sprites/can_left" + intstr (i - 1) + ".bmp")
end for
canleft := Sprite.New (canleftpics (0))
var canuppics : array 0 .. 3 of int % up
var canup : int
for i : 1 .. 4
    canuppics (i - 1) := Pic.FileNew ("sprites/can_up" + intstr (i - 1) + ".bmp")
end for
canup := Sprite.New (canuppics (0))

%%%%%%%%%%%%%%%%%%%%%%%% MATT FROZEN
var canfrozpics : array 0 .. 3 of int
var canfroz : int
for i : 1 .. 4
    canfrozpics (i - 1) := Pic.FileNew ("sprites/can_froz" + intstr (i - 1) + ".bmp")
end for
canfroz := Sprite.New (canfrozpics (0))

%%%%%%%%%%%%%%%%%%%%%%%% MATT TRIUMPH
var canwinpics : array 0 .. 6 of int
var canwin : int
for i : 1 .. 7
    canwinpics (i - 1) := Pic.FileNew ("sprites/can_win" + intstr (i - 1) + ".bmp")
end for
canwin := Sprite.New (canwinpics (0))

%%%%%%%%%%%%%%%%%%%%%%%% LANDMINE EXPLOSION
var expics : array 0 .. 6 of int
var ex : int
for i : 1 .. 7
    expics (i - 1) := Pic.FileNew ("sprites/ex" + intstr (i - 1) + ".bmp")
end for
ex := Sprite.New (expics (0))

%%%%%%%%%%%%%%%%%%%%%%%% IVAN THE RUSSIAN
var rusdownpics : array 0 .. 3 of int % normal
var rusdown : int
for i : 1 .. 4
    rusdownpics (i - 1) := Pic.FileNew ("sprites/rus_down" + intstr (i - 1) + ".bmp")
end for
rusdown := Sprite.New (rusdownpics (0))
var rusangpics : array 0 .. 3 of int % angry
var rusang : int
for i : 1 .. 4
    rusangpics (i - 1) := Pic.FileNew ("sprites/rus_ang" + intstr (i - 1) + ".bmp")
end for
rusang := Sprite.New (rusangpics (0))

%%%%%%%%%%%%%%%%%%%%%%%% KUMAJIRO BEAR
var kuma : int
var kumapics : array 0 .. 1 of int
for i : 1 .. 2
    kumapics (i - 1) := Pic.FileNew ("sprites/kuma" + intstr (i - 1) + ".bmp")
end for
kuma := Sprite.New (kumapics (0))

%%%%%%%%%%%%%%%%%%%%%%%% KUMAJIRO BEAR ANIMATION
process kumaa
    loop
	for a : 1 .. 2
	    Sprite.ChangePic (kuma, kumapics (a mod 2))
	    delay (500)
	end for
	exit when epicwin = 0
    end loop
end kumaa

%%%%%%%%%%%%%%%%%%%%%%%% IVAN THE RUSSIAN ANIMATION
process russ % normal
    loop
	for a : 1 .. 4
	    Sprite.ChangePic (rusdown, rusdownpics (a mod 4))
	    delay (200)
	end for
	exit when epicwin = 5
    end loop
end russ
process russ2 % angry
    loop
	for a : 1 .. 4
	    Sprite.ChangePic (rusang, rusangpics (a mod 4))
	    delay (100)
	end for
    end loop
end russ2

%%%%% AUDIO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% MUSIC
process bossmusic % title and boss music
    Music.PlayFileLoop ("sfx/SOA_AIRBOSS.mp3")
end bossmusic
process music1 % level 1 to 5
    Music.PlayFileLoop ("sfx/SOA_AIRVOY.mp3")
end music1
process music2 % level 5 to 10
    Music.PlayFileLoop ("sfx/SOA_STAND.mp3")
end music2
process music3 % level 10 to 15
    Music.PlayFileLoop ("sfx/SOA_LVALUA.mp3")
end music3
process music4 % level 15 to 20
    Music.PlayFileLoop ("sfx/LO_BLIZ.mp3")
end music4
process winmusic % victory music
    Music.PlayFileStop
    Music.PlayFile ("sfx/SOA_VICTORY.mp3")
end winmusic
process losemusic % lose music
    Music.PlayFileStop
    Music.PlayFile ("sfx/APH_OMI.mp3")
end losemusic
%%%%%%%%%%%%%%%%%%%%%%%% SOUND EFFECTS
process historii % intro Historii sound
    Music.PlayFile ("sfx/historii.wav")
end historii
process wind % wind sound
    Music.PlayFile ("sfx/wind.wav")
end wind
process shovel % when item is picked up
    Music.PlayFile ("sfx/shovel.wav")
end shovel
process bomb % when landmine has exploded
    Music.PlayFile ("sfx/bomb.wav")
end bomb
process bite % when Matt eats food
    Music.PlayFile ("sfx/bite.wav")
end bite
process pwr % when maple leaf or Tim Hortons is used
    Music.PlayFile ("sfx/rise.wav")
end pwr

%%%%% PROCEDURES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% HEALTH
procedure healthstatus % this changes Matt's health status picture
    if ml2_11 = true or ml2_22 = true then % shows powerup
	if ml2_22 = true and ml2_11 = true then
	    Pic.ScreenLoad ("img/status_12.jpg", 22, 12, picCopy)
	elsif ml2_11 = true then
	    Pic.ScreenLoad ("img/status_1.jpg", 22, 12, picCopy)
	elsif ml2_22 = true then
	    Pic.ScreenLoad ("img/status_2.jpg", 22, 12, picCopy)
	end if
    elsif PAUSE = true then
	Pic.ScreenLoad ("img/status/p.bmp", 22, 12, picMerge) % pause message
    else
	if health > 90 then % changes picture according to health
	    Pic.Draw (status (10), 22, 12, picCopy)
	elsif health <= 90 and health > 80 then
	    Pic.Draw (status (9), 22, 12, picCopy)
	elsif health <= 80 and health > 70 then
	    Pic.Draw (status (8), 22, 12, picCopy)
	elsif health <= 70 and health > 60 then
	    Pic.Draw (status (7), 22, 12, picCopy)
	elsif health <= 60 and health > 50 then
	    Pic.Draw (status (6), 22, 12, picCopy)
	elsif health <= 50 and health > 40 then
	    Pic.Draw (status (5), 22, 12, picCopy)
	elsif health <= 40 and health > 30 then
	    Pic.Draw (status (4), 22, 12, picCopy)
	elsif health <= 30 and health > 20 then
	    Pic.Draw (status (3), 22, 12, picCopy)
	elsif health <= 20 and health > 10 then
	    Pic.Draw (status (2), 22, 12, picCopy)
	elsif health <= 10 and health > 0 then
	    Pic.Draw (status (1), 22, 12, picCopy)
	else
	    Pic.Draw (status (0), 22, 12, picCopy)
	end if
    end if
end healthstatus

procedure healthchange % this updates the health bar and HP
    if health >= 200 then % max health is always 200
	health := 200
    elsif health <= 0 then % death at 0 health
	health := 0
	fail := true
    end if
    if health >= 50 then % health colour change (green, orange, red)
	healthcol := 2
    elsif health < 50 and health >= 30 then
	healthcol := 42
    else
	healthcol := 12
    end if
    drawfillbox (250, 40, 325, 65, 151) % "erases" previous health number
    drawfillbox (152, 15, 352, 30, 150) % "erases" previous health metre
    drawfillbox (152, 15, 152 + health, 30, healthcol) % changes according to health
    healthS := intstr (health) % make into string
    Font.Draw (healthS, 260, 42, font, 0) % draws in health number
    healthstatus % changes picture
end healthchange

%%%%%%%%%%%%%%%%%%%%%%%% COLD TEMPERATURE DROP
process cold % cold temperature drop always active during levels
    var levelcur : int
    levelcur := level % determines the current level
    loop
	exit when level not= levelcur or coldstop = true or PAUSE = true % when level changes
	if level >= 15 then
	    delay (2500) % higher level means quicker health drain
	else
	    delay (5000)
	end if
	exit when level not= levelcur or coldstop = true or PAUSE = true
	health := health - 1
	healthchange
    end loop
end cold

%%%%%%%%%%%%%%%%%%%%%%%% INVENTORY
procedure items % inventory updates
    drawfillbox (389, 42, 394, 49, 151) % erases item quantity box
    drawfillbox (409, 42, 414, 49, 151)
    drawfillbox (429, 42, 434, 49, 151)
    drawfillbox (449, 42, 454, 49, 151)
    drawfillbox (469, 42, 474, 49, 151)
    ml2_1S := intstr (ml2_1) % converts item quantity to string
    ml2_2S := intstr (ml2_2)
    ml2_3S := intstr (ml2_3)
    ml2_4S := intstr (ml2_4)
    ml2_5S := intstr (ml2_5)
    Font.Draw (ml2_1S, 390, 42, fontpu, 0) % writes quantity of items
    Font.Draw (ml2_2S, 410, 42, fontpu, 0)
    Font.Draw (ml2_3S, 430, 42, fontpu, 0)
    Font.Draw (ml2_4S, 450, 42, fontpu, 0)
    Font.Draw (ml2_5S, 470, 42, fontpu, 0)
end items

%%%%%%%%%%%%%%%%%%%%%%%% MAPLE LEAF TIME
process ml2_time1 % when maple leaf is used
    items % update items
    loop
	var done1 : boolean := false % shows power-up is not done
	if ml2_11 = true then
	    if ml2_22 = true then % shows Matt with both power-ups
		Pic.ScreenLoad ("img/status_12.jpg", 22, 12, picCopy)
	    else % only maple leaf
		Pic.ScreenLoad ("img/status_1.jpg", 22, 12, picCopy)
	    end if
	    for t : 1 .. 200
		Pic.ScreenLoad ("img/item1.jpg", 378, 20, picCopy) % activated hotkey image
		drawfillbox (152, 13, 352, 14, 12) % refreshes bar by drawing same background colour
		drawfillbox (352 - t, 13, 352, 14, 151)
		delay (25)
		exit when coldstop = true % stop when no temperature drop
	    end for
	    done1 := true % shows power-up is done
	end if
	exit when done1 = true or coldstop = true
    end loop
    Pic.ScreenLoad ("img/item1b.jpg", 378, 20, picCopy) % returns hotkey button to normal
    drawfillbox (152, 13, 352, 14, 151) % clears timed bar
    ml2_11 := false % shows item is not in use
    healthstatus % updates image
end ml2_time1

%%%%%%%%%%%%%%%%%%%%%%%% TIM HORTONS TIME
process ml2_time2 % when Tim Hortons is used
    items % update items
    loop
	var done2 : boolean := false
	if ml2_22 = true then
	    if ml2_11 = true then % shows Matt with both power-ups
		Pic.ScreenLoad ("img/status_12.jpg", 22, 12, picCopy)
	    else % only Tim Hortons
		Pic.ScreenLoad ("img/status_2.jpg", 22, 12, picCopy)
	    end if
	    for t : 1 .. 200
		Pic.ScreenLoad ("img/item2.jpg", 399, 20, picCopy)  % activated hotkey image
		drawfillbox (152, 11, 352, 12, 113) % refreshes bar by drawing same background colour
		drawfillbox (352 - t, 11, 352, 12, 151)
		delay (25)
		exit when coldstop = true % stop when no temperature drop
	    end for
	    done2 := true % shows power-up is done
	end if
	exit when done2 = true or coldstop = true
    end loop
    drawfillbox (152, 11, 352, 12, 151) %  clears timed bar
    Pic.ScreenLoad ("img/item2b.jpg", 399, 20, picCopy) % returns hotkey button to normal
    ml2_22 := false % shows item is not in use
    healthstatus % updates image
end ml2_time2

%%%%% IVAN THE RUSSIAN DIALOGUE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
procedure rus1 % level 5
    Sprite.Hide (candown) % hides Matt so not to intrude on text
    Sprite.Hide (canup)
    Sprite.Hide (canleft)
    Sprite.Hide (canright)
    Pic.ScreenLoad ("img/rus1.jpg", 10, 400, picMerge) % image of Ivan with speech
    buttonRight := GUI.CreatePictureButton (400, 120, buttonRightimg, GUI.Quit)
    GUI.SetColor (buttonRight, 7)
    GUI.ResetQuit
    loop
	exit when GUI.ProcessEvent
    end loop
    GUI.Hide (buttonRight)
end rus1

procedure rus2 % level 10
    Sprite.Hide (candown) % hides Matt so not to intrude on text
    Sprite.Hide (canup)
    Sprite.Hide (canleft)
    Sprite.Hide (canright)
    Pic.ScreenLoad ("img/rus2.jpg", 10, 400, picMerge) % image of Ivan with speech
    buttonRight := GUI.CreatePictureButton (400, 120, buttonRightimg, GUI.Quit)
    GUI.SetColor (buttonRight, 7)
    GUI.ResetQuit
    loop
	exit when GUI.ProcessEvent
    end loop
    GUI.Hide (buttonRight)
end rus2

procedure rus3 % level 15
    Sprite.Hide (candown) % hides Matt so not to intrude on text
    Sprite.Hide (canup)
    Sprite.Hide (canleft)
    Sprite.Hide (canright)
    Pic.ScreenLoad ("img/rus3.jpg", 10, 400, picMerge) % image of Ivan with speech
    buttonRight := GUI.CreatePictureButton (400, 120, buttonRightimg, GUI.Quit)
    GUI.SetColor (buttonRight, 7)
    GUI.ResetQuit
    loop
	exit when GUI.ProcessEvent
    end loop
    GUI.Hide (buttonRight)
end rus3

%%%%% MINI GAMES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% TREE SHAKE
procedure game1
    coldstop := true % stop cold temperature drop
    %% loads all sprites
    var cantreepics : array 0 .. 3 of int
    var cantree : int
    for i : 1 .. 4
	cantreepics (i - 1) := Pic.FileNew ("sprites/cantree" + intstr (i - 1) + ".bmp")
    end for
    cantree := Sprite.New (cantreepics (0))
    var cantreewinpics : array 0 .. 12 of int
    var cantreewin : int
    for i : 1 .. 13
	cantreewinpics (i - 1) := Pic.FileNew ("sprites/cantreewin" + intstr (i - 1) + ".bmp")
    end for
    cantreewin := Sprite.New (cantreewinpics (0))
    Sprite.Hide (canright)
    Sprite.Hide (canleft)
    Sprite.Hide (canup)
    Sprite.Hide (candown)
    Pic.ScreenLoad ("img/mini/1bg.jpg", 1, 100, picCopy)

    var chars1, chars2 : boolean
    var power : int := 0 % shake bar
    var power2 : int := 0 % energy bar
    var timer : int
    var winner : boolean := false
    Sprite.SetPosition (cantreewin, 120, 220, false)
    Sprite.SetPosition (cantree, 120, 220, false)
    Sprite.ChangePic (cantree, cantreepics (0))
    Sprite.Show (cantree) % show beginning sprite

    buttonRight := GUI.CreatePictureButton (370, 125, buttonRightimg, GUI.Quit)
    GUI.SetColor (buttonRight, 7)
    GUI.ResetQuit
    loop
	exit when GUI.ProcessEvent
    end loop
    GUI.Disable (buttonRight)

    loop
	chars1 := false % reset keys
	chars2 := false
	power := power + 2 % gives more shake
	loop
	    timer := Time.Elapsed
	    if timer mod 1000 = 0 then % momentarily shake and energy goes down
		power := power - 1
		power2 := power2 + 2
		drawfillbox (416, 435 - power2, 464, 435, 0) % makes energy's empty area larger instead of energy smaller to avoid flickering
		drawfillbox (341, 238, 389, 435, 0) % refreshes shake bar
	    end if
	    locate (1, 1)
	    if power <= 0 then % shake can't be lower than 0
		power := 0
	    end if
	    drawfillbox (341, 238, 389, 235 + power, 151)
	    if power >= 200 then % if shake is at max
		power := 200
		winner := true
		exit
	    elsif power2 = 198 then % if energy is at 0
		exit
	    end if
	    Sprite.ChangePic (cantree, cantreepics (2))
	    Input.KeyDown (chars) % waits for key
	    if chars (KEY_RIGHT_ARROW) then % make sure right arrow key is pressed
		chars1 := true
		Sprite.ChangePic (cantree, cantreepics (1))
	    elsif chars (KEY_LEFT_ARROW) then % make sure left arrow key is pressed
		chars2 := true
		Sprite.ChangePic (cantree, cantreepics (3))
	    end if
	    exit when chars1 = true and chars2 = true % shake goes up only when both keys are pressed
	end loop
	exit when winner = true or power2 = 198 % when player wins or energy is low
    end loop
    if winner = true then
	Sprite.Hide (cantree)
	Sprite.Show (cantreewin)
	for a : 1 .. 7 % show item falling down
	    Sprite.ChangePic (cantreewin, cantreewinpics (a mod 8))
	    delay (100)
	end for
	Pic.ScreenLoad ("img/mini/1win.jpg", 1, 95, picCopy)
	loop
	    Input.KeyDown (chars) % waits for pressed key for item
	    if chars (chr (ORD_1)) then % maple leaf key
		ml2_1 := ml2_1 + 1
		Sprite.ChangePic (cantreewin, cantreewinpics (8))
		exit
	    elsif chars (chr (ORD_2)) then % Tim Hortons key
		ml2_2 := ml2_2 + 1
		Sprite.ChangePic (cantreewin, cantreewinpics (9))
		exit
	    elsif chars (chr (ORD_3)) then % bacon key
		ml2_3 := ml2_3 + 1
		Sprite.ChangePic (cantreewin, cantreewinpics (10))
		exit
	    elsif chars (chr (ORD_4)) then % poutine key
		ml2_4 := ml2_4 + 1
		Sprite.ChangePic (cantreewin, cantreewinpics (11))
		exit
	    elsif chars (chr (ORD_5)) then % pancakes key
		ml2_5 := ml2_5 + 1
		Sprite.ChangePic (cantreewin, cantreewinpics (12))
		exit
	    end if
	end loop
    else % show Matt not getting item
	Sprite.Hide (cantree)
	Pic.ScreenLoad ("sprites/cantreelose.bmp", 120, 220, picCopy)
	Pic.ScreenLoad ("img/mini/1lose.jpg", 1, 95, picCopy)
    end if
    items % updates items if game is won
    GUI.Enable (buttonRight) % activate continue button
    GUI.ResetQuit
    loop
	exit when GUI.ProcessEvent
    end loop
    GUI.Hide (buttonRight) % hide all game elements
    Sprite.Hide (cantree)
    Sprite.Hide (cantreewin)
    Sprite.Free (cantree)
    Sprite.Free (cantreewin)
    coldstop := false % start cold temperature drop
end game1

%%%%%%%%%%%%%%%%%%%%%%%% SNOWBALL THROW
procedure game2
    coldstop := true % stops cold temperature drop
    %% loads all sprites
    var cansnowpics : array 0 .. 3 of int
    var cansnow : int
    for i : 1 .. 4
	cansnowpics (i - 1) := Pic.FileNew ("sprites/cansnow" + intstr (i - 1) + ".bmp")
    end for
    cansnow := Sprite.New (cansnowpics (0))
    var cansnowwinpics : array 0 .. 15 of int
    var cansnowwin : int
    for i : 1 .. 16
	cansnowwinpics (i - 1) := Pic.FileNew ("sprites/cansnowwin" + intstr (i - 1) + ".bmp")
    end for
    cansnowwin := Sprite.New (cansnowwinpics (0))
    var cansnowlosepics : array 0 .. 5 of int
    var cansnowlose : int
    for i : 1 .. 6
	cansnowlosepics (i - 1) := Pic.FileNew ("sprites/cansnowlose" + intstr (i - 1) + ".bmp")
    end for
    cansnowlose := Sprite.New (cansnowlosepics (0))
    var linepics : array 1 .. 1 of int
    var lineS : int
    linepics (1) := Pic.FileNew ("sprites/line.jpg")
    lineS := Sprite.New (linepics (1))

    var aa : int := 0 % position of line is resetted
    var key : string (1) % any key

    Pic.ScreenLoad ("img/mini/2bg.jpg", 1, 100, picCopy) % background and isntructions
    Sprite.SetPosition (cansnow, 120, 220, false) % position all sprites
    Sprite.SetPosition (cansnowwin, 120, 220, false)
    Sprite.SetPosition (cansnowlose, 120, 220, false)
    Sprite.ChangePic (cansnow, cansnowpics (0))
    Sprite.Show (cansnow)

    drawfillbox (379, 350, 427, 375, 126) % show accuracy bar
    Sprite.SetPosition (lineS, 376, 363, false)
    Sprite.Show (lineS)

    buttonRight := GUI.CreatePictureButton (370, 125, buttonRightimg, GUI.Quit)
    GUI.SetColor (buttonRight, 7)
    GUI.ResetQuit
    loop
	exit when GUI.ProcessEvent % continue if button is pressed
    end loop
    GUI.Disable (buttonRight)

    loop
	for a : 237 .. 435 % line goes up bar
	    if hasch then
		aa := a
		exit
	    end if
	    Sprite.SetPosition (lineS, 376, a, false)
	    delay (5)
	end for
	exit when aa not= 0 % when key is pressed
	for decreasing a : 435 .. 237 % line goes down bar
	    if hasch then
		aa := a
		exit
	    end if
	    Sprite.SetPosition (lineS, 376, a, false)
	    delay (5)
	end for
	exit when aa not= 0 % when key is pressed
    end loop

    for a : 1 .. 3 % show Matt throwing snowball
	Sprite.ChangePic (cansnow, cansnowpics (a mod 4))
	delay (100)
    end for

    if aa >= 350 and aa <= 375 then % line is in right area
	Sprite.Hide (cansnow)
	Sprite.Show (cansnowwin)
	for a : 1 .. 10 % animating Matt getting item
	    Sprite.ChangePic (cansnowwin, cansnowwinpics (a mod 11))
	    delay (100)
	end for
	Pic.ScreenLoad ("img/mini/1win.jpg", 1, 94, picCopy)
	loop
	    Input.KeyDown (chars) % wait for pressed key to get item
	    if chars (chr (ORD_1)) then % maple leaf hotkey
		ml2_1 := ml2_1 + 1
		Sprite.ChangePic (cansnowwin, cansnowwinpics (11))
		exit
	    elsif chars (chr (ORD_2)) then % Tim Hortons hotkey
		ml2_2 := ml2_2 + 1
		Sprite.ChangePic (cansnowwin, cansnowwinpics (12))
		exit
	    elsif chars (chr (ORD_3)) then % bacon hotkey
		ml2_3 := ml2_3 + 1
		Sprite.ChangePic (cansnowwin, cansnowwinpics (13))
		exit
	    elsif chars (chr (ORD_4)) then % poutine hotkey
		ml2_4 := ml2_4 + 1
		Sprite.ChangePic (cansnowwin, cansnowwinpics (14))
		exit
	    elsif chars (chr (ORD_5)) then % pancakes hotkey
		ml2_5 := ml2_5 + 1
		Sprite.ChangePic (cansnowwin, cansnowwinpics (15))
		exit
	    end if
	end loop
    else % line is not in right area
	Sprite.Hide (cansnow)
	Sprite.Show (cansnowlose)
	for a : 1 .. 5 % animate Matt missing item
	    Sprite.ChangePic (cansnowlose, cansnowlosepics (a mod 6))
	    delay (250)
	end for
	Pic.ScreenLoad ("img/mini/2lose.jpg", 1, 95, picCopy)
    end if
    items % update item if game is won
    GUI.Enable (buttonRight)
    GUI.ResetQuit
    loop
	exit when GUI.ProcessEvent
    end loop
    GUI.Hide (buttonRight) % hide all elements of game
    Sprite.Hide (cansnowwin)
    Sprite.Hide (cansnowlose)
    Sprite.Hide (lineS)
    Sprite.Free (cansnow)
    Sprite.Free (cansnowwin)
    Sprite.Free (cansnowlose)
    Sprite.Free (lineS)
    coldstop := false % start cold temperature drop
end game2

%%%%%%%%%%%%%%%%%%%%%%%% MAP RANDOMIZATION
procedure rando
    Pic.Draw (bar, 1, 1, picCopy) % draws interface bar
    randomize
    amount := (level * 2) % amount of obstacles is always double the level
    amount2 := amount % amount of ice is equal to normal amount
    if boss = true then % less obstacles during boss
	amount := 10
	amount2 := 5
    end if
    loop % paw print location
	randint (x1, 20, 460) % randomizes x coordinates
	randint (y1, 115, 450) % randomizes y coordinates
	if x1 >= x - 150 and x1 <= x + 150 and y1 >= y - 150 and y1 <= y + 150 then
	    goodpaw := false % paw can't be close to Matt
	else
	    goodpaw := true
	end if
	exit when goodpaw = true % when paw is far enough
    end loop
    for z : 1 .. 50
	loop % snow piles locations
	    if boss = true then % location range for boss
		randint (xx (z), 185, 315) % randomizes x coordinates
		randint (yy (z), 100, 450) % randomizes y coordinates
	    else % normal location range
		randint (xx (z), 20, 460) % randomizes x coordinates
		randint (yy (z), 115, 450) % randomizes y coordinates
	    end if
	    if xx (z) >= x - 50 and xx (z) <= x + 60 and yy (z) >= y - 50 and yy (z) <= y + 60 then
		goodd := false % piles can't be close to Matt
	    else
		goodd := true
		randint (kindd (z), 1, 2) % randomizes what image of snow pile to use
		act (z) := false % landmine has not been triggered
	    end if
	    exit when goodd = true % when snow pile is far enough
	end loop
    end for
    randint (ml, 1, 5) % randomizes event of power-up appearing
    if ml = 1 then
	loop
	    if boss = true then % power-up location range for boss
		randint (mx, 185, 315) % randomizes x coordinates
		randint (my, 105, 400) % randomizes y coordinates
	    else % normal location range for power-up
		randint (mx, 10, 480) % randomizes x coordinates
		randint (my, 105, 470) % randomizes y coordinates
	    end if
	    if mx >= x - 75 and mx <= x + 75 and my >= y - 75 and my <= y + 75 then
		goodml := false % power-up can't be close to Matt
	    elsif mx >= x1 - 75 and mx <= x1 + 75 and my >= y1 - 75 and my <= y1 + 75 then
		goodml := false
	    else
		goodml := true
	    end if
	    exit when goodml = true % when power-up is far enough
	end loop
	randint (ml2, 1, 5) % randomizes what kind of power-up
    end if
    for z : 1 .. amount
	loop
	    if boss = true then % snow mound location range for boss
		randint (x2 (z), 185, 290) % randomizes x coordinates
		randint (y2 (z), 105, 380) % randomizes y coordinates
	    else % normal snow mound location range
		randint (x2 (z), 10, 460) % randomizes x coordinates
		randint (y2 (z), 105, 440) % randomizes y coordinates
	    end if
	    randint (kind2 (z), 1, 2) % randomizes what image of snow mound to use
	    if ml = 1 and x2 (z) >= mx - 50 and x2 (z) <= mx + 50 and y2 (z) >= my - 50 and y2 (z) <= my + 50 then
		goodmnd := false % cannot be close to power-up
	    elsif x2 (z) >= x - 85 and x2 (z) <= x + 50 and y2 (z) >= y - 50 and y2 (z) <= y + 75 then
		goodmnd := false % cannot be close to Matt
	    elsif x2 (z) >= x1 - 75 and x2 (z) <= x1 + 75 and y2 (z) >= y1 - 75 and y2 (z) <= y1 + 75 then
		goodmnd := false % cannot be close to paw
	    else
		goodmnd := true
		for zz : 1 .. 50
		    if x2 (z) >= xx (zz) - 15 and x2 (z) <= xx (zz) + 20 and y2 (z) >= yy (zz) - 15 and y2 (z) <= yy (zz) + 20 then
			goodmnd := false
		    else
			goodmnd := true
		    end if
		end for
	    end if
	    exit when goodmnd = true % when snow mound is far enough
	end loop
    end for
    if level >= ilvl then % is higher than ice level then ice appears
	for zz : 1 .. amount2
	    loop
		if boss = true then % snow mound location range for boss
		    randint (x3 (zz), 185, 290) % randomizes x coordinates
		    randint (y3 (zz), 105, 380) % randomizes y coordinates
		else % normal snow mound location range
		    randint (x3 (zz), 10, 460) % randomizes x coordinates
		    randint (y3 (zz), 105, 440) % randomizes y coordinates
		end if
		if ml = 1 and x3 (zz) >= mx - 75 and x3 (zz) <= mx + 75 and y3 (zz) >= my - 75 and y3 (zz) <= my + 75 then
		    goodice := false % cannot be close to power-up
		elsif x3 (zz) >= x - 85 and x3 (zz) <= x + 50 and y3 (zz) >= y - 60 and y3 (zz) <= y + 75 then
		    goodice := false % cannot be close to Matt
		elsif x3 (zz) >= x1 - 75 and x3 (zz) <= x1 + 75 and y3 (zz) >= y1 - 75 and y3 (zz) <= y1 + 75 then
		    goodice := false % cannot be close to paw
		else
		    goodice := true
		    for z : 1 .. amount
			if x3 (zz) >= x2 (z) - 10 and x3 (zz) <= x2 (z) + 70 and y3 (zz) >= y2 (z) - 10 and y3 (zz) <= y2 (z) + 110 then
			    goodice := false
			elsif x3 (zz) >= xx (z) - 15 and x3 (zz) <= xx (z) + 20 and y3 (zz) >= yy (z) - 15 and y3 (zz) <= yy (z) + 20 then
			    goodice := false
			else
			    goodice := true
			end if
		    end for
		end if
		exit when goodice = true % when ice is far enough
	    end loop
	end for
    end if
    for z : 1 .. 50
	if kindd (z) = 1 then % draws different image of snow pile
	    Pic.Draw (patch, xx (z), yy (z), picMerge)
	else
	    Pic.Draw (patchb, xx (z), yy (z), picMerge)
	end if
    end for
    for z : 1 .. amount
	if kind2 (z) = 1 then % draws different image of snow mound
	    Pic.Draw (bad, x2 (z), y2 (z), picMerge)
	else
	    Pic.Draw (badb, x2 (z), y2 (z), picMerge)
	end if
    end for
    if level >= ilvl then
	for zz : 1 .. amount2 % draws ice
	    Pic.Draw (bad2, x3 (zz), y3 (zz), picMerge)
	end for
    end if
    items
    levelS := intstr (level) % converts level to string
    Font.Draw (levelS, 230, 70, font, 0)
    healthS := intstr (health) % converts health to string
    Font.Draw (healthS, 260, 42, font, 0)
    healthchange % update health
    drawfillbox (152, 15, 352, 30, 150) % health bar
    drawfillbox (152, 15, 152 + health, 30, healthcol) % draws health bar
    Sprite.Hide (canleft)
    Sprite.Hide (canright)
    Sprite.Hide (canup)
    Sprite.SetPosition (candown, x, y, false) % puts Matt in previous position
    Sprite.ChangePic (candown, candownpics (0))
    Sprite.Show (candown) % starts level with Matt facing down
    if ml = 1 then % draws power-up if any appear
	Pic.ScreenLoad ("sprites/ml" + intstr (ml2) + ".bmp", mx, my, picMerge)
    end if
end rando

%%%%%%%%%%%%%%%%%%%%%%%% MATT MOVEMENT
procedure movement
    var printright : int := Pic.FileNew ("sprites/printright.bmp")      % loads footprints
    var printup : int := Pic.FileNew ("sprites/printup.bmp")
    var bg1 : int := Pic.FileNew ("img/bossbg1.bmp")
    var bg2 : int := Pic.FileNew ("img/bossbg2.bmp")
    loop
	Input.KeyDown (chars)
	if chars (KEY_RIGHT_ARROW) then % Matt right
	    Sprite.Hide (canleft) % hide all but current direction sprite
	    Sprite.Hide (candown)
	    Sprite.Hide (canup)
	    Sprite.Show (canright)
	    for a : x .. x
		if x mod 10 = 0 then % draws footprints
		    Pic.Draw (printright, x, y, picMerge)
		end if
		Sprite.Animate (canright, canrightpics ((x div 5) mod 4), x, y, false)
		if ml2_22 = true then % Tim Hortons cup speed
		    x := x + 15
		else % normal speed
		    x := x + 5
		end if
	    end for
	elsif chars (KEY_LEFT_ARROW) then % Matt left
	    Sprite.Hide (canright) % hide all but current direction sprite
	    Sprite.Hide (candown)
	    Sprite.Hide (canup)
	    Sprite.Show (canleft)
	    for a : x .. x
		if x mod 10 = 0 then % draws footprints
		    Pic.Draw (printright, x, y, picMerge)
		end if
		Sprite.Animate (canleft, canleftpics ((x div 5) mod 4), x, y, false)
		if ml2_22 = true then % Tim Hortons cup speed
		    x := x - 15
		else % normal speed
		    x := x - 5
		end if
	    end for
	elsif chars (KEY_UP_ARROW) then % Matt up
	    Sprite.Hide (canright) % hide all but current direction sprite
	    Sprite.Hide (candown)
	    Sprite.Hide (canleft)
	    Sprite.Show (canup)
	    for a : y .. y
		if y mod 10 = 0 then % draws footprints
		    Pic.Draw (printup, x, y, picMerge)
		end if
		Sprite.Animate (canup, canuppics ((y div 5) mod 4), x, y, false)
		if ml2_22 = true then % Tim Hortons cup speed
		    y := y + 15
		else % normal speed
		    y := y + 5
		end if
	    end for
	elsif chars (KEY_DOWN_ARROW) then % Matt down
	    Sprite.Hide (canright) % hide all but current direction sprite
	    Sprite.Hide (canleft)
	    Sprite.Hide (canup)
	    Sprite.Show (candown)
	    for a : y .. y
		if y mod 10 = 0 then % draws footprints
		    Pic.Draw (printup, x, y, picMerge)
		end if
		Sprite.Animate (candown, candownpics ((y div 5) mod 4), x, y, false)
		if ml2_22 = true then % Tim Hortons cup speed
		    y := y - 15
		else % normal speed
		    y := y - 5
		end if
	    end for
	end if
	if x <= 1 then % sets sprite position range
	    x := 0
	elsif x > 480 then
	    x := 480
	end if
	if y < 105 then
	    y := 105
	elsif y > 470 then
	    y := 470
	end if
	if chars (chr (ORD_1)) then % maple leaf is pressed
	    if ml2_1 > 0 and ml2_11 = false then % cannot be used while in use
		ml2_11 := true
		fork pwr
		fork ml2_time1
		ml2_1 := ml2_1 - 1
	    end if
	elsif chars (chr (ORD_2)) then % Tim Hortons is pressed
	    if ml2_2 > 0 and ml2_22 = false then % cannot be used while in use
		ml2_22 := true
		fork pwr
		fork ml2_time2
		ml2_2 := ml2_2 - 1
	    end if
	elsif chars (chr (ORD_3)) then % bacon is pressed
	    if ml2_3 > 0 then
		health := health + 20
		ml2_3 := ml2_3 - 1
		healthchange
		fork bite
		Pic.ScreenLoad ("img/item3.jpg", 420, 20, picCopy) % flashes item hotkey button
		Pic.ScreenLoad ("img/item3b.jpg", 420, 20, picCopy)
	    end if
	elsif chars (chr (ORD_4)) then % poutine is pressed
	    if ml2_4 > 0 then
		health := health + 50
		ml2_4 := ml2_4 - 1
		healthchange
		fork bite
		Pic.ScreenLoad ("img/item4.jpg", 441, 20, picCopy) % flashes item hotkey button
		Pic.ScreenLoad ("img/item4b.jpg", 441, 20, picCopy)
	    end if
	elsif chars (chr (ORD_5)) then % pancakes is pressed
	    if ml2_5 > 0 then
		health := health + 100
		ml2_5 := ml2_5 - 1
		healthchange
		fork bite
		Pic.ScreenLoad ("img/item5.jpg", 462, 20, picCopy) % flashes item hotkey button
		Pic.ScreenLoad ("img/item5b.jpg", 462, 20, picCopy)
	    end if
	end if
	if chars (chr (ORD_LOWER_P)) then  % pause function
	    PAUSE := true % pause is true when P is pressed
	    var PAUSEKEY : string (1)
	    healthstatus % draw pause message
	    loop
		getch (PAUSEKEY) % game resumes only when key is pressed
		if PAUSEKEY = "p" and PAUSE = true then
		    PAUSE := false
		    healthstatus % change iamge from paused to normal
		    delay (100)
		    exit
		elsif PAUSEKEY = "q" then % quit option
		    QUIT := true % allows to exit all loops
		    exit
		end if
	    end loop
	    fork cold % resume cold temperature drop
	end if
	exit when QUIT = true
	if ml2_22 = true then % if Tim Hortons power-up is used, delays are less
	    delay (50)
	else
	    delay (100)
	end if
	if ml = 1 then % if there is a power-up in the level
	    if x >= mx - 15 and x <= mx + 10 and y >= my - 15 and y <= my + 20 then % if Matt hits power-up in snow
		fork shovel % play sfx
		if ml2 = 1 then % updates inventory depending on item
		    ml2_1 := ml2_1 + 1
		elsif ml2 = 2 then
		    ml2_2 := ml2_2 + 1
		elsif ml2 = 3 then
		    ml2_3 := ml2_3 + 1
		elsif ml2 = 4 then
		    ml2_4 := ml2_4 + 1
		elsif ml2 = 5 then
		    ml2_5 := ml2_5 + 1
		end if
		Pic.ScreenLoad ("sprites/ml" + intstr (ml2) + "b.bmp", mx, my, picMerge) % changes image of item to blank
		ml := 2 % stops player from cheating and getting infinit amount of items
	    end if
	end if
	items % updates inventory
	if boss = false then % for paw print
	    if x >= x1 - 10 and x <= x1 + 10 and y >= y1 - 15 and y <= y1 + 10 then % if Matt hits the paw print
		fork wind
		exit % exit and loops to the next level
	    end if
	    if ml2_11 = false then % if maple leaf invincibility is not activated, then allow damage to be done
		for z : 1 .. (level * 2) % goes through all of the different x and y coordinates
		    if x >= x2 (z) - 5 and x <= x2 (z) + 50 and y >= y2 (z) - 5 and y <= y2 (z) + 40 then % if Matt hits any snow mounds
			health := health - 1 % takes away health
			healthchange % updates health
			if kind2 (z) = 1 then
			    Pic.Draw (bad, x2 (z), y2 (z), picMerge) % draws the snow mound again to make flashing effect
			else
			    Pic.Draw (badb, x2 (z), y2 (z), picMerge) % draws the snow mound again to make flashing effect
			end if
		    end if
		end for
		if level >= ilvl then
		    for zz : 1 .. (level * 2) % goes through all of the different x and y coordinates
			if x >= x3 (zz) - 10 and x <= x3 (zz) + 50 and y >= y3 (zz) - 5 and y <= y3 (zz) + 55 then
			    health := health - 1 % takes away health
			    healthchange % updates health
			    Pic.Draw (bad2, x3 (zz), y3 (zz), picMerge) % draws the ice again to make flashing effect
			end if
		    end for
		end if
		if level >= slvl then
		    for z : 1 .. (level * 2) % goes through all of the different x and y coordinates
			if x >= xx (z) - 5 and x <= xx (z) + 10 and y >= yy (z) - 5 and y <= yy (z) + 10 then % if Matt hits any landmin snow piles
			    if act (z) = false then % if landmine is not activated yet
				health := health - 15 % takes away health
				healthchange % updates health
				Sprite.SetPosition (ex, (xx (z) - 3), yy (z), false) % sets position of explosion sprite
				Sprite.Show (ex)
				fork bomb % bomb sfx
				for a : 1 .. 7 % show explosion animation
				    Sprite.ChangePic (ex, expics (a mod 7))
				    delay (50)
				end for
				act (z) := true % landmine is activated
				Sprite.Hide (ex)
			    end if
			end if
		    end for
		end if
	    end if
	else % for boss
	    if x >= 220 and x <= 265 and y >= 420 and y <= 450 then % Ivan or Kumajiro is approached
		epicwin := epicwin + 1 % adds point every time
		level := level + 1 % adds level
		fork wind
		exit % exit and loops to the next level
	    end if
	    if ml2_11 = false then % if maple leaf invincibility is not activated, then allow damage to be done
		if x >= 1 and x <= 185 and y >= 1 and y <= maxy then % if Matt enters left side walls
		    Pic.Draw (bg1, 1, 101, picMerge) % draws walls again
		    health := health - 1 % takes away health
		    healthchange % updates health
		elsif x >= 315 and x <= maxx and y >= 1 and y <= maxy then % if Matt enters right side walls
		    Pic.Draw (bg2, 301, 101, picMerge) % draws walls again
		    health := health - 1 % takes away health
		    healthchange % updates health
		end if
		for z : 1 .. amount % goes through all of the different x and y coordinates
		    if x >= x2 (z) - 5 and x <= x2 (z) + 50 and y >= y2 (z) - 5 and y <= y2 (z) + 40 then % if Matt hits snow mound
			health := health - 1
			healthchange
			if kind2 (z) = 1 then
			    Pic.Draw (bad, x2 (z), y2 (z), picMerge)
			else
			    Pic.Draw (badb, x2 (z), y2 (z), picMerge)
			end if
		    end if
		end for
		for zz : 1 .. amount2 % goes through all of the different x and y coordinates
		    if x >= x3 (zz) - 10 and x <= x3 (zz) + 50 and y >= y3 (zz) - 5 and y <= y3 (zz) + 55 then % if Matt hits ice
			health := health - 1
			healthchange
		    end if
		end for
		for z : 1 .. amount % goes through all of the different x and y coordinates
		    if x >= xx (z) - 5 and x <= xx (z) + 10 and y >= yy (z) - 5 and y <= yy (z) + 10 then % if Matt hits landmine snow pile
			if act (z) = false then % if landmine is not activated yet
			    health := health - 15
			    healthchange
			    Sprite.SetPosition (ex, (xx (z) - 5), yy (z), false)
			    Sprite.Show (ex)
			    fork bomb
			    for a : 1 .. 7 % show explosion animation
				Sprite.ChangePic (ex, expics (a mod 7))
				delay (50)
			    end for
			    Sprite.Hide (ex)
			    act (z) := true  % landmine is activated
			end if
		    end if
		end for
	    end if
	end if
	exit when fail = true or QUIT = true % when Matt freezes or player quits
    end loop
end movement

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% GAME BEGIN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fork historii
% Pic.ScreenLoad ("img/historii.jpg", 1, 1, picCopy) % intro title appears only once
% delay (2750) % pauses, then continues on after 2 seconds
loop
    Music.PlayFileStop % stops any music playing
    fork bossmusic
    level := 20 % reset all if player plays again
    health := 100 % health starts at 100
    boss := true % if boss battle was reached, it is as if the player has not reached the boss
    epicwin := 0 % if boss battle was reached, number of times reaching Ivan is resetted
    x := 220 % sets beginning x and y coordinates
    y := 220
    coldstop := true % health does not drop during title screen
    fail := false % if player died, fail is now false
    ml2_1 := 9 % makes all item quantities 0
    ml2_2 := 9
    ml2_3 := 9
    ml2_4 := 9
    ml2_5 := 9
    ml2_11 := false % no activated maple leaf
    ml2_22 := false % no activated Tim Hortons
    var title : int := Pic.FileNew ("img/title.jpg")
    Pic.Draw (title, 1, 1, picCopy)
    GUI.Show (buttonStart)
    GUI.ResetQuit
    loop
	exit when GUI.ProcessEvent
    end loop
    GUI.Hide (buttonStart)
    var ins : int := Pic.FileNew ("img/ins.jpg")
    Pic.Draw (ins, 1, 1, picCopy)
    Pic.Free (ins)
    Sprite.SetPosition (candown, 97, 335, false)         % set position of sprite movement example
    Sprite.SetPosition (canup, 97, 388, false)
    Sprite.SetPosition (canleft, 62, 343, false)
    Sprite.SetPosition (canright, 132, 343, false)
    Sprite.Show (candown)         % show sprite movements
    Sprite.Show (canup)
    Sprite.Show (canleft)
    Sprite.Show (canright)
    buttonRight := GUI.CreatePictureButton (378, 30, buttonRightimg, GUI.Quit)
    GUI.Show (buttonRight)
    GUI.ResetQuit
    loop         % loops sprite animation until button is pressed
	for a : 1 .. 4
	    Sprite.ChangePic (candown, candownpics (a mod 4))
	    Sprite.ChangePic (canup, canuppics (a mod 4))
	    Sprite.ChangePic (canleft, canleftpics (a mod 4))
	    Sprite.ChangePic (canright, canrightpics (a mod 4))
	    delay (200)
	    exit when GUI.ProcessEvent
	end for
	exit when GUI.ProcessEvent
    end loop
    GUI.Hide (buttonRight)         % hide everything
    Sprite.Hide (candown)
    Sprite.Hide (canup)
    Sprite.Hide (canleft)
    Sprite.Hide (canright)
    Music.PlayFileStop
    loop
    cls
    exit when boss = true
	if level = 1 then         % music changes according to level
	    fork music1
	elsif level = 5 then
	    Music.PlayFileStop
	    fork music2
	elsif level = 10 then
	    Music.PlayFileStop
	    fork music3
	elsif level = 15 then
	    Music.PlayFileStop
	    fork music4
	end if
	loop
	    cls
	    coldstop := false         % allows cold temperature
	    var paw : int := Pic.FileNew ("sprites/paw.bmp")
	    var gnum : int
	    rando         % activates map randomization
	    fork cold
	    Pic.Draw (paw, x1, y1, picMerge)
	    delay (200)
	    movement         % activates Matt movement
	    exit when fail = true or QUIT = true
	    level := level + 1         % advances level number
	    exit when level = 20         % to boss battle
	    randint (gnum, 1, 4)         % randomizes event of mini game appearing
	    if gnum = 1 then
		coldstop := true         % stop temperature drop
		Sprite.Hide (canup)         % hide sprites
		Sprite.Hide (candown)
		Sprite.Hide (canleft)
		Sprite.Hide (canright)
		var gnum2 : int
		randint (gnum2, 1, 2) % determines what kind of mini-game
		if gnum2 = 1 then
		    game1 % activate mini-game 1
		else
		    game2 % activate mini-game 2
		end if
		coldstop := false % after game, cold temperature resumes
	    end if
	    if fail = false then % if Matt isn't dead
		if level = 5 then % depending on the level, Ivan will talk about different obstacles
		    rus1
		elsif level = 10 then
		    rus2
		elsif level = 15 then
		    rus3
		end if
	    end if
	    if level = 5 or level = 10 or level = 15 then % exit to change music depending on level
		exit
	    end if
	end loop
	exit when fail = true or level = 20 or QUIT = true % when Matt dies or makes it to boss battle or player has quitted
    end loop

    % BOSS BATTLE

    coldstop := true % stop cold temperature drop

    if fail = true then
	Sprite.Hide (candown) % hide previous sprites of MAtt
	Sprite.Hide (canup)
	Sprite.Hide (canright)
	Sprite.Hide (canleft)
	healthchange
	Sprite.SetPosition (canfroz, x, y, false) % set position of freezing Matt
	Sprite.Show (canfroz)
	fork losemusic
	for a : 1 .. 3 % animation of freezing Matt
	    Sprite.ChangePic (canfroz, canfrozpics (a mod 4))
	    delay (250)
	end for
	Pic.ScreenLoad ("img/lose.jpg", 10, 110, picMerge) % lose message
	buttonRight := GUI.CreatePictureButton (378, 110, buttonRightimg, GUI.Quit)
	GUI.Show (buttonRight)
	GUI.ResetQuit
	loop
	    exit when GUI.ProcessEvent
	end loop
	GUI.Hide (buttonRight)
	Sprite.Hide (canfroz)
    elsif fail = false and QUIT = false then % if player is not dead and has not yet quitted
	fork bossmusic
	Pic.ScreenLoad ("img/rusboss1.jpg", 10, 400, picMerge) % Ivan's speech #1
	buttonRight := GUI.CreatePictureButton (400, 120, buttonRightimg, GUI.Quit)
	GUI.Show (buttonRight)
	GUI.ResetQuit
	loop
	    exit when GUI.ProcessEvent
	end loop
	GUI.Hide (buttonRight)
	Pic.ScreenLoad ("img/rusboss2.jpg", 10, 400, picMerge) % Ivan's speech #2
	GUI.Show (buttonRight)
	GUI.ResetQuit
	loop
	    exit when GUI.ProcessEvent
	end loop
	GUI.Hide (buttonRight)

	loop
	    fork wind
	    x := 245 % set Matt in new position for boss battle
	    y := 150
	    boss := true % boss battle is achieved
	    Sprite.ChangePic (rusdown, rusdownpics (0))
	    Sprite.ChangePic (canup, canuppics (0))
	    Sprite.SetPosition (rusdown, 230, 440, false) % set Ivan at top
	    Sprite.SetPosition (kuma, 250, 440, false) % set Kumajiro beside Ivan
	    Sprite.SetPosition (canup, x, y, false) % place Matt at the bottom
	    Sprite.Show (rusdown)
	    Sprite.Show (kuma)
	    Sprite.Show (canup)
	    coldstop := false % start cold temperature drop
	    cls
	    Pic.ScreenLoad ("img/bossbg.bmp", 1, 101, picMerge) % show boss map
	    rando % randomize obstacles
	    fork cold
	    fork russ
	    fork kumaa
	    movement
	    exit when epicwin = 5 or fail = true % when Ivan is reached 5 times or Matt is frozen
	    Sprite.SetPosition (rusang, 230, 440, false)
	    Sprite.Show (rusang) % show Ivan angry
	    Pic.ScreenLoad ("img/rusboss_" + intstr (epicwin) + ".jpg", 10, 270, picMerge) % Ivan talks depending on the number of reaches
	    buttonRight := GUI.CreatePictureButton (400, 120, buttonRightimg, GUI.Quit)
	    GUI.Show (buttonRight)
	    GUI.ResetQuit
	    fork russ2
	    loop
		exit when GUI.ProcessEvent
	    end loop
	    GUI.Hide (buttonRight)
	    Sprite.Hide (rusang)
	end loop
	coldstop := true
	if fail = true then
	    healthchange % make sure health shows up as 0
	    Sprite.Hide (candown) % hide all Matt sprites for freezing
	    Sprite.Hide (canup)
	    Sprite.Hide (canleft)
	    Sprite.Hide (canright)
	    Sprite.SetPosition (canfroz, x, y, false)
	    Sprite.Show (canfroz) % show freezing
	    fork losemusic
	    for a : 1 .. 3 % Matt freezing
		Sprite.ChangePic (canfroz, canfrozpics (a mod 4))
		delay (500)
	    end for
	    Sprite.Hide (canfroz)
	    Sprite.Hide (rusdown)
	    Pic.ScreenLoad ("img/losez.bmp", 1, 1, picCopy) % show extra image of Ivan and North Pole
	    Sprite.SetPosition (rusang, 230, 360, false)
	    Sprite.SetPosition (kuma, 250, 357, false)
	    Sprite.Show (rusang)
	    Sprite.Show (kuma)
	    fork kumaa % animate Kumajiro bear
	    fork russ2 % also animate Ivan at the same time
	    buttonRight := GUI.CreatePictureButton (378, 20, buttonRightimg, GUI.Quit)
	    GUI.Show (buttonRight)
	    GUI.ResetQuit
	    loop
		exit when GUI.ProcessEvent
	    end loop
	    GUI.Hide (buttonRight)
	    Sprite.Hide (rusang)
	    Sprite.Hide (kuma)
	else
	    Pic.ScreenLoad ("img/rusboss_5.jpg", 10, 270, picMerge) % Ivan is defeated image
	    fork russ2
	    x := 0 % reset x and y coordinates of Matt
	    y := 0
	    GUI.Show (buttonRight)
	    GUI.ResetQuit
	    loop
		exit when GUI.ProcessEvent
	    end loop
	    GUI.Hide (buttonRight)
	    fork winmusic
	    Sprite.Hide (rusdown)
	    Sprite.Hide (rusang)
	    Sprite.Hide (canup)
	    Sprite.Hide (candown)
	    Sprite.Hide (canleft)
	    Sprite.Hide (canright)
	    cls
	    Pic.ScreenLoad ("img/winz.bmp", 1, 1, picCopy) % show extra image of Matt and North Pole
	    Sprite.SetPosition (canwin, 230, 360, false)
	    Sprite.SetPosition (kuma, 250, 357, false)
	    Sprite.Show (canwin)
	    Sprite.Show (kuma)
	    fork kumaa % animate Kumajiro bear at the same time
	    for a : 1 .. 4 % animate Matt
		Sprite.ChangePic (canwin, canwinpics (a mod 7))
		delay (150)
	    end for
	    for a : 1 .. 6 % animate Matt turning around again
		Sprite.ChangePic (canwin, canwinpics (a mod 7))
		delay (150)
	    end for
	    Sprite.ChangePic (canwin, canwinpics (6)) % make sure Matt's sprite ends on certain position
	    buttonRight := GUI.CreatePictureButton (378, 20, buttonRightimg, GUI.Quit)
	    GUI.Show (buttonRight)
	    GUI.ResetQuit
	    loop
		exit when GUI.ProcessEvent
	    end loop
	    GUI.Hide (buttonRight)
	    Sprite.Hide (canup)
	    Sprite.Hide (candown)
	    Sprite.Hide (canright)
	    Sprite.Hide (canleft)
	    Sprite.Hide (rusdown)
	    Sprite.Hide (canwin)
	    Sprite.Hide (kuma)
	end if
    else
	PAUSE := false % if player has quitted, pause is resetted
	QUIT := false % quit is resetted
    end if
    Pic.ScreenLoad ("img/credits.jpg", 1, 1, picCopy) % show credits no matter what the ending is
    buttonRight := GUI.CreatePictureButton (370, 430, buttonRightimg, GUI.Quit)
    GUI.Show (buttonRight)
    GUI.ResetQuit
    loop
	exit when GUI.ProcessEvent
    end loop
    GUI.Hide (buttonRight)
end loop
