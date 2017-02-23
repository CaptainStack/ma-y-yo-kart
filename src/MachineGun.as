package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class MachineGun extends Entity implements Gun 
	{	
		private var rateOfFire:Number;
		private var lastFired:Number;
		private var pistolSound:Sfx;
		
		public function MachineGun() 
		{
			rateOfFire = 0.1;
			lastFired = 0;
			pistolSound = new Sfx(Assets.PISTOLFIRE);
		}
		
		public function Fire(x:int, y:int, facing:int, vertical:int):void
		{
			if (GameProperties.Ammo > 0 && lastFired <= 0) 
			{
				lastFired = rateOfFire;
				GameProperties.Ammo--;
				var randVal:Number = Math.random();
				pistolSound.play();
				if (randVal < 0.3)
				{
					FP.world.add(new Bullet(x, y, facing * Math.sqrt(4000000 - 6400), 80 + (vertical * -1500)));
				}
				else if (randVal >= 0.3 && randVal < 0.7) 
				{	
					FP.world.add(new Bullet(x, y, facing * 2000, (vertical * -1000)));	
				}
				else 
				{
					FP.world.add(new Bullet(x, y, facing * Math.sqrt(4000000 - 6400), -80 + (vertical * -1500)));
				}
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