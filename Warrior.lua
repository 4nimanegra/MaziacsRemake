local Warrior={}

function Warrior.new(x,y)

	local self = {}

	self.x = x;
	self.y = y;

	self.sword = 1;
	self.fighting = 0;

	self.energy = 1000;

	self.anim = 0;
	self.dir = 0;

	self.up = {};
	self.left = {};
	self.down = {};
	self.right = {};
	self.waiting = {};

	self.up[0] = {};
	self.left[0] = {};
	self.down[0] = {};
	self.right[0] = {};
	self.waiting[0] = {};

	self.up[1] = {};
	self.left[1] = {};
	self.down[1] = {};
	self.right[1] = {};
	self.waiting[1] = {};

	self.up[2] = {};
	self.left[2] = {};
	self.down[2] = {};
	self.right[2] = {};
	self.waiting[2] = {};

	self.up[3] = {};
	self.left[3] = {};
	self.down[3] = {};
	self.right[3] = {};
	self.waiting[3] = {};

	self.up[4] = {};

	self.up[5] = {};

	self.up[6] = {};

	self.up[6][0] = 1;
	self.up[6][1] = love.graphics.newImage("sprites/Rip.png");
	
	self.up[5][0] = 2;
	self.up[5][1] = love.graphics.newImage("sprites/FightLost1.png");
	self.up[5][2] = love.graphics.newImage("sprites/FightLost2.png");

	self.up[4][0] = 2;
	self.up[4][1] = love.graphics.newImage("sprites/PlayerWon1.png");
	self.up[4][2] = love.graphics.newImage("sprites/PlayerWon2.png");

	self.up[3][0] = 4;
	self.up[3][1] = love.graphics.newImage("sprites/FightSword1.png");
	self.up[3][2] = love.graphics.newImage("sprites/Fight1.png");
	self.up[3][3] = love.graphics.newImage("sprites/Fight2.png");
	self.up[3][4] = love.graphics.newImage("sprites/Fight3.png");

	self.up[2][0] = 4;
	self.up[2][1] = love.graphics.newImage("sprites/FightNoSword1.png");
	self.up[2][2] = love.graphics.newImage("sprites/Fight1.png");
	self.up[2][3] = love.graphics.newImage("sprites/Fight2.png");
	self.up[2][4] = love.graphics.newImage("sprites/Fight3.png");

	self.up[1][0] = 2;
	self.up[1][1] = love.graphics.newImage("sprites/PlayerWalkUpSword1.png");
	self.up[1][2] = love.graphics.newImage("sprites/PlayerWalkUpSword2.png");

	self.down[1][0] = 2;
	self.down[1][1] = love.graphics.newImage("sprites/PlayerWalkDownSword1.png");
	self.down[1][2] = love.graphics.newImage("sprites/PlayerWalkDownSword2.png");

	self.left[1][0] = 2;
	self.left[1][1] = love.graphics.newImage("sprites/PlyerRunLeftSword1.png");
	self.left[1][2] = love.graphics.newImage("sprites/PlyerRunLeftSword2.png");

	self.right[1][0] = 2;
	self.right[1][1] = love.graphics.newImage("sprites/PlayerRunRightSword1.png");
	self.right[1][2] = love.graphics.newImage("sprites/PlayerRunRightSword2.png");

	self.up[0][0] = 2;
	self.up[0][1] = love.graphics.newImage("sprites/PlayerWalkUp1.png");
	self.up[0][2] = love.graphics.newImage("sprites/PlayerWalkUp2.png");

	self.down[0][0] = 2;
	self.down[0][1] = love.graphics.newImage("sprites/PlayerWalkDown1.png");
	self.down[0][2] = love.graphics.newImage("sprites/PlayerWalkDown2.png");

	self.left[0][0] = 2;
	self.left[0][1] = love.graphics.newImage("sprites/PlayerRunLeft1.png");
	self.left[0][2] = love.graphics.newImage("sprites/PlayerRunLeft2.png");

	self.right[0][0] = 2;
	self.right[0][1] = love.graphics.newImage("sprites/PlayerRunRight1.png");
	self.right[0][2] = love.graphics.newImage("sprites/PlayerRunRight2.png");

