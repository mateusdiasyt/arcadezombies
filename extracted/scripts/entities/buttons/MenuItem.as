package entities.buttons
{
   import entities.Button;
   import entities.menu.TowerMenuHover;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Spritemap;
   
   public class MenuItem extends Button
   {
      
      public var cost:int;
      
      public var tower:Class;
      
      public var tower_type:String;
      
      private var image:Spritemap = new Spritemap(Assets.GFX_TOWER_PORTRAITS,40,40);
      
      private var disabled:Boolean = false;
      
      private var hoverMenu:TowerMenuHover;
      
      public function MenuItem(tower_type:String)
      {
         super();
         this.tower_type = tower_type;
         this.tower = Towers[this.tower_type][1].klass;
         var index:int = int(Towers[this.tower_type][1].portrait_index);
         this.cost = Towers[this.tower_type][1].cost;
         this.image.add("portrait",[index]);
         this.image.play("portrait");
         this.image.add("hover",[index + 1]);
         this.image.add("too_much",[index + 2]);
         this.setHitbox(40,40);
         this.graphic = this.image;
      }
      
      override public function update() : void
      {
         super.update();
         if(Globals.score.money < this.cost)
         {
            this.disabled = true;
            this.image.play("too_much");
         }
         else if(this.disabled)
         {
            this.disabled = false;
            this.image.play("portrait");
         }
      }
      
      override public function clickAction() : void
      {
         if(!this.disabled)
         {
            if(!Globals.placing_tower)
            {
               if(Globals.score.money >= Towers[this.tower_type][1].cost)
               {
                  Globals.placing_tower = new this.tower();
                  FP.world.add(Globals.placing_tower);
               }
            }
            else if(Globals.placing_tower is this.tower)
            {
               Button.current_hover = null;
               FP.world.remove(Globals.placing_tower);
               Globals.placing_tower = null;
            }
            else if(Boolean(Globals.placing_tower))
            {
               Button.current_hover = null;
               FP.world.remove(Globals.placing_tower);
               Globals.placing_tower = null;
               if(Globals.score.money >= Towers[this.tower_type][1].cost)
               {
                  Globals.placing_tower = new this.tower();
                  FP.world.add(Globals.placing_tower);
               }
            }
            this.image.play("portrait");
         }
      }
      
      override public function mouseOver() : void
      {
         if(this.hoverMenu == null)
         {
            this.hoverMenu = new TowerMenuHover(this.tower_type);
         }
         FP.world.add(this.hoverMenu);
         if(!this.disabled)
         {
            this.image.play("hover");
         }
      }
      
      override public function mouseOut() : void
      {
         if(Boolean(this.hoverMenu))
         {
            FP.world.remove(this.hoverMenu);
         }
         if(!this.disabled && this.image != null)
         {
            this.image.play("portrait");
         }
      }
      
      public function removeMenu() : void
      {
         if(Boolean(this.hoverMenu))
         {
            FP.world.remove(this.hoverMenu);
         }
         this.hovering = false;
      }
   }
}

