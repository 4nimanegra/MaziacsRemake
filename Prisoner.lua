local Prisoner={}

function Prisoner.new(x,y,number)

	local self = {}

	self.x = x;
	self.y = y;

	self.number = number;

	self.anim = 0;
	self.dir = 0;

	self.image = {};
	self.image[0] = 2;
	self.image[1] = love.graphics.newImage("sprites/Prisoner1.png");
	self.image[2] = love.graphics.newImage("sprites/Prisoner2.png");


	function self.update()

		self.anim = self.anim + 1;

	end

	function self.draw(scrollx,scrolly)

		love.graphics.draw(self.image[(self.anim%self.image[0])+1],(self.x-scrollx)*24,(self.y-scrolly)*24);

	end

	return self

end

return Prisoner;
