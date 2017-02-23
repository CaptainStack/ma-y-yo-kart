package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class Shed extends Entity 
	{
		private var image:Image;
		private var healCooldown:Number;
		private var mom:Mom;
		
		public function Shed(mom_:Mom) 
		{
			mom = mom_;
			image = new Image(Assets.SHEDIMAGE);
			graphic = image;
			x = 400 - (image.width / 2);
			y = 190;
			setHitbox(image.width, image.height);
			healCooldown = 0
		}
		
		override public function update():void
		{
			if (GameProperties.MomHP > 0 && healCooldown <= 0)
			{
				if (collide("player", x, y))
				{
					GameProperties.HP += 20;
				}
				healCooldown = 20;
				mom.sayShit();
			} 
			else if (healCooldown > 0)
			{
				healCooldown -= FP.elapsed;
			}
		}
		
	}

}