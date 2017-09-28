local Warrior = require "Warrior"
local BadGuy = require "BadGuy"
local Sword = require "Sword"
local Energy = require "Energy"
local Cake = require "Cake"
local Gold = require "Gold"
local Prisoner = require "Prisoner"

-- The size of the screen
width = 160;
height = 144;

scrollx = 0;
scrolly = 0;

-- Ok the different values means changes on the screen to view, title window, menu window, maze window, win and loose window.
screen = 1;

-- maze sizes
mazewidth = 149;
mazeheight = 120;

mazewall = mazewidth*mazeheight/3;

windowx = 7;
windowy = 5;

warrior = {};

badguys = {};

swords = {};

energy = {};

cakes = {};

gold = {};

prisoners = {};

totalbadguys = 100;
totalswords = 100;
totalprisoners = 100;
totalcakes = 300;
totalframes=20;
frame=0;

-- Each screen needs to load stuff. This will load the Maze screen and set stuff.
function love.loadMaze()

	local i,ii,walls,total;

	wallimage = love.graphics.newImage("sprites/Wall.png");
	pathimage = love.graphics.newImage("sprites/Path.png");

	scrollx = math.floor((mazewidth-2)/2)+1;
	scrolly = math.floor((mazeheight-2)/2)+1;

	warrior = Warrior.new(scrollx,scrolly);

	scrollx=scrollx-3;
	scrolly=scrolly-2;

	math.randomseed(os.time());

	i=0;

	mymaze={};
	
	while i < mazewidth do

		mymaze[i] = {};

		ii = 0;

		while ii < mazeheight do

			if i == 0 then

				mymaze[i][ii] = 1;

			elseif i == mazewidth-1 then

				mymaze[i][ii] = 1;

			elseif ii == 0 then

				mymaze[i][ii] = 1;

			elseif ii == mazeheight-1 then

				mymaze[i][ii] = 1;

			else

				mymaze[i][ii] = 0;

			end

			ii = ii+1;

		end

		i = i+1;

	end

	walls = 0;

	while walls < mazewall do

		i = math.random(mazewidth);
		ii = math.random(mazeheight);

		i = i-1;
		ii = ii-1;

		while mymaze[i][ii] ~= 0 do


			i = math.random(mazewidth);
			ii = math.random(mazeheight);

			i = i-1;
			ii = ii-1;

		end

		walls = walls + 1;

	end

	i=2;

	while i < mazewidth do

		ii = 2;

		while ii < mazeheight do

			walls = -1;

			while walls ~= 0 do

				walls=math.random(3);

				if walls == 1 then

					mymaze[i-1][ii-1] = 1;
					mymaze[i][ii-1] = 0;
					mymaze[i+1][ii-1] = 1;
					mymaze[i-1][ii] = 0;
					mymaze[i][ii] = 0;
					mymaze[i+1][ii] = 0;
					mymaze[i-1][ii+1] = 1;
					mymaze[i][ii+1] = 0;
					mymaze[i+1][ii+1] = 1;

					walls = 0;

				elseif walls == 2 then

					if mymaze[i][ii-2] == 0  then

						mymaze[i-1][ii-1] = 1;
						mymaze[i][ii-1] = 0;
						mymaze[i+1][ii-1] = 1;
						mymaze[i-1][ii] = 1;
						mymaze[i][ii] = 0;
						mymaze[i+1][ii] = 1;
						mymaze[i-1][ii+1] = 1;
						mymaze[i][ii+1] = 0;
						mymaze[i+1][ii+1] = 1;

						walls = 0;

					end

				else

					if mymaze[i-2][ii] == 0  then

						mymaze[i-1][ii-1] = 1;
						mymaze[i][ii-1] = 1;
						mymaze[i+1][ii-1] = 1;
						mymaze[i-1][ii] = 0;
						mymaze[i][ii] = 0;
						mymaze[i+1][ii] = 0;
						mymaze[i-1][ii+1] = 1;
						mymaze[i][ii+1] = 1;
						mymaze[i+1][ii+1] = 1;

						walls = 0;

					end

				end

			end

			ii = ii+3;

		end

		i = i+3;

	end

	i=math.floor(((mazewidth-2)/2))+1;
	ii=math.floor(((mazeheight-2)/2))+1;

	mymaze[i-1][ii-1] = 0;
	mymaze[i][ii-1] = 0;
	mymaze[i+1][ii-1] = 0;
	mymaze[i-1][ii] = 0;
	mymaze[i][ii] = 0;
	mymaze[i+1][ii] = 0;
	mymaze[i-1][ii+1] = 0;
	mymaze[i][ii+1] = 0;
	mymaze[i+1][ii+1] = 0;

	total = 0;

	while total < totalbadguys do

		i=1;
		ii=1;

		while mymaze[i][ii] ~= 0 do

			i=math.random(mazewidth-1);
			ii=math.random(mazeheight-1);

		end

		badguys[total]=BadGuy.new(i,ii,total);

		total = total + 1;

	end

	total = 0;

	while total < totalswords do

		i=math.random(mazewidth-4)+1;
		ii=math.random(mazeheight-4)+1;

		while ((mymaze[i][ii] ~= 1) or ((mymaze[i-1][ii] ~= 0) and 
			(mymaze[i+1][ii] ~= 0) and (mymaze[i][ii+1] ~= 0) and (mymaze[i][ii-1] ~= 0))) do

			i=math.random(mazewidth-4)+1;
			ii=math.random(mazeheight-4)+1;

		end

		swords[total]=Sword.new(i,ii,total);

		total = total + 1;

	end

	total = 0;

	while total < totalcakes do

		i=math.random(mazewidth-4)+1;
		ii=math.random(mazeheight-4)+1;

		while ((mymaze[i][ii] ~= 1) or ((mymaze[i-1][ii] ~= 0) and 
			(mymaze[i+1][ii] ~= 0) and (mymaze[i][ii+1] ~= 0) and (mymaze[i][ii-1] ~= 0))) do

			i=math.random(mazewidth-4)+1;
			ii=math.random(mazeheight-4)+1;

		end

		cakes[total]=Cake.new(i,ii,total);

		total = total + 1;

	end

	total = 0;

	while total < totalprisoners do

		i=math.random(mazewidth-4)+1;
		ii=math.random(mazeheight-4)+1;

		while ((mymaze[i][ii] ~= 1) or ((mymaze[i-1][ii] ~= 0) and 
			(mymaze[i+1][ii] ~= 0) and (mymaze[i][ii+1] ~= 0) and (mymaze[i][ii-1] ~= 0))) do

			i=math.random(mazewidth-4)+1;
			ii=math.random(mazeheight-4)+1;

		end

		prisoners[total]=Prisoner.new(i,ii,total);

		total = total + 1;

	end

	i=math.random(mazewidth-4)+1;
	ii=math.random(mazeheight-4)+1;

	while ((mymaze[i][ii] ~= 1) or ((mymaze[i-1][ii] ~= 0) and 
		(mymaze[i+1][ii] ~= 0) and (mymaze[i][ii+1] ~= 0) and (mymaze[i][ii-1] ~= 0))) or 
		math.abs(i-math.floor((mazewidth-2)/2)+1)+math.abs(ii-math.floor((mazeheight-2)/2)+1) < 50 do

		i=math.random(mazewidth-4)+1;
		ii=math.random(mazeheight-4)+1;

	end

	gold = Gold.new(i,ii);

