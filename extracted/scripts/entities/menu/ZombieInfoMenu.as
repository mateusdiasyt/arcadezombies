package entities.menu
{
   import entities.Container;
   import entities.ZombieEntity;
   import flash.geom.Rectangle;
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Graphiclist;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Text;
   
   public class ZombieInfoMenu extends Container
   {
      
      public var target:ZombieEntity = null;
      
      private var titleText:Text = null;
      
      private var titleText2:Text = null;
      
      private var nameText:Text = null;
      
      private var healthText:Text = null;
      
      private var armorText:Text = null;
      
      private var bountyText:Text = null;
      
      private var abilityText:Text = null;
      
      private var statusText:Text = null;
      
      private var portrait:Image;
      
      private var portrait_entity:Entity;
      
      private var bg:Image = new Image(Assets.GFX_ZOMBIE_INFO);
      
      private var gl:Graphiclist;
      
      private var empty_burn:Image = new Image(Assets.GFX_STATUS_ICONS,new Rectangle(0,0,13,13));
      
      private var empty_ice:Image = new Image(Assets.GFX_STATUS_ICONS,new Rectangle(0,0,13,13));
      
      private var empty_stun:Image = new Image(Assets.GFX_STATUS_ICONS,new Rectangle(0,0,13,13));
      
      private var burn:Image = new Image(Assets.GFX_STATUS_ICONS,new Rectangle(13,0,13,13));
      
      private var ice:Image = new Image(Assets.GFX_STATUS_ICONS,new Rectangle(26,0,13,13));
      
      private var stun:Image = new Image(Assets.GFX_STATUS_ICONS,new Rectangle(39,0,13,13));
      
      public function ZombieInfoMenu(target:ZombieEntity)
      {
         super();
         this.bg.x = 480 - 205;
         this.bg.y = 5;
         this.target = target;
         this.target.halo.alpha = 1;
         Text.size = 20 / Const.FONT_OFFSET;
         Text.font = Const.FONT;
         this.nameText = new Text(this.target.name,325,8,300);
         this.nameText.color = 0;
         if(Const.FONT == "Blah")
         {
            this.nameText.y += 4;
         }
         Text.size = 12 / Const.FONT_OFFSET;
         Text.font = Const.FONT_TEXT;
         this.titleText = new Text(Localizer.Instance.zombie_info_life + "\n" + Localizer.Instance.zombie_info_armor + "\n" + Localizer.Instance.zombie_info_bounty,325,32);
         this.titleText.color = 0;
         this.titleText2 = new Text(this.titleText.text,this.titleText.x + 1,this.titleText.y);
         this.titleText2.color = 0;
         var cur_y:Number = 32;
         var delt_y:Number = 13;
         if(Const.FONT == "Blah")
         {
            delt_y = 9;
         }
         this.healthText = new Text("",368,cur_y,255,20);
         this.healthText.color = 0;
         cur_y += delt_y;
         this.armorText = new Text("",368,cur_y,255,20);
         this.armorText.color = 0;
         cur_y += delt_y;
         this.bountyText = new Text("",368,cur_y,255,20);
         this.bountyText.color = 0;
         cur_y += delt_y;
         this.abilityText = new Text("",325,cur_y + 2,255,20);
         this.abilityText.color = 0;
         this.portrait = new Image(Assets.GFX_ZOMBIE_INFO_PORTRAITS,new Rectangle(target.portrait_index / 3 * 36,0,36,36));
         this.portrait.x = 284;
         this.portrait.y = 14;
         this.portrait_entity = new Entity(0,0,this.portrait);
         this.burn.alpha = 0;
         this.ice.alpha = 0;
         this.stun.alpha = 0;
         this.graphic = this.bg;
      }
      
      override public function added() : void
      {
         add(new Entity(0,0,this.nameText),0,0);
         add(new Entity(0,0,this.titleText),0,0);
         add(new Entity(0,0,this.titleText),0,0);
         add(new Entity(0,0,this.healthText),0,0);
         add(new Entity(0,0,this.armorText),0,0);
         add(new Entity(0,0,this.bountyText),0,0);
         add(new Entity(0,0,this.abilityText),0,0);
         add(this.portrait_entity,0,0);
         add(new Entity(0,0,this.empty_burn),296,54);
         add(new Entity(0,0,this.burn),296,54);
         add(new Entity(0,0,this.empty_ice),285,73);
         add(new Entity(0,0,this.ice),285,73);
         add(new Entity(0,0,this.empty_stun),307,73);
         add(new Entity(0,0,this.stun),307,73);
      }
      
      public function reset(target:ZombieEntity) : void
      {
         if(Boolean(this.target) && this.target != target)
         {
            this.target.halo.alpha = 0;
         }
         this.target = target;
         this.target.halo.alpha = 1;
         this.nameText.text = this.target.name;
         this.portrait = new Image(Assets.GFX_ZOMBIE_INFO_PORTRAITS,new Rectangle(target.portrait_index / 3 * 36,0,36,36));
         this.portrait.x = 284;
         this.portrait.y = 14;
         this.portrait_entity.graphic = this.portrait;
      }
      
      override public function removed() : void
      {
         if(Boolean(this.target))
         {
            this.target.halo.alpha = 0;
         }
         super.removed();
      }
      
      override public function update() : void
      {
         this.healthText.text = Math.ceil(this.target.health) + "/" + Math.ceil(this.target.total_health);
         this.armorText.text = "" + Math.round(this.target.armor);
         this.bountyText.text = "" + Math.round(this.target.bounty);
         if(this.target.flying && this.target.invisible)
         {
            this.abilityText.text = Localizer.Instance.zombie_info_flying + " - " + Localizer.Instance.zombie_info_invisible;
         }
         else if(this.target.flying)
         {
            this.abilityText.text = Localizer.Instance.zombie_info_flying;
         }
         else if(this.target.invisible)
         {
            this.abilityText.text = Localizer.Instance.zombie_info_invisible;
         }
         else
         {
            this.abilityText.text = Localizer.Instance.zombie_info_no_special;
         }
         if(this.target.burning)
         {
            this.burn.alpha = 1;
         }
         else
         {
            this.burn.alpha = 0;
         }
         if(this.target.frozen)
         {
            this.ice.alpha = 1;
         }
         else
         {
            this.ice.alpha = 0;
         }
         if(this.target.stunned)
         {
            this.stun.alpha = 1;
         }
         else
         {
            this.stun.alpha = 0;
         }
         this.target.halo.alpha = 1;
         super.update();
      }
   }
}

