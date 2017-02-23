package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class BearTrap extends Entity
	{
		private var onGround:Boolean;
		private var openTrap:Image;
		private var closedTrap:Image;
		private var deathTimer:Number;
		private var activated:Boolean;
		
		public function BearTrap(x_:Number, y_:Number) 
		{
			activated = false;
			deathTimer = 0;
			setHitbox(64, 18);
			type = "BearTrap";
			openTrap = new Image(Assets.OPENBEARTRAP);
			closedTrap = new Image(Assets.CLOSEDBEARTRAP);
			
			graphic = openTrap
			x = x_;
			y = y_;
			onGround = false;
		}
		
		override public function update():void
		{		
			detectCollision();
			if (activated)
			{
				deathTimer += FP.elapsed;
			}
			if (deathTimer > 4)
			{
				FP.world.remove(this);
			}
		}
		
		private function detectCollision():void
		{
			var collidedEntity:Entity = collide("enemy", x, y);
			if (collidedEntity)
			{
				var enemy:Enemy = Enemy(collidedEntity);
				enemy.receiveStun(4);
				activated = true;
				collidable = false;
				graphic = closedTrap;
				y -= 5;
			}
			
			if (!onGround)
			{
				var plat:Entity = collide("platform", x, y);
				if (plat)
				{
					y = plat.y - height + 5;
					onGround = true;
				}
				else
				{
					moveBy(0, 10);
				}
			}
		}
		
	}

}