end

function love.load()

	--love.window.setMode(width,height);
	love.window.setFullscreen(true);

	if screen == 1 then

		love.loadMaze();

		energy = Energy.new(0,24*5);

	end

end

function love.keypressed(key)

	-- Exit test
	if key == "escape" then
		os.exit();

	end

--	if key == "left" then

--		scrollx = scrollx - 1;

--		if scrollx < 0 then

--			scrollx=0; 

--		end

--	end

--	if key == "right" then

--		scrollx = scrollx + 1;

--		if scrollx > mazewidth - 11 then

--			scrollx = mazewidth - 11;

--		end

--	end

--	if key == "up" then

--		scrolly = scrolly - 1;

--		if scrolly < 0 then

--			scrolly = 0;

--		end

--	end

--	if key == "down" then

--		scrolly = scrolly + 1;

--		if scrolly > mazeheight - 8 then

--			scrolly = mazeheight - 8;

--		end

--	end

	warrior.update(key);

	scrolly = warrior.y-2;
	scrollx = warrior.x-3;

	if scrolly < 0 then

		scrolly = 0;

	end

	if scrolly > mazeheight - windowy then

		scrolly = mazeheight - windowy;

	end

	if scrollx < 0 then

		scrollx = 0;

	end

	if scrollx > mazewidth - windowx then

		scrollx = mazewidth - windowx;

	end

end

function love.update(dt)

	local total;


	if frame%totalframes == 0 then

		total = 0;

		warrior.update();

		while total < totalbadguys do

			if badguys[total] ~= nil then

				badguys[total].update();

			end

			total = total + 1;

		end

		total = 0;

		while total < totalprisoners do

			if prisoners[total] ~= nil then

				prisoners[total].update();

			end

			total = total + 1;

		end


	end

	frame=frame+1;

end

function love.drawMaze()

	local initi,initii,i,ii;

	initi=scrollx;
	i=initi;

	while i < initi+windowx do

		ii=scrolly;
		initii=ii;

		while ii < initii+windowy do

			if mymaze[i][ii] == 0 then

--				love.graphics.setColor(0,0,0);
				love.graphics.draw(pathimage,(i-initi)*24,(ii-initii)*24);

			elseif mymaze[i][ii] == 1  then

--				love.graphics.setColor(255,255,255);
				love.graphics.draw(wallimage,(i-initi)*24,(ii-initii)*24);


			end

--			love.graphics.rectangle("fill",(i-initi)*24,(ii-initii)*24,24,24);

			ii = ii+1;

		end

		i = i+1;

	end


end

function love.draw()

	local total;

	love.graphics.scale(love.graphics.getWidth()/width,love.graphics.getHeight()/height,2);

	if screen == 1 then

		love.drawMaze();

		total = 0;

		while total < totalswords do

			if swords[total] ~= nil then

				swords[total].draw(scrollx,scrolly);

			end

			total = total + 1;

		end

		total = 0;

		while total < totalcakes do

			if cakes[total] ~= nil then

				cakes[total].draw(scrollx,scrolly);

			end

			total = total + 1;

		end

		total = 0;

		while total < totalprisoners do

			if prisoners[total] ~= nil then

				prisoners[total].draw(scrollx,scrolly);

			end

			total = total + 1;

		end

		total = 0;

		while total < totalbadguys do

			if badguys[total] ~= nil then

				badguys[total].draw(scrollx,scrolly);

			end

			total = total + 1;

		end

		gold.draw(scrollx,scrolly);

		warrior.draw(scrollx,scrolly);
	
		energy.draw();
	
	end


end
