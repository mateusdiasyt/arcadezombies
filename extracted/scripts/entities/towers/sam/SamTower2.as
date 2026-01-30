package entities.towers.sam
{
   import entities.bullets.Missile;
   import flash.geom.Point;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class SamTower2 extends SamTower
   {
      
      public function SamTower2()
      {
         super(2,11);
         this.turret = new Image(Assets.GFX_TOWER_SPRITESHEET,Assets.TURRETS["SAM"][2]);
         this.level = 2;
         this.name = Towers.sam[this.level].name;
         this.ground = Towers.sam[this.level].ground;
         this.air = Towers.sam[this.level].air;
         this.range = Towers.sam[this.level].range;
         this.speed = Towers.sam[this.level].speed;
         this.damage = Towers.sam[this.level].damage;
         this.bullet_speed = Towers.sam[this.level].bullet_speed;
         this.max_targets = Towers.sam[this.level].max_targets;
         this.total_missiles = Towers.sam[this.level].total_missiles;
         this.damage_text = Towers.sam[this.level].damage_text;
         this.cost = Towers.sam[this.level].cost;
         this.upgrade_cost = Towers.sam[this.level].upgrade_cost;
         this.upgrade_to = Towers.sam[this.level].upgrade_to;
      }
      
      override protected function shoot() : void
      {
         SoundManager.playSound(Assets.SFX_SAM);
         var m:Array = new Array(new Point(),new Point(),new Point(),new Point(),new Point());
         m[0].x = this.centerX - Math.cos(-this.turret.angle * Math.PI / 180) * 5;
         m[0].y = this.centerY - Math.sin(-this.turret.angle * Math.PI / 180) * 5;
         m[1].x = this.centerX - Math.cos(-(this.turret.angle - 40) * Math.PI / 180) * 7;
         m[1].y = this.centerY - Math.sin(-(this.turret.angle - 40) * Math.PI / 180) * 7;
         m[2].x = this.centerX - Math.cos(-(this.turret.angle + 40) * Math.PI / 180) * 7;
         m[2].y = this.centerY - Math.sin(-(this.turret.angle + 40) * Math.PI / 180) * 7;
         m[3].x = this.centerX - Math.cos(-(this.turret.angle - 90) * Math.PI / 180) * 2;
         m[3].y = this.centerY - Math.sin(-(this.turret.angle - 90) * Math.PI / 180) * 2;
         m[4].x = this.centerX - Math.cos(-(this.turret.angle + 90) * Math.PI / 180) * 2;
         m[4].y = this.centerY - Math.sin(-(this.turret.angle + 90) * Math.PI / 180) * 2;
         Globals.effects.emitSmoke(this.centerX - 15,this.centerY - 15);
         var inrange:Array = Globals.zombies.getFlying(this.centerX,this.centerY,this.range,false);
         inrange = inrange.splice(0,Math.min(max_targets,inrange.length));
         for(var i:int = 0; i < m.length; i++)
         {
            FP.world.add(Missile.create(this.bullet,this,m[i].x,m[i].y,inrange[i % inrange.length]));
         }
      }
   }
}

