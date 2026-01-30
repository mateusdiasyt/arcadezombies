package entities.menu
{
   import entities.Container;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Text;
   import spill.localisation.SpilGame;
   import utils.SuperText;
   
   public class HelpMenu extends Container
   {
      
      private var background:Image = new Image(Assets.GFX_HELP_WINDOW);
      
      public function HelpMenu()
      {
         super();
         this.graphic = this.background;
      }
      
      override public function added() : void
      {
         Globals.paused = true;
         this.x = (FP.width - 384) / 2;
         this.y = (FP.height - 300) / 2;
         Text.size = 24 / Const.FONT_OFFSET;
         Text.font = Const.FONT;
         var shortcuts:SuperText = new SuperText(Localizer.Instance.help_title + ":",35,19,{
            "outlineColor":0,
            "outlineStrength":5
         });
         shortcuts.color = 16775913;
         var x_loc:Number = 58;
         var y_offset:Number = 0;
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
               Text.size = 14 / Const.FONT_OFFSET;
               y_offset = 4;
               x_loc = 48;
               break;
            default:
               Text.size = 18 / Const.FONT_OFFSET;
               y_offset = 0;
               x_loc = 58;
         }
         var sentry:SuperText = new SuperText(Localizer.Instance.help_buy_sentry,x_loc,48 + y_offset);
         sentry.color = 0;
         var cannon:SuperText = new SuperText(Localizer.Instance.help_buy_cannon,x_loc,70 + y_offset);
         cannon.color = 0;
         var sam:SuperText = new SuperText(Localizer.Instance.help_buy_sam,x_loc,91 + y_offset);
         sam.color = 0;
         var sensor:SuperText = new SuperText(Localizer.Instance.help_buy_sensor,x_loc,112 + y_offset);
         sensor.color = 0;
         var ice:SuperText = new SuperText(Localizer.Instance.help_buy_ice,x_loc,133 + y_offset);
         ice.color = 0;
         var rapid:SuperText = new SuperText(Localizer.Instance.help_buy_minigun,x_loc,155 + y_offset);
         rapid.color = 0;
         var buzzsaw:SuperText = new SuperText(Localizer.Instance.help_buy_buzzsaw,x_loc,177 + y_offset);
         buzzsaw.color = 0;
         var fire:SuperText = new SuperText(Localizer.Instance.help_buy_flame,x_loc,198 + y_offset);
         fire.color = 0;
         var laser:SuperText = new SuperText(Localizer.Instance.help_buy_laser,x_loc,219 + y_offset);
         laser.color = 0;
         var x_offset:Number = 0;
         switch(SpilGame.currentLanguage.name)
         {
            case "ru":
            case "id":
            case "it":
               x_offset = -25;
               break;
            case "fr":
            case "es":
            case "es_ar":
            case "es_mx":
            case "nl":
               x_offset = -40;
               break;
            default:
               x_offset = 0;
         }
         var calling:SuperText = new SuperText(Localizer.Instance.help_call_early,46 + x_offset,252,{
            "outlineColor":0,
            "outlineStrength":4
         });
         calling.color = 13037055;
         var upgrade:SuperText = new SuperText(Localizer.Instance.help_upgrade_tower,230,48 + y_offset);
         upgrade.color = 0;
         var sell:SuperText = new SuperText(Localizer.Instance.help_sell_tower,230,70 + y_offset);
         sell.color = 0;
         var call_next:SuperText = new SuperText(Localizer.Instance.toolbar_next_level,230,91 + y_offset);
         call_next.color = 0;
         var pause:SuperText = new SuperText(Localizer.Instance.help_options_pause,230,112 + y_offset);
         pause.color = 0;
         var tower_sell_value:SuperText = new SuperText(Localizer.Instance.help_sell_title,188,177);
         tower_sell_value.color = 0;
         Text.size = 14 / Const.FONT_OFFSET;
         var easy:SuperText = new SuperText(Localizer.Instance.difficulty_easy,174,195);
         easy.color = 0;
         var normal:SuperText = new SuperText(Localizer.Instance.difficulty_normal,214,195);
         normal.color = 0;
         var hard:SuperText = new SuperText(Localizer.Instance.difficulty_hard,259,195);
         hard.color = 0;
         var hell:SuperText = new SuperText(Localizer.Instance.difficulty_hell,300,195);
         hell.color = 0;
         add(new Entity(0,0,shortcuts));
         add(new Entity(0,0,sentry));
         add(new Entity(0,0,cannon));
         add(new Entity(0,0,sam));
         add(new Entity(0,0,sensor));
         add(new Entity(0,0,ice));
         add(new Entity(0,0,rapid));
         add(new Entity(0,0,buzzsaw));
         add(new Entity(0,0,fire));
         add(new Entity(0,0,laser));
         add(new Entity(0,0,upgrade));
         add(new Entity(0,0,sell));
         add(new Entity(0,0,call_next));
         add(new Entity(0,0,pause));
         add(new Entity(0,0,calling));
         add(new Entity(0,0,tower_sell_value));
         add(new Entity(0,0,easy));
         add(new Entity(0,0,normal));
         add(new Entity(0,0,hard));
         add(new Entity(0,0,hell));
         super.added();
      }
      
      override public function removed() : void
      {
         Globals.paused = false;
         super.removed();
      }
   }
}

