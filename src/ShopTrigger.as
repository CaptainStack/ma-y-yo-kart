package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class ShopTrigger extends Entity
	{
		
		public function ShopTrigger(x_:Number, y_:Number) 
		{
			x = x_;
			y = y_;
			setHitbox(220, 133);
			graphic = new Image(Assets.BENCHIMAGE);
			type = "shopTrigger";
		}
		
	}

}