--	function self.update()

--		if self.sword > 1 then

--		end

--	end


	function self.update(key)

		local i,nextx,nexty;

		nextx = self.x;
		nexty = self.y;

		self.energy = self.energy - 1;

		if self.sword > 1 then

			if key ~= nil then

				return;

			end

			self.fighting = self.fighting + 1;

			self.anim = self.anim + 1;

			if self.fighting > 10 then

				if self.sword < 4 then

					if self.sword == 3 or math.random() > 0.9 then

						self.sword = 4;

						if self.fighting > 14 then

							self.sword = 0;
							self.fighting = 0;

						end

					else

						self.sword = 5;

					end

				else

					if self.fighting > 14 then

						if self.sword == 4 then

							self.sword = 0;
							self.fighting = 0;

						else

							self.sword = 6;
							self.fighting = 0;

						end

					end

	

				end

			end

			return;


		end

		if key == nil then

			return;

		end

		if key == "down" then

			self.dir = 0;

			nexty = nexty + 1;
			
			if mymaze[self.x][self.y + 1] ~= 1 then

				self.y = self.y + 1;

			end

		end

		if key == "up" then

			self.dir = 1;

			nexty=nexty - 1;

			if mymaze[self.x][self.y - 1] ~= 1 then

				self.y = self.y - 1;

			end

		end

		if key == "left" then

			self.dir = 2;

			nextx = nextx - 1;

			if mymaze[self.x - 1][self.y] ~= 1 then

				self.x = self.x - 1;

			end

		end

		if key == "right" then

			self.dir = 3;

			nextx = nextx + 1;

			if mymaze[self.x + 1][self.y] ~= 1 then

				self.x = self.x + 1;

			end

		end

		self.anim = self.anim + 1;

		i=0;

		while i < totalbadguys do

			if badguys[i] ~= nil then

				if badguys[i].x == self.x and badguys[i].y == self.y then

					self.sword = self.sword + 2;

					badguys[i]=nil;

					break;

				end

			end

			i=i+1;

		end;

		i=0;

		while i < totalcakes do

			if cakes[i] ~= nil then

				if cakes[i].x == nextx and cakes[i].y == nexty then

					self.energy = self.energy + 200;

					if self.energy > 1000 then

						self.energy = 1000;

					end

					cakes[i]=nil;

					break;

				end

			end

			i=i+1;

		end;

		i=0;

		if self.sword == 0 then

			while i < totalswords do

				if swords[i] ~= nil then

					if swords[i].x == nextx and swords[i].y == nexty then

						self.sword = 1;

						swords[i]=nil;

						break;

					end

				end

				i=i+1;

			end;

		end;


	end

	function self.draw(scrollx,scrolly)

		if self.sword > 1 then

			love.graphics.draw(self.up[self.sword][1+(self.anim%self.up[self.sword][0])],(self.x-scrollx)*24,(self.y-scrolly)*24);

		else

			if self.dir == 0 then

				love.graphics.draw(self.down[self.sword][1+(self.anim%self.down[self.sword][0])],(self.x-scrollx)*24,(self.y-scrolly)*24);

			elseif self.dir == 1 then

				love.graphics.draw(self.up[self.sword][1+(self.anim%self.up[self.sword][0])],(self.x-scrollx)*24,(self.y-scrolly)*24);

			elseif self.dir == 2 then

				love.graphics.draw(self.left[self.sword][1+(self.anim%self.left[self.sword][0])],(self.x-scrollx)*24,(self.y-scrolly)*24);

			else

				love.graphics.draw(self.right[self.sword][1+(self.anim%self.right[self.sword][0])],(self.x-scrollx)*24,(self.y-scrolly)*24);

			end

		end

	end

	return self

end

return Warrior
