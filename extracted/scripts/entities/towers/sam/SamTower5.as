package entities.towers.sam
{
   import achievements.Tracker;
   import entities.bullets.Missile;
   import entities.bullets.SuperMissile;
   import flash.geom.Point;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class SamTower5 extends SamTower
   {
      
      public function SamTower5()
      {
         super(2,14);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["SAM"][5]);
         this.level = 5;
         this.name = Towers.sam[this.level].name;
         this.ground = Towers.sam[this.level].ground;
         this.air = Towers.sam[this.level].air;
         this.range = Towers.sam[this.level].range;
         this.speed = Towers.sam[this.level].speed;
         this.damage = Towers.sam[this.level].damage;
         this.bullet_speed = Towers.sam[this.level].bullet_speed;
         this.max_targets = Towers.sam[this.level].max_targets;
         this.total_missiles = Towers.sam[this.level].total_missiles;
         this.ground_missiles = Towers.sam[this.level].ground_missiles;
         this.damage_text = Towers.sam[this.level].damage_text;
         this.cost = Towers.sam[this.level].cost;
         this.upgrade_cost = Towers.sam[this.level].upgrade_cost;
         this.upgrade_to = Towers.sam[this.level].upgrade_to;
      }
      
      override protected function tower_placed() : void
      {
         Globals.tracker.incrementData(Tracker.SAM_LEVEL_5,1);
         super.tower_placed();
      }
      
      override protected function shoot() : void
      {
         var i:int = 0;
         SoundManager.playSound(Assets.SFX_SAM);
         var m:Array = new Array(new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point());
         m[0].x = this.centerX - Math.cos(-(this.turret.angle + 20) * Math.PI / 180) * 8;
         m[0].y = this.centerY - Math.sin(-(this.turret.angle + 20) * Math.PI / 180) * 8;
         m[1].x = this.centerX - Math.cos(-(this.turret.angle - 20) * Math.PI / 180) * 8;
         m[1].y = this.centerY - Math.sin(-(this.turret.angle - 20) * Math.PI / 180) * 8;
         m[2].x = this.centerX - Math.cos(-(this.turret.angle + 45) * Math.PI / 180) * 10;
         m[2].y = this.centerY - Math.sin(-(this.turret.angle + 45) * Math.PI / 180) * 10;
         m[3].x = this.centerX - Math.cos(-(this.turret.angle - 45) * Math.PI / 180) * 10;
         m[3].y = this.centerY - Math.sin(-(this.turret.angle - 45) * Math.PI / 180) * 10;
         m[4].x = this.centerX - Math.cos(-this.turret.angle * Math.PI / 180) * 4;
         m[4].y = this.centerY - Math.sin(-this.turret.angle * Math.PI / 180) * 4;
         m[5].x = this.centerX - Math.cos(-(this.turret.angle + 45) * Math.PI / 180) * 6;
         m[5].y = this.centerY - Math.sin(-(this.turret.angle + 45) * Math.PI / 180) * 6;
         m[6].x = this.centerX - Math.cos(-(this.turret.angle - 45) * Math.PI / 180) * 6;
         m[6].y = this.centerY - Math.sin(-(this.turret.angle - 45) * Math.PI / 180) * 6;
         m[7].x = this.centerX - Math.cos(-(this.turret.angle + 90) * Math.PI / 180) * 3;
         m[7].y = this.centerY - Math.sin(-(this.turret.angle + 90) * Math.PI / 180) * 3;
         m[8].x = this.centerX - Math.cos(-(this.turret.angle + 90) * Math.PI / 180) * 6;
         m[8].y = this.centerY - Math.sin(-(this.turret.angle + 90) * Math.PI / 180) * 6;
         m[9].x = this.centerX - Math.cos(-(this.turret.angle - 90) * Math.PI / 180) * 3;
         m[9].y = this.centerY - Math.sin(-(this.turret.angle - 90) * Math.PI / 180) * 3;
         m[10].x = this.centerX - Math.cos(-(this.turret.angle - 90) * Math.PI / 180) * 6;
         m[10].y = this.centerY - Math.sin(-(this.turret.angle - 90) * Math.PI / 180) * 6;
         Globals.effects.emitSmoke(this.centerX - 15,this.centerY - 15);
         var air:Array = Globals.zombies.getFlying(this.centerX,this.centerY,this.range,false);
         var ground:Array = Globals.zombies.getGround(this.centerX,this.centerY,this.range,false);
         air = air.splice(0,Math.min(max_targets,air.length,total_missiles - ground_missiles));
         ground = ground.splice(0,Math.min(max_targets,ground.length,ground_missiles));
         if(air.length > 0)
         {
            for(i = 0; i < total_missiles - ground_missiles; i++)
            {
               FP.world.add(Missile.create(this.bullet,this,m[i].x,m[i].y,air[i % air.length]));
            }
         }
         if(ground.length > 0)
         {
            for(i = 0; i < ground_missiles; i++)
            {
               FP.world.add(Missile.create(this.bullet,this,m[i].x,m[i].y,ground[i % ground.length]));
            }
         }
         if(air.length > 0)
         {
            FP.world.add(SuperMissile.create(Assets.GFX_SUPER_MISSILE,this,m[10].x,m[10].y,air[0]));
         }
      }
   }
}

