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
	public class Crawler extends Enemy 
	{
		private var maxSpeed:Number;
		private var particleSrc:Image;	
		private var graphicsList:Graphiclist;
		
		public function Crawler(target_:Player, x_:Number, y_:Number) 
		{
			super(target_, x_, y_, 5.0, 180);
			gravity = true;
			spriteMap = new Spritemap(Assets.CRAWLERIMAGE, 203, 129);
			spriteMap.add("walk", [0, 1, 2], 10);
			spriteMap.add("attack", [0, 1, 2, ], 20);
			spriteMap.add("hit", [3], 10);
			hp = 50;
			setHitbox(193, 120);
			particles = new Emitter(new BitmapData(4, 4, true, 0xFFFF0000), 4, 4);
			particles.newType("blood", [0]);
			particles.relative = false;
			particles.setAlpha("blood");
			particles.setMotion("blood", 0 , 50, 0.3, 360, 50, 0.2, Ease.quadOut);
			graphicsList = new Graphiclist(spriteMap, particles);
			spriteMap.play("walk");
			graphic = graphicsList;
		}
		
		override public function update():void
		{
			if (!isDead)
			{
				determineDirection();
				detectBulletCollision();
				checkDeath();
				
				
				if (stunTimer > 0)
				{
					stunTimer -= FP.elapsed;
					spriteMap.active = false
					return;
				}
				
				spriteMap.active = true;
				super.update();	
				if (attackCooldown <= 0)
				{
					spriteMap.play("walk");
					detectPlayerCollision();
				} 
				else
				{
					attackCooldown -= FP.elapsed;
				}
				
			}
			if (isDead)
			{
				deathCounter += FP.elapsed;
				if (deathCounter > 0.5)
				{
					FP.world.remove(this);
				}
			}
		}
	}

}