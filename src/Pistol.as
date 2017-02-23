package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class Pistol extends Entity implements Gun
	{
		private var rateOfFire:Number;
		private var lastFired:Number;
		private var pistolSound:Sfx;
		
		public function Pistol(rateOfFire_:Number = 0.5) 
		{
			rateOfFire = rateOfFire_;
			lastFired = 0;
			pistolSound = new Sfx(Assets.PISTOLFIRE);
		}
		
		public function Fire(x:int, y:int, facing:int, vertical:int):void
		{
			if (GameProperties.Ammo > 0 && lastFired <= 0) 
			{
				lastFired = rateOfFire;
				GameProperties.Ammo--;
				pistolSound.play();
				FP.world.add(new Bullet(x, y, facing * 2000, -1500 * vertical));
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