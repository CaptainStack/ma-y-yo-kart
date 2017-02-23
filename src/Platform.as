package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	
	public class Platform extends Entity
	{	
		private var tiles:Tilemap;

		public function Platform(width_:Number, height_:Number, x_:Number, y_:Number) 
		{		
			x = x_;
			y = y_;
			width = width_;
			height = height_;
			tiles = new Tilemap(Assets.FLOORIMAGE, width, height, 100, 90);
			tiles.setRect(0, 0, 3200 / 100, 600 / 90, 0);
			graphic = tiles
			tiles.y -= 6;
			setHitbox(width, height);
			type = "platform";
		}	
	}

}