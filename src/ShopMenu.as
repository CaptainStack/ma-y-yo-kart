package  
{
	import flash.utils.Dictionary;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class ShopMenu extends World
	{
		private var shopText:Text;
		private var graphics:Graphiclist;
		private var uiEntity:Entity;
		private var shopOptions:Vector.<String>;
		private var bought:Dictionary;
		private var ammoBuySound:Sfx;
		private var drillSound:Sfx;
		private var selection:int;
		private var player:Player;
		private var pistolText:Text;
		private var kartText:Text;
		private var shotgunText:Text;
		private var machineGunText:Text;
		private var flameThrowerText:Text;
		private var ammoText:Text;
		private var bearTrapText:Text;
		private var pistolCostText:Text;
		private var kartCostText:Text;
		private var shotgunCostText:Text;
		private var machineGunCostText:Text;
		private var flameThrowerCostText:Text;
		private var ammoCostText:Text;
		private var bearTrapCostText:Text;
		private var highlight:Image;
		private var costs:Vector.<int>;
		private var bearTrapIcon:Image;
		private var shotgunIcon:Image;
		private var pistolIcon:Image;
		private var machineGunIcon:Image;
		private var ammoIcon:Image;
		private var kartIcon:Image;
		private var flamethrowerIcon:Image;
		private var ammo:Image;
		
		public function ShopMenu(player_:Player) 
		{
			costs = new <int>[10, 50, 100, 150, 200, 10, 10];
			initText();
			highlight = new Image(Assets.HIGHLIGHT);
			player = player_;
			selection = 0;
			shopOptions = new < String > ["kart", "pistol", "machineGun", "shotgun", "flameThrower", "ammo", "bearTrap"];
			ammoBuySound = new Sfx(Assets.AMMOBUYSOUND);
			drillSound = new Sfx(Assets.DRILLSOUND);
			
			bearTrapIcon = new Image(Assets.STOREBEARTRAP);
			shotgunIcon = new Image(Assets.STORESHOTGUN);
			pistolIcon = new Image(Assets.STOREPISTOL);
			machineGunIcon = new Image(Assets.STOREMACHINEGUN);
			kartIcon = new Image(Assets.STOREKART);
			flamethrowerIcon = new Image(Assets.STOREFLAMETHROWER);
			ammoIcon = new Image(Assets.STOREAMMO);
			bearTrapIcon.x = 210;
			shotgunIcon.x = 210;
			pistolIcon.x = 210;
			machineGunIcon.x = 210;
			kartIcon.x = 210;
			flamethrowerIcon.x = 210;
			ammoIcon.x = 210;
			
			bearTrapIcon.y = 400;
			shotgunIcon.y = 250;
			pistolIcon.y = 150;
			machineGunIcon.y = 200;
			kartIcon.y = 100;
			flamethrowerIcon.y = 300;
			ammoIcon.y = 350;

			bought = new Dictionary();
			bought["pistol"] = true;
			bought["shotgun"] = false;
			bought["machineGun"] = false;
			bought["flameThrower"] = false;
			
			highlight.x = 210;
			highlight.y = 100;
			graphics = new Graphiclist(pistolText, kartText, shotgunText, machineGunText, flameThrowerText, ammoText, bearTrapText,
				pistolCostText, kartCostText, shotgunCostText, machineGunCostText, flameThrowerCostText, ammoCostText, bearTrapCostText,
				bearTrapIcon, shotgunIcon, pistolIcon, machineGunIcon, kartIcon, flamethrowerIcon, ammoIcon,
				highlight);
			shopText = new Text("SHOP");
			uiEntity = new Entity(0, 0);
			uiEntity.graphic = graphics;
			add(uiEntity);
		}
		
		private function initText():void
		{
			pistolText = new Text("Kart");
			pistolCostText = new Text("" + costs[0]);
			pistolText.x = 300;
			pistolText.y = 115;
			pistolCostText.y = 115;
			pistolCostText.x = 550;
			
			kartText = new Text("Pistol");
			kartCostText = new Text("" + costs[1]);
			kartCostText.y = 165;
			kartText.x = 300;
			kartText.y = 165;
			kartCostText.x = 550;
			
			shotgunText = new Text("Machine Gun");
			shotgunCostText = new Text("" + costs[2]);
			shotgunText.x = 300;
			shotgunText.y = 215;
			shotgunCostText.y = 215;
			shotgunCostText.x = 550
			
			machineGunText = new Text("Shotgun");
			machineGunCostText = new Text("" + costs[3]);
			machineGunCostText.y = 265;
			machineGunText.x = 300;
			machineGunText.y = 265;
			machineGunCostText.x = 550;
			
			flameThrowerText = new Text("Flamethrower");
			flameThrowerCostText = new Text("" + costs[4]);
			flameThrowerText.x = 300;
			flameThrowerText.y = 315;
			flameThrowerCostText.y = 315;
			flameThrowerCostText.x = 550;
			
			ammoText = new Text("Ammo");
			ammoCostText = new Text("" + costs[5]);
			ammoText.x = 300;
			ammoText.y = 365;
			ammoCostText.y = 365;
			ammoCostText.x = 550;
			
			bearTrapText = new Text("Bear Trap");
			bearTrapCostText = new Text("" + costs[6]);
			bearTrapText.x = 300;
			bearTrapText.y = 415;
			bearTrapCostText.y = 415;
			bearTrapCostText.x = 550;
		}
		
		override public function update():void
		{
			super.update();
			trace(shopOptions[selection]);
			updateGui();
			handleKeys();
		}
		
		private function updateGui():void
		{
			switch(selection)
			{
				case 0:
					highlight.y = 100;
					break;
				case 1:
					highlight.y = 150;
					break;
				case 2:
					highlight.y = 200;
					break;
				case 3:
					highlight.y = 250;
					break;
				case 4:
					highlight.y = 300;
					break;
				case 5:
					highlight.y = 350;
					break;
				case 6:
					highlight.y = 400;
					break;
				default:
					return;
			}
		}
		
		private function handleKeys():void
		{
			if (Input.pressed(Key.Q))
			{
				GameProperties.revertGameState();
			}
			if (Input.pressed(Key.UP || Key.LEFT))
			{
				selection--;
				if (selection < 0)
				{
					selection = 6;
				}
			}
			else if (Input.pressed(Key.DOWN || Key.RIGHT))
			{
				selection++;
				if (selection > 6)
				{
					selection = 0;
				}
			}
			else if (Input.pressed(Key.ENTER))
			{
				purchase(shopOptions[selection]);
			}
		}
		
		private function purchase(item:String):void
		{
			switch(item) 
			{
				case "kart":
					drillSound.play();
					GameProperties.CarState += 10;
					GameProperties.Metal -= 10;
					break;
				case "ammo":
					ammoBuySound.play();
					GameProperties.Ammo += 100;
					GameProperties.Metal -= 10;		
					break;
				case "bearTrap":
					GameProperties.Metal -= 10;
					GameProperties.traps += 10;
					break;
				case "pistol":
					player.switchWeapon(new Pistol(), 0);
					break;
				case "machineGun":
					if (!bought[item])
					{
						if (GameProperties.Metal >= 100)
						{
							bought[item] = true;
							GameProperties.Metal -= 100;
							player.switchWeapon(new MachineGun(), 1);
						}
					}
					else 
					{
						player.switchWeapon(new MachineGun(), 1);
					}
					break;
				case "shotgun":
					if (!bought[item])
					{
						if (GameProperties.Metal >= 50)
						{
							bought[item] = true;
							GameProperties.Metal -= 50;
							player.switchWeapon(new Shotgun(), 2);
						}
					}
					else 
					{
						player.switchWeapon(new Shotgun(), 2);
					}
					break;
				case "flameThrower":
					if (!bought[item])
					{
						if (GameProperties.Metal >= 200)
						{
							bought[item] = true;
							GameProperties.Metal -= 200;
							player.switchWeapon(new Flamethrower(), 3);
						}
					}
					else 
					{
						player.switchWeapon(new Flamethrower(), 3);
					}
					break;
				default:
					break;
			}
		}
		
	}

}
