package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class Projectile extends Entity 
	{
		[Embed(source = 'assets/bullet.png')] private const BULLETIMAGE:Class;
		
		protected var xVelocity:Number;
		protected var yVelocity:Number;
		private var startX:Number;
		private var startY:Number;
		public var damage:Number;
		
		public function Projectile(x_:Number, y_:Number, xVelocity_:Number, yVelocity_:Number) 
		{
			startX = x_;
			startY = y_;
			x = x_;
			y = y_;
			xVelocity = xVelocity_;
			yVelocity = yVelocity_;
			type = "projectile";
		}
	
		override public function update():void
		{	
			x += xVelocity * FP.elapsed;
			y += yVelocity * FP.elapsed;
			
			if (Math.abs(startX - x) > 800) 
			{
				destroy();
			}
			
			if (Math.abs(startY- y) > 800) 
			{
				destroy();
			}
		}
		
		public function GetDamage():Number
		{
			return 0;
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
	}

}