package entities.menu
{
   import entities.Container;
   import entities.DelayTooltip;
   import entities.TowerEntity;
   import entities.buttons.*;
   import entities.towers.buzzsaw.BuzzsawTower;
   import entities.towers.sam.SamTower;
   import flash.geom.Rectangle;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Text;
   import spill.localisation.SpilGame;
   
   public class TowerMenu extends Container
   {
      
      public var target:TowerEntity;
      
      private var name:Text = null;
      
      private var damage:Text = null;
      
      private var damage2:Text = null;
      
      private var damage_up:Text = null;
      
      private var damage_up2:Text = null;
      
      private var range:Text = null;
      
      private var range_up:Text = null;
      
      private var speed:Text = null;
      
      private var speed_up:Text = null;
      
      private var upgradeButton:GenericButton;
      
      private var sellButton:GenericButton;
      
      private var _damage:Image = new Image(Assets.GFX_UPGRADE_ICONS,new Rectangle(0,0,30,26));
      
      private var _range:Image = new Image(Assets.GFX_UPGRADE_ICONS,new Rectangle(30,0,30,26));
      
      private var _speed:Image = new Image(Assets.GFX_UPGRADE_ICONS,new Rectangle(60,0,30,26));
      
      private var _damage_arrow:Image = new Image(Assets.GFX_UPGRADE_ICONS,new Rectangle(90,0,30,26));
      
      private var _range_arrow:Image = new Image(Assets.GFX_UPGRADE_ICONS,new Rectangle(90,0,30,26));
      
      private var _speed_arrow:Image = new Image(Assets.GFX_UPGRADE_ICONS,new Rectangle(90,0,30,26));
      
      private var enabled:Boolean = true;
      
      private var damage_tt:DelayTooltip;
      
      private var range_tt:DelayTooltip;
      
      private var speed_tt:DelayTooltip;
      
      private var target_first:TargetFirstButton;
      
      private var target_last:TargetLastButton;
      
      private var target_weak:TargetWeakButton;
      
      private var target_strong:TargetStrongButton;
      
      public function TowerMenu(target:TowerEntity)
      {
         super();
         this.target = target;
         this.setHitbox(155,215);
         this.target.showRangeCircle();
      }
      
      private function setupFields() : void
      {
         this.x = this.target.x + 30;
         this.y = this.target.y - 245 / 2 + 15;
         if(this.x > 480 - 160)
         {
            this.x = 480 - 160;
         }
         if(this.y > 480 - 220)
         {
            this.y = 480 - 220;
         }
         if(this.y < 0)
         {
            this.y = 0;
         }
         switch(SpilGame.currentLanguage.name)
         {
            case "pt":
            case "br":
            case "de":
            case "fr":
            case "ru":
            case "es":
            case "es_ar":
            case "es_mx":
            case "id":
            case "it":
            case "nl":
            case "pl":
            case "se":
               Text.size = 20 / Const.FONT_OFFSET;
               break;
            default:
               Text.size = 24 / Const.FONT_OFFSET;
         }
         Text.font = Const.FONT;
         this.name = new Text("",0,0,220,24);
         this.name.color = 0;
         Text.size = 20 / Const.FONT_OFFSET;
         Text.font = Const.FONT_TEXT;
         this.damage = new Text("",0,0,220,20);
         this.damage.color = 0;
         this.damage_up = new Text("",0,0,220,20);
         this.damage_up.color = 153;
         this.range = new Text("",0,0,220,20);
         this.range.color = 0;
         this.range_up = new Text("",0,0,220,20);
         this.range_up.color = 153;
         this.speed = new Text("",0,0,220,20);
         this.speed.color = 0;
         this.speed_up = new Text("",0,0,220,20);
         this.speed_up.color = 153;
         Text.size = 12 / Const.FONT_OFFSET;
         this.damage_up2 = new Text("",0,0,220,12);
         this.damage_up2.color = 153;
         this.damage2 = new Text("",0,0,220,12);
         this.damage2.color = 0;
         this.damage_tt = new DelayTooltip("",12,33,26,26,1);
         this.range_tt = new DelayTooltip("",12,63,26,26,1);
         this.speed_tt = new DelayTooltip("",12,93,26,26,1);
      }
      
      private function setDamageText(field1:Text, field2:Text, damage:Number, text:String) : void
      {
         if(text && text.indexOf("x") != -1 && text != "Max")
         {
            field1.text = text.substring(text.indexOf("x") + 1);
            field2.text = text.substring(0,text.indexOf("x") + 1);
         }
         else if(Boolean(text) && text.indexOf("Stun") != -1)
         {
            field1.text = text.substring(text.indexOf("n") + 2);
            field2.text = text.substring(0,text.indexOf("n") + 1);
         }
         else if(text != null)
         {
            field1.text = text;
         }
         else
         {
            field1.text = "" + damage;
         }
      }
      
      private function setPositions() : void
      {
         this.name.x = (160 - this.name.width) / 2;
         this.name.y = 2;
         if(Const.FONT == "Blah")
         {
            this.name.y += 4;
         }
         this._damage.x = 12;
         this._damage.y = 33;
         if(this.damage2 != null && this.damage.text != "Stun")
         {
            this.damage2.x = 35;
            this.damage2.y = 37;
            this.damage.x = 35 + this.damage2.width - 3;
            this.damage.y = 30;
         }
         else if(this.damage2 != null && this.damage.text == "Stun")
         {
            this.damage2.x = 35;
            this.damage2.y = 37;
            this.damage.x = 35 + this.damage2.width + 1;
            this.damage.y = 30;
         }
         else
         {
            this.damage.x = 35;
            this.damage.y = 30;
         }
         this._damage_arrow.x = 80;
         this._damage_arrow.y = 33;
         if(this.damage_up2 != null && this.damage_up.text != "Stun")
         {
            this.damage_up2.x = 109;
            this.damage_up2.y = 37;
            this.damage_up.x = 109 + this.damage_up2.width - 3;
            this.damage_up.y = 30;
         }
         else if(this.damage_up2 != null && this.damage_up.text == "Stun")
         {
            this.damage_up2.x = 109;
            this.damage_up2.y = 37;
            this.damage_up.x = 109 + this.damage_up2.width + 1;
            this.damage_up.y = 30;
         }
         else
         {
            this.damage_up.x = 109;
            this.damage_up.y = 30;
         }
         this._range.x = 12;
         this._range.y = 63;
         this.range.x = 35;
         this.range.y = 60;
         this._range_arrow.x = 80;
         this._range_arrow.y = 63;
         this.range_up.x = 109;
         this.range_up.y = 60;
         this._speed.x = 12;
         this._speed.y = 93;
         this.speed.x = 35;
         this.speed.y = 90;
         this._speed_arrow.x = 80;
         this._speed_arrow.y = 93;
         this.speed_up.x = 109;
         this.speed_up.y = 90;
         this.target_first.x = 9 + this.x;
         this.target_first.y = 125 + this.y;
         this.target_last.x = 45 + this.x;
         this.target_last.y = 125 + this.y;
         this.target_strong.x = 81 + this.x;
         this.target_strong.y = 125 + this.y;
         this.target_weak.x = 117 + this.x;
         this.target_weak.y = 125 + this.y;
         this.upgradeButton.x = 10 + this.x;
         this.upgradeButton.y = 154 + this.y;
         this.sellButton.x = 10 + this.x;
         this.sellButton.y = 184 + this.y;
         this.damage_tt.x = 12 + this.x;
         this.damage_tt.y = 33 + this.y;
         this.range_tt.x = 12 + this.x;
         this.range_tt.y = 63 + this.y;
         this.speed_tt.x = 12 + this.x;
         this.speed_tt.y = 93 + this.y;
      }
      
      private function addFields() : void
      {
         add(this.name);
         add(this._damage);
         add(this.damage2);
         add(this.damage);
         add(this._damage_arrow);
         add(this.damage_up2);
         add(this.damage_up);
         add(this._range);
         add(this.range);
         add(this._range_arrow);
         add(this.range_up);
         add(this._speed);
         add(this.speed);
         add(this._speed_arrow);
         add(this.speed_up);
         add(this.target_first);
         add(this.target_last);
         add(this.target_strong);
         add(this.target_weak);
         add(this.upgradeButton);
         add(this.sellButton);
         if(Localizer.Instance.isDefault())
         {
            add(this.damage_tt);
            add(this.range_tt);
            add(this.speed_tt);
         }
         this.setPositions();
      }
      
      private function getSellValue() : Number
      {
         var sell_value:int = 0;
         if(Globals.rank <= Const.BRONZE)
            sell_value = Math.floor(this.target.cost * 0.9);
         else if(Globals.rank <= Const.SILVER)
            sell_value = Math.floor(this.target.cost * 0.85);
         else if(Globals.rank <= Const.GOLD)
            sell_value = Math.floor(this.target.cost * 0.8);
         else if(Globals.rank <= Const.PLATINUM)
            sell_value = Math.floor(this.target.cost * 0.75);
         else if(Globals.rank <= Const.DIAMOND)
            sell_value = Math.floor(this.target.cost * 0.7);
         else
            sell_value = Math.floor(this.target.cost * 0.65);
         return sell_value;
      }
      
      override public function added() : void
      {
         var damage_text:String;
         var range_text:String;
         var speed_text:String;
         this.setupFields();
         Globals.selected_tower = this.target;
         this.target.showRangeCircle();
         this.name.font = Const.FONT;
         this.name.text = "" + this.target.name;
         Text.font = Const.FONT_TEXT;
         this.setDamageText(this.damage,this.damage2,this.target.damage,this.target.damage_text);
         this.range.text = "" + this.target.range;
         this.speed.text = "" + this.target.speed;
         if(Boolean(this.target.upgrade_to))
         {
            this.setDamageText(this.damage_up,this.damage_up2,Towers[this.target.tower_type][this.target.level + 1].damage,Towers[this.target.tower_type][this.target.level + 1].damage_text);
            this.range_up.text = "" + Towers[this.target.tower_type][this.target.level + 1].range;
            this.speed_up.text = "" + Towers[this.target.tower_type][this.target.level + 1].speed;
         }
         else
         {
            this.damage_up.text = Localizer.Instance.tower_info_max;
            this.range_up.text = Localizer.Instance.tower_info_max;
            this.speed_up.text = Localizer.Instance.tower_info_max;
         }
         this.target_first = new TargetFirstButton(this.target,this.target.target_state == TowerEntity.TARGET_FIRST,this.target.disable_targetting);
         this.target_last = new TargetLastButton(this.target,this.target.target_state == TowerEntity.TARGET_LAST,this.target.disable_targetting);
         this.target_strong = new TargetStrongButton(this.target,this.target.target_state == TowerEntity.TARGET_STRONGEST,this.target.disable_targetting);
         this.target_weak = new TargetWeakButton(this.target,this.target.target_state == TowerEntity.TARGET_WEAKEST,this.target.disable_targetting);
         this.upgradeButton = new GenericButton(Localizer.Instance.upgrade + " " + this.target.upgrade_cost,0,0,function():void
         {
            target.upgrade(true);
         });
         this.sellButton = new GenericButton(Localizer.Instance.sell + " " + this.getSellValue(),0,0,function():void
         {
            target.sell();
         });
         damage_text = this.target.damage + " damage per shot";
         if(this.target.splash_damage > 0)
         {
            damage_text += "\n" + this.target.splash_damage + " splash damage per shot";
         }
         if(this.target.flame_damage > 0)
         {
            damage_text += "\n" + this.target.flame_damage + " burn over " + this.target.flame_duration + " seconds";
         }
         if(this.target.slow > 0)
         {
            damage_text += "\n" + int(this.target.slow * 100) + " percent slow for\n" + this.target.slow_time + " seconds";
         }
         if(this.target.total_missiles > 0)
         {
            damage_text += "\n" + (this.target.total_missiles - this.target.ground_missiles) + " anti-air missile per volley";
         }
         if(this.target.ground_missiles > 0)
         {
            damage_text += "\n" + this.target.ground_missiles + " anti-ground missiles per volley";
         }
         if(this.target is SamTower && this.target.level == 5)
         {
            damage_text += "\n1 super missile per volley";
         }
         if(this.target is BuzzsawTower)
         {
            damage_text += "\n8 targets max, half damage\nto each additional target";
         }
         if(this.target.stun_length > 0)
         {
            damage_text += "\nStuns " + this.target.stun_targets + " zombie for " + this.target.stun_length + " seconds";
         }
         range_text = this.target.range + " tower range";
         if(this.target.splash_range > 0)
         {
            range_text += "\n" + this.target.splash_range + " splash range";
         }
         speed_text = this.target.speed + " shots per second";
         this.damage_tt.setText(damage_text);
         this.range_tt.setText(range_text);
         this.speed_tt.setText(speed_text);
         if(this.target.upgrade_to == null)
         {
            this.upgradeButton.disable(Localizer.Instance.tower_info_max_upgrade);
            this.enabled = false;
         }
         this.addFields();
         this.graphic = new Image(Assets.GFX_TOWER_MENU);
         super.added();
      }
      
      override public function removed() : void
      {
         if(Boolean(this.target))
         {
            this.target.hideRangeCircle();
         }
         this.removeAll();
         this.graphic = null;
         this.name = null;
         this.damage = null;
         this.damage2 = null;
         this.range = null;
         this.speed = null;
         this.damage_up = null;
         this.damage_up2 = null;
         this.range_up = null;
         this.speed_up = null;
         this.upgradeButton = null;
         this.sellButton = null;
         this.damage_tt = null;
         this.range_tt = null;
         this.speed_tt = null;
         this.target_first = null;
         this.target_last = null;
         this.target_weak = null;
         this.target_strong = null;
         this.enabled = true;
         super.removed();
      }
      
      override public function update() : void
      {
         if(this.enabled == false && this.target.canUpgrade())
         {
            this.enabled = true;
            this.upgradeButton.enable();
         }
         else if(this.enabled && !this.target.canUpgrade())
         {
            this.enabled = false;
            this.upgradeButton.disable();
         }
         super.update();
      }
   }
}

