package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class SmallPlatform extends Entity 
	{
		
		public function SmallPlatform(x_:Number, y_:Number) 
		{
			x = x_;
			y = y_;
			width = 279;
			height = 67;
			graphic = new Image(Assets.SMALLPLATFORM);
			setHitbox(width, 40, 0 , 8);
			type = "platform";
		}
		
	}

}