package  
{
	import net.flashpunk.graphics.Image
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class Flame extends Projectile 
	{
		private var timeAlive:Number;
		private var lifeSpan:Number;
		
		public function Flame(x_:Number, y_:Number, xVelocity_:Number, yVelocity_:Number) 
		{
			timeAlive = 0;
			lifeSpan = 1.5;
			damage = 10;
			graphic = Image.createRect(20, 20, 0xFF5721);
			super(x_, y_, xVelocity_, yVelocity_);
			setHitbox(20, 20);
		}
		
		override public function update():void
		{
			timeAlive += FP.elapsed;
			
			if (timeAlive > lifeSpan)
			{
				destroy();
			}
			yVelocity -= 0.5;
			xVelocity -= 0.5;
			super.update();
		}
		
		override public function GetDamage():Number
		{
			return 10;
		}
	}

}