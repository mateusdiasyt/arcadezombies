package entities.towers.buzzsaw
{
   import entities.TowerEntity;
   import entities.bullets.SawBlade;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Graphiclist;
   import net.flashpunk.graphics.Image;
   
   public class BuzzsawTower extends TowerEntity
   {
      
      private var _reload_timer:Number = 0;
      
      private var _reload:Boolean = false;
      
      protected var reload:Image = null;
      
      public function BuzzsawTower(base:int = 6, level:int = 30)
      {
         super();
         this.base = new Image(Assets.GFX_TOWER_BASES,Assets.BASES["buzzsaw"]);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["buzzsaw"][1]);
         this.reload = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["buzzsaw_reload"][1]);
         this.bullet = Assets.GFX_SAWBLADE;
         this.muzzle_flash = null;
         this.level = 1;
         this.tower_type = "buzzsaw";
         this.name = Towers.buzzsaw[this.level].name;
         this.damage_display = Towers.buzzsaw[this.level].damage_display;
         this.range_display = Towers.buzzsaw[this.level].range_display;
         this.speed_display = Towers.buzzsaw[this.level].speed_display;
         this.effect_display = Towers.buzzsaw[this.level].effect_display;
         this.portrait_index = Towers.buzzsaw[this.level].portrait_index;
         this.ground = Towers.buzzsaw[this.level].ground;
         this.air = Towers.buzzsaw[this.level].air;
         this.range = Towers.buzzsaw[this.level].range;
         this.speed = Towers.buzzsaw[this.level].speed;
         this.damage = Towers.buzzsaw[this.level].damage;
         this.cost = Towers.buzzsaw[this.level].cost;
         this.upgrade_cost = Towers.buzzsaw[this.level].upgrade_cost;
         this.upgrade_to = Towers.buzzsaw[this.level].upgrade_to;
      }
      
      override public function added() : void
      {
         super.added();
         this.reload.x = -3;
         this.reload.y = -3;
         this.reload.originX = 18;
         this.reload.originY = 18;
      }
      
      override public function update() : void
      {
         super.update();
         this.reload.angle = this.turret.angle;
         if(this._reload)
         {
            this._reload_timer += FP.elapsed * Globals.speed;
            if(this._reload_timer > 1 / this.speed - 1)
            {
               this._reload = false;
               this._reload_timer = 0;
               this.graphic = new Graphiclist(base,turret);
            }
         }
      }
      
      override protected function shoot() : void
      {
         SoundManager.playSound(Assets.SFX_BUZZSAW);
         var bx:Number = this.centerX;
         var by:Number = this.centerY;
         this.graphic = new Graphiclist(base,this.reload);
         this._reload = true;
         FP.world.add(SawBlade.create(this.bullet,this,bx,by));
      }
   }
}

