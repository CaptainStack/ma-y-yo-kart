package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class Gui extends Entity 
	{
		private var ammoText:Text;
		private var graphics:Graphiclist;
		private var inventoryText:Text;
		private var hpText:Text;
		private var mineText:Text;
		public function Gui() 
		{
			graphics = new Graphiclist();
			graphic = graphics;
			
			ammoText = new Text("Ammo: " + GameProperties.Ammo);
			graphics.add(ammoText);
			
			inventoryText = new Text("Metal: " + GameProperties.Metal);
			graphics.add(inventoryText);
			
			hpText = new Text("");
			graphics.add(hpText);
			
			mineText = new Text("Bear Traps: " + GameProperties.traps);
			graphics.add(mineText);
		}

		override public function update():void
		{
			ammoText.text = "Ammo: " + GameProperties.Ammo;
			ammoText.x = FP.world.camera.x;
			ammoText.y = FP.world.camera.y;
			
			inventoryText.text = "Metal: " + GameProperties.Metal;
			inventoryText.x = FP.world.camera.x + 685;
			inventoryText.y = FP.world.camera.y;
			
			hpText.text = "HP: " + GameProperties.HP;
			hpText.x = FP.world.camera.x + 350;
			hpText.y = FP.world.camera.y;
			
			mineText.text = "Bear Traps: " + GameProperties.traps;
			mineText.x = FP.world.camera.x + 150;
			mineText.y = FP.world.camera.y;
		}
	}
}