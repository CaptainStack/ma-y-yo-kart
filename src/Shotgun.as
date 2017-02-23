package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class Shotgun extends Entity implements Gun
	{
		private var rateOfFire:Number;
		private var lastFired:Number;
		private var shotSound:Sfx;
		
		public function Shotgun() 
		{
			rateOfFire = 0.7;
			lastFired = 0;
			shotSound = new Sfx(Assets.SHOTGUNFIRE);
		}
		
		public function Fire(x:int, y:int, facing:int, vertical:int):void
		{
			if (GameProperties.Ammo > 3 && lastFired <= 0) 
			{
				lastFired = rateOfFire;
				GameProperties.Ammo -= 3;
				shotSound.play();
				FP.world.add(new Bullet(x, y, facing * 2000, (-1000 * vertical)));
				FP.world.add(new Bullet(x, y, facing * Math.sqrt(4000000 - 22500), 150 + (-1500 * vertical)));
				FP.world.add(new Bullet(x, y, facing * Math.sqrt(4000000 - 22500), -150 + (-1500 * vertical)));
			}
		}
		
		override public function update():void
		{
			if (lastFired > 0)
			{
				lastFired -= FP.elapsed;
			}
		}
	}

}