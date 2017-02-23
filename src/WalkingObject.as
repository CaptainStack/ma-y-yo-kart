package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class WalkingObject extends Entity 
	{
		private var xVelocity:Number;
		private var yVelocity:Number;
		private var isJumping:Boolean;
		private var mass:Number;
		private var maxSpeed:Number;
		protected var gravity:Boolean;
		
		public function WalkingObject(mass_:Number, maxSpeed_:Number) 
		{
			xVelocity = 0;
			yVelocity = 0;
			maxSpeed = maxSpeed_;
			mass = mass_;
		}
		
		override public function update():void
		{
			super.update();
			updatePosition();
			if (gravity)
			{
				receiveForce(0, 300);
			}
			
			detectCollisions();	
		}
		
		private function updatePosition():void
		{
			x += xVelocity * FP.elapsed;
			y += yVelocity * FP.elapsed;
		}
		
		private function detectCollisions():void
		{
			var collidedEntities:Vector.<Entity> = new Vector.<Entity>;
			collideInto("platform", x, y, collidedEntities);
			if (collidedEntities.length == 0)
			{
				isJumping = true;
			}
			
			for each (var entity:Entity in collidedEntities)
			{
				handlePlatformCollision(entity);
			}
		}

		private function handlePlatformCollision(entity:Entity):void
		{
			if ((y + height) - (yVelocity * FP.elapsed) < entity.y + 2)
			{
				if (isJumping == true && yVelocity >= 0)
				{
					yVelocity = 0;
					y = entity.y - height + 1;
					isJumping = false;
				}
				else if (isJumping == false)
				{
					yVelocity = 0;
				}
			}
		}
		
		public function receiveForce(xForce:Number, yForce:Number):void
		{
			xVelocity += xForce / mass;
			if (xVelocity > maxSpeed) 
			{
				xVelocity = maxSpeed;
			} 
			else if (xVelocity < -maxSpeed)
			{
				xVelocity = -maxSpeed;
			}
			
			if (yForce < 0) 
			{
				trace(yForce);
			}
			
			yVelocity += yForce / mass;
		}
		
		public function Stop():void
		{
			xVelocity = 0;
			yVelocity = 0;
		}

	}

}