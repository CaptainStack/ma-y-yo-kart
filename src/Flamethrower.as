package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class Flamethrower extends Entity implements Gun
	{
		private var rateOfFire:Number;
		private var lastFired:Number;
		private var fireSound:Sfx;
		
		public function Flamethrower() 
		{
			fireSound = new Sfx(Assets.FLAMETHROWERSOUND);
			rateOfFire = 0.12;
			lastFired = 0;	
		}
		
		public function Fire(x:int, y:int, facing:int, vertical:int):void
		{
			if (lastFired <= 0 && GameProperties.Ammo > 3)
			{
				if (!fireSound.playing) 
				{
					fireSound.play();
				}
				var yVel:Number = Math.random();
				yVel *= -20
				yVel -= (vertical * 100);
				
				FP.world.add(new Flame(x, y, facing * Math.sqrt(80000 - (yVel * yVel)), yVel));
				lastFired = rateOfFire;
				GameProperties.Ammo -= 3;
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