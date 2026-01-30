package entities.menu
{
   import entities.Container;
   import flash.geom.Rectangle;
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Text;
   import spill.localisation.SpilGame;
   
   public class TowerMenuHover extends Container
   {
      
      private var tower_type:String;
      
      private var enabled:Image = new Image(Assets.GFX_TOWER_MENU_HOVER,new Rectangle(0,0,160,160));
      
      private var disabled:Image = new Image(Assets.GFX_TOWER_MENU_HOVER,new Rectangle(0,160,160,160));
      
      private var isEnabled:Boolean = false;
      
      public function TowerMenuHover(tower_type:String)
      {
         super();
         this.tower_type = tower_type;
         if(Globals.score.money >= Towers[this.tower_type][1].cost)
         {
            this.graphic = this.enabled;
            this.isEnabled = true;
         }
         else
         {
            this.graphic = this.disabled;
            this.isEnabled = false;
         }
         this.x = 480;
         this.y = 315;
      }
      
      override public function added() : void
      {
         var groundAir:Text = null;
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
         var name:Text = new Text(Towers[this.tower_type][1].name);
         name.color = 0;
         switch(SpilGame.currentLanguage.name)
         {
            case "ru":
               Text.size = 10;
               break;
            default:
               Text.size = 12 / Const.FONT_OFFSET;
         }
         Text.font = Const.FONT_TEXT;
         var labels:Text = new Text(Localizer.Instance.tower_info_cost + "\n" + Localizer.Instance.tower_info_damage + "\n" + Localizer.Instance.tower_info_range + "\n" + Localizer.Instance.tower_info_speed + "\n" + Localizer.Instance.tower_info_effects);
         labels.color = 0;
         var labels2:Text = new Text(Localizer.Instance.tower_info_cost + "\n" + Localizer.Instance.tower_info_damage + "\n" + Localizer.Instance.tower_info_range + "\n" + Localizer.Instance.tower_info_speed + "\n" + Localizer.Instance.tower_info_effects);
         labels2.color = 0;
         if(Boolean(Towers[this.tower_type][1].ground) && Boolean(Towers[this.tower_type][1].air))
         {
            groundAir = new Text(Localizer.Instance.tower_info_ground_air);
         }
         else if(Boolean(Towers[this.tower_type][1].ground))
         {
            groundAir = new Text(Localizer.Instance.tower_info_ground_only);
         }
         else
         {
            groundAir = new Text(Localizer.Instance.tower_info_air_only);
         }
         var groundAir2:Text = new Text(groundAir.text);
         groundAir.color = 0;
         groundAir2.color = 0;
         Text.font = Const.FONT_TEXT;
         var costVal:Text = new Text("" + Towers[this.tower_type][1].cost);
         if(Towers[this.tower_type][1].cost > Globals.score.money)
         {
            costVal.color = 16711680;
         }
         else
         {
            costVal.color = 0;
         }
         var damageVal:Text = new Text("" + Towers[this.tower_type][1].damage_display);
         if(Towers[this.tower_type][1].damage_display == Localizer.Instance.tower_info_low || Towers[this.tower_type][1].damage_display == Localizer.Instance.tower_info_none || Towers[this.tower_type][1].damage_display == Localizer.Instance.tower_info_very_low)
         {
            damageVal.color = 16711680;
         }
         else if(Towers[this.tower_type][1].damage_display == Localizer.Instance.tower_info_average)
         {
            damageVal.color = 255;
         }
         else
         {
            damageVal.color = 39202;
         }
         var rangeVal:Text = new Text("" + Towers[this.tower_type][1].range_display);
         if(Towers[this.tower_type][1].range_display == Localizer.Instance.tower_info_short)
         {
            rangeVal.color = 16711680;
         }
         else if(Towers[this.tower_type][1].range_display == Localizer.Instance.tower_info_medium)
         {
            rangeVal.color = 255;
         }
         else
         {
            rangeVal.color = 39202;
         }
         var speedVal:Text = new Text("" + Towers[this.tower_type][1].speed_display);
         if(Towers[this.tower_type][1].speed_display == Localizer.Instance.tower_info_slow || Towers[this.tower_type][1].speed_display == Localizer.Instance.tower_info_none || Towers[this.tower_type][1].speed_display == Localizer.Instance.tower_info_very_slow)
         {
            speedVal.color = 16711680;
         }
         else if(Towers[this.tower_type][1].speed_display == Localizer.Instance.tower_info_normal)
         {
            speedVal.color = 255;
         }
         else
         {
            speedVal.color = 39202;
         }
         var effectVal:Text = new Text("" + Towers[this.tower_type][1].effect_display);
         effectVal.color = 10057472;
         add(new Entity(0,0,name),(160 - name.width) / 2,3);
         if(Const.FONT == "Blah")
         {
            name.y += 4;
         }
         add(new Entity(0,0,groundAir),(160 - groundAir.width) / 2,28);
         add(new Entity(0,0,groundAir2),(160 - groundAir.width) / 2 + 1,28);
         add(new Entity(0,0,labels),8,46);
         add(new Entity(0,0,labels2),9,46);
         var cur_y:Number = 46;
         var delt_y:Number = 12;
         var x_loc:Number = 60;
         switch(SpilGame.currentLanguage.name)
         {
            case "de":
               x_loc = 85;
               cur_y = 46;
               delt_y = 10;
               break;
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
               x_loc = 60;
               cur_y = 46;
               delt_y = 10;
               break;
            default:
               x_loc = 60;
               cur_y = 46;
               delt_y = 13;
         }
         add(new Entity(0,0,costVal),x_loc,cur_y);
         cur_y += delt_y;
         add(new Entity(0,0,damageVal),x_loc,cur_y);
         cur_y += delt_y;
         add(new Entity(0,0,rangeVal),x_loc,cur_y);
         cur_y += delt_y;
         add(new Entity(0,0,speedVal),x_loc,cur_y);
         cur_y += delt_y;
         add(new Entity(0,0,effectVal),x_loc,cur_y);
         cur_y += delt_y;
      }
      
      override public function removed() : void
      {
         super.removed();
      }
      
      override public function update() : void
      {
         if(!this.isEnabled && Globals.score.money >= Towers[this.tower_type][1].cost)
         {
            this.graphic = this.enabled;
            this.isEnabled = true;
         }
         else if(this.isEnabled && Globals.score.money < Towers[this.tower_type][1].cost)
         {
            this.graphic = this.disabled;
            this.isEnabled = false;
         }
         super.update();
      }
   }
}

