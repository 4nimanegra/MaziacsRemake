local Gold={}

function Gold.new(x,y,number)

	local self = {}

	self.x = x;
	self.y = y;

	self.number = number;

	self.anim = 0;
	self.dir = 0;

	self.image = {};
	self.image[0] = 1;
	self.image[1] = love.graphics.newImage("sprites/Treasure.png");

	function self.update()

		self.anim = self.anim + 1;

	end

	function self.draw(scrollx,scrolly)

		love.graphics.draw(self.image[(self.anim%self.image[0])+1],(self.x-scrollx)*24,(self.y-scrolly)*24);

	end

	return self

end

return Gold;
