local Energy={}

function Energy.new(x,y)

	local self = {}

	self.x = x;
	self.y = y;

	self.number = number;

	--self.image = {};
	--self.image[0] = 1;
	--self.image[1] = love.graphics.newImage("sprites/Sword.png");

	function self.draw()

		love.graphics.setColor(255,0,0);

		--love.graphics.draw(self.image[(self.anim%self.image[0])+1],(self.x-scrollx)*24,(self.y-scrolly)*24);
		love.graphics.rectangle("fill",self.x+math.floor((1000-warrior.energy)*(width/1000)),self.y,math.ceil(warrior.energy*(width/1000)),24);
		love.graphics.rectangle("line",self.x,self.y,width,24);
		
		love.graphics.setColor(255,255,255);

	end

	return self

end

return Energy;
