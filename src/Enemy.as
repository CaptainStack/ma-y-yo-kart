package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Particle;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class Enemy extends WalkingObject 
	{
		private var maxSpeed:Number;
		protected var target:Player;
		protected var hp:Number;
		protected var spriteMap:Spritemap;
		protected var attackCooldown:Number;
		protected var stunTimer:Number;
		private var particleSrc:Image;	
		protected var particles:Emitter;
		private var graphicsList:Graphiclist;
		protected var isDead:Boolean;
		protected var deathCounter:Number;
		
		public function Enemy(target_:Player, x_:Number, y_:Number, mass_:Number, maxSpeed_:Number) 
		{
			deathCounter = 0;
			super(mass_, maxSpeed_);
			target = target_;
			x = x_;
			y = y_;
			type = "enemy";
			attackCooldown = 0;
			isDead = false;
			stunTimer = 0;
		}
		
		override public function update():void
		{
			super.update();
		}
		
		protected function checkDeath():void
		{
			if (hp <= 0)
			{
				destroy();
			}
		}
		
		protected function detectPlayerCollision():void
		{
			if (collide("player", x, y))
			{
				trace("Hit player!");
				if (x > target.x + target.width / 2)
				{
					trace("Hit player right");
					target.xVelocity = -4000;
					target.x = x - target.width - 2;
				}
				else if (x + width < target.x + target.width / 2)
				{
					trace("hit player left");
					target.xVelocity = 4000;
					target.x = x + width + 2;
				}
				attackCooldown = 1;
				GameProperties.HP -= 10;
				spriteMap.play("attack");
				target.tintRed();
			}
		}
		
		protected function detectBulletCollision():void
		{
			var hitBullets:Vector.<Entity> = new Vector.<Entity>;
			collideInto("projectile", x, y, hitBullets);
			for each (var bullet:Projectile in hitBullets)
			{	
				hp -= bullet.GetDamage();
			}
		}
		
		protected function determineDirection():void
		{
			if (target.x + (target.width / 2) - x > 0)
			{
				receiveForce(100, 0);
				spriteMap.flipped = true;
			}
			else if (target.x + (target.width / 2) - x < 0)
			{
				receiveForce( -100, 0);
				spriteMap.flipped = false;
			}
		}
		
		public function receiveStun(time:Number):void
		{
			stunTimer = time;
		}
		
		protected function destroy():void
		{
			Stop();
			collidable = false;
			spriteMap.visible = false;
			isDead = true;
			for (var i:int = 0; i < 100; i++)
			{
				particles.emit("blood", x + Math.random() * width, y + Math.random() * height);
			}
		}
	}

}