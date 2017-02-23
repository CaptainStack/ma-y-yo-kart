package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class Bullet extends Projectile
	{
		
		public function Bullet(x_:Number, y_:Number, xVelocity_:Number, yVelocity_:Number) 
		{
			damage = 5;
			graphic = Image.createRect(10, 4, 0xFFD700);
			super(x_, y_, xVelocity_, yVelocity_); 
			setHitbox(10, 4);
		}
		
		override public function update():void
		{
			if (collide("enemy", x, y))
			{
				destroy();
			}
			
			if (collide("platform", x, y))
			{
				destroy();
			}
			
			super.update();
		}
		
		override public function GetDamage():Number
		{
			return 5;
		}
		
	}

}