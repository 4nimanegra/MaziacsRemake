local BadGuy={}

function BadGuy.new(x,y,number)

	local self = {}

	self.x = x;
	self.y = y;

	self.number = number;

	self.anim = 0;
	self.dir = 0;

	self.up = {};
	self.left = {};
	self.down = {};
	self.right = {};
	self.waiting = {};

	self.up[0] = 2;
	self.up[1] = love.graphics.newImage("sprites/Enemy1.png");
	self.up[2] = love.graphics.newImage("sprites/Enemy2.png");

	self.down[0] = 2;
	self.down[1] = self.up[1];
	self.down[2] = self.up[2];

	self.left[0] = 2;
	self.left[1] = self.up[1];
	self.left[2] = self.up[2];

	self.right[0] = 2;
	self.right[1] = self.up[1];
	self.right[2] = self.up[2];

	function self.update()

		local myrand = math.random(2);

		if self.x == warrior.x and self.y == warrior.y then

			if warrior.sword < 2 then

				warrior.sword = warrior.sword + 2;

			end

			badguys[self.number]=nil;

		else

			if warrior.sword < 2 then

				if myrand == 1 then

					if self.x > warrior.x then

						if mymaze[self.x - 1][self.y] ~= 1 then

							self.x = self.x - 1;

						end

					else

						if mymaze[self.x + 1][self.y] ~= 1 then

							self.x = self.x + 1;

						end

					end

				else

					if self.y > warrior.y then

						if mymaze[self.x][self.y - 1] ~= 1 then

							self.y = self.y - 1;

						end

					else

						if mymaze[self.x][self.y + 1] ~= 1 then

							self.y = self.y + 1;

						end

					end

				end

			end

			self.anim = self.anim + 1;

		end

	end

	function self.draw(scrollx,scrolly)

		if self.x > scrollx-windowx and self.x < scrollx+windowx and self.y > scrolly - windowy and self.y < scrolly + windowy then

			if self.dir == 0 then

				love.graphics.draw(self.down[1+(self.anim%self.down[0])],(self.x-scrollx)*24,(self.y-scrolly)*24);

			elseif self.dir == 1 then

				love.graphics.draw(self.up[1+(self.anim%self.up[0])],(self.x-scrollx)*24,(self.y-scrolly)*24);

			elseif self.dir == 2 then

				love.graphics.draw(self.left[1+(self.anim%self.left[0])],(self.x-scrollx)*24,(self.y-scrolly)*24);

			else

				love.graphics.draw(self.right[1+(self.anim%self.right[0])],(self.x-scrollx)*24,(self.y-scrolly)*24);

			end

		end

	end

	return self

end

return BadGuy;
