package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class Item extends Entity 
	{
		[Embed(source = 'assets/metal.png')] private const METAL:Class;
		private var value:Number;
		private var onGround:Boolean;
		
		public function Item(xCoord:Number, yCoord:Number, quantity:Number)
		{
			graphic = new Image(METAL);
			setHitbox(24, 24);
			type = "item";
			value = quantity;
			x = xCoord;
			y = yCoord;
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
		public function getValue():Number
		{
			return value;
		}
		
		override public function update():void
		{		
			detectPlatform();
			//var a:Number = (x - 400);
			//var b:Number = (y - 190);
			//value = Math.sqrt(a * a + b * b) * .01;
			value = (600 - y + Math.abs(x - 400)) * .01;
		}
		
		private function detectPlatform():void
		{
			if (!onGround)
			{
				var plat:Entity = collide("platform", x, y);
				if (plat)
				{
					y = plat.y - height + 10;
					onGround = true;
				}
				else
				{
					moveBy(0, 10);
				}
			}
		}
	}
}