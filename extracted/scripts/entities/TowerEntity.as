package entities
{
   import achievements.Tracker;
   import bit101.Node;
   import entities.bullets.Bullet;
   import entities.menu.TowerHover;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import mx.utils.UIDUtil;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Graphiclist;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.utils.Input;
   import net.flashpunk.utils.Key;
   
   public class TowerEntity extends Button
   {
      
      public static var TARGET_FIRST:String = "First";
      
      public static var TARGET_LAST:String = "Last";
      
      public static var TARGET_WEAKEST:String = "Weak";
      
      public static var TARGET_STRONGEST:String = "Strong";
      
      public static var TARGET_AIR:String = "Air";
      
      public var cost:int = 10;
      
      public var target_state:String = TARGET_FIRST;
      
      public var name:String = "";
      
      public var descr:String = "";
      
      public var damage_display:String = "";
      
      public var range_display:String = "";
      
      public var speed_display:String = "";
      
      public var effect_display:String = "";
      
      public var level:int = 1;
      
      public var damage_text:String = null;
      
      public var portrait_index:Number = 0;
      
      public var damage:Number = 1;
      
      public var range:int = 120;
      
      public var speed:Number = 1;
      
      public var slow:Number;
      
      public var slow_time:Number;
      
      public var slow_rank:Number;
      
      public var splash_damage:Number;
      
      public var splash_range:Number;
      
      public var ground:Boolean = true;
      
      public var air:Boolean = true;
      
      public var bullet_speed:Number = 5;
      
      public var upgrade_cost:int = 50;
      
      public var upgrade_to:Class = null;
      
      public var turret:Image = null;
      
      protected var base:Image = null;
      
      protected var bullet:Class = null;
      
      protected var muzzle_flash:Image = null;
      
      private var flashTimer:Number = 0;
      
      private var shotTimer:Number = 0;
      
      public var target:ZombieEntity = null;
      
      protected var gl:Graphiclist = new Graphiclist();
      
      public var placed:Boolean = false;
      
      public var causes_hit:Boolean = true;
      
      private var range_sprite:Sprite = new Sprite();
      
      private var range_g:Graphics = this.range_sprite.graphics;
      
      private var range_visible:Boolean = true;
      
      private var range_line:uint = 26367;
      
      private var range_background:uint = 10092543;
      
      protected var no_targetting:Boolean = false;
      
      public var _shake:Boolean = false;
      
      public var _shake_duration:Number = 1;
      
      public var _shake_timer:Number = 0;
      
      public var _shake_x:Number = -3;
      
      public var _shake_y:Number = -3;
      
      private var _upgraded:Boolean = false;
      
      public var disable_targetting:Boolean = false;
      
      private var _hover_timer:Number = 0;
      
      private var _hovering:Boolean = false;
      
      private var _hoverWindow:TowerHover = null;
      
      public var kills:Number = 0;
      
      private var sold:Boolean = false;
      
      public var flame_damage:Number = 0;
      
      public var flame_duration:Number = 0;
      
      public var max_targets:Number = 0;
      
      public var total_missiles:Number = 0;
      
      public var ground_missiles:Number = 0;
      
      public var stun_length:Number = 0;
      
      public var stun_targets:Number = 0;
      
      public var tower_type:String = "";
      
      public function TowerEntity()
      {
         super();
         this.x = Math.round((Input.mouseX - 15) / Const.TILE_WIDTH) * Const.TILE_WIDTH;
         this.y = Math.round((Input.mouseY - 15) / Const.TILE_WIDTH) * Const.TILE_WIDTH;
         this.layer = Const.TOWER_LAYER;
         this.setHitbox(30,30);
      }
      
      override public function added() : void
      {
         Globals.range_circle.add(this.range_sprite);
         if(!this.placed)
         {
            this.x = Math.round((Input.mouseX - 15) / Const.TILE_WIDTH) * Const.TILE_WIDTH;
            this.y = Math.round((Input.mouseY - 15) / Const.TILE_WIDTH) * Const.TILE_WIDTH;
         }
         if(this.base != null)
         {
            this.base.originX = 15;
            this.base.originY = 15;
            this.gl.add(this.base);
         }
         if(this.turret != null)
         {
            this.turret.originX = 18;
            this.turret.originY = 18;
            this.turret.x = -3;
            this.turret.y = -3;
            this.gl.add(this.turret);
         }
         if(this.muzzle_flash != null)
         {
            this.muzzle_flash.alpha = 0;
            this.muzzle_flash.x = -16;
            this.muzzle_flash.y = 9;
            this.muzzle_flash.originX = 31;
            this.muzzle_flash.originY = 6;
            this.gl.add(this.muzzle_flash);
         }
         this.graphic = this.gl;
         super.added();
      }
      
      override public function removed() : void
      {
         Globals.removeTowerMenu(this);
         if(Boolean(this._hoverWindow))
         {
            FP.world.remove(this._hoverWindow);
         }
         Globals.range_circle.remove(this.range_sprite);
         if(Button.current_hover == this)
         {
            Button.current_hover = null;
         }
         this.target = null;
         this.turret = null;
         this.base = null;
         this.muzzle_flash = null;
         this.gl = null;
         this.graphic = null;
         Globals.removeTower(this);
         if(Globals.selected_tower == this)
         {
            Globals.selected_tower = null;
         }
         super.removed();
      }
      
      private function placeLoop() : void
      {
         this.x = Math.round((Input.mouseX - 15) / Const.TILE_WIDTH) * Const.TILE_WIDTH;
         this.y = Math.round((Input.mouseY - 15) / Const.TILE_WIDTH) * Const.TILE_WIDTH;
         if(this.validLocation(this.x,this.y))
         {
            this.turret.alpha = 1;
            this.base.alpha = 1;
            this.setRangeBlue();
         }
         else
         {
            this.turret.alpha = 0.5;
            this.base.alpha = 0.5;
            this.setRangeRed();
         }
         if(Input.pressed(Key.ESCAPE))
         {
            Globals.escape_timer = 0.25;
            Button.current_hover = null;
            Globals.placing_tower = null;
            Globals.hud.hideTowerInfo();
            FP.world.remove(this);
         }
         this.showRangeCircle();
      }
      
      override public function clickAction() : void
      {
         if(!this.placed && this.validLocation(this.x,this.y) && Globals.score.money >= this.cost)
         {
            SoundManager.playSound(Assets.SFX_CASH);
            Globals.score.money -= this.cost;
            Globals.map.pathGrid.getNode(this.toCol(x) + 1,this.toRow(y) + 1).hasTower = true;
            this.placed = true;
            Globals.tracker.incrementData(Tracker.TOWERS_PURCHASED,1);
            Globals.tracker.incrementData(Tracker.MONEY_SPENT,this.cost);
            Globals.placing_tower = null;
            this.tower_placed();
            this.hideRangeCircle();
         }
         else if(this.placed)
         {
            if(collidePoint(x,y,Input.mouseX,Input.mouseY))
            {
               Globals.selected_tower = this;
               this.showRangeCircle();
               Globals.addTowerMenu(this);
            }
         }
         else if(Globals.score.money < this.cost)
         {
            Globals.placing_tower = null;
            FP.world.remove(this);
         }
      }
      
      override public function mouseOver() : void
      {
         if(this.placed)
         {
            this.showRangeCircle();
         }
         this._hovering = true;
      }
      
      override public function mouseOut() : void
      {
         if(this.placed && Globals.selected_tower != this)
         {
            this.hideRangeCircle();
         }
         this._hovering = false;
      }
      
      protected function tower_placed() : void
      {
         Globals.addTower(this);
      }
      
      public function shake(d:Number) : void
      {
         this._shake = true;
         this._shake_duration = d;
         this._shake_timer = 0;
      }
      
      private function activeLoop() : void
      {
         if(this._hovering)
         {
            this._hover_timer += FP.elapsed;
         }
         else
         {
            this._hover_timer = 0;
         }
         if(this._hover_timer > 0.75 && Globals.selected_tower != this)
         {
            if(this._hoverWindow == null)
            {
               this._hoverWindow = new TowerHover(this.centerX,this.centerY,this);
               FP.world.add(this._hoverWindow);
            }
         }
         else if(this._hoverWindow != null)
         {
            FP.world.remove(this._hoverWindow);
            this._hoverWindow = null;
         }
         if(this._hovering == false && Globals.selected_tower != this)
         {
            this.hideRangeCircle();
         }
         if(this._shake)
         {
            this.hideRangeCircle();
            this._shake_timer += FP.elapsed;
            this.turret.x = this._shake_x + Globals.randRange(-2,2);
            this.turret.y = this._shake_y + Globals.randRange(-2,2);
            if(this._shake_timer > this._shake_duration)
            {
               this.showRangeCircle();
               this._shake = false;
               this.turret.x = this._shake_x;
               this.turret.y = this._shake_y;
            }
         }
         else
         {
            this.rotateTurret();
            this.shotTimer += FP.elapsed * Globals.speed;
            this.flashTimer += FP.elapsed * Globals.speed;
            if(this.target != null)
            {
               if(this.shotTimer >= 1 / this.speed)
               {
                  this.shotTimer -= 1 / this.speed;
                  this.shoot();
                  if(this.muzzle_flash != null)
                  {
                     this.muzzle_flash.alpha = 100;
                  }
                  this.flashTimer = 0;
               }
            }
            if(this.shotTimer > 1 / this.speed)
            {
               this.shotTimer = 1 / this.speed;
            }
            if(this.muzzle_flash != null)
            {
               if(this.flashTimer >= 0.05)
               {
                  this.muzzle_flash.alpha = 0;
               }
            }
            if(Input.mousePressed && !collidePoint(x,y,Input.mouseX,Input.mouseY))
            {
               this.towerDeselected();
               this.hideRangeCircle();
            }
         }
      }
      
      protected function towerDeselected() : void
      {
         if(Globals.selected_tower == this)
         {
            Globals.selected_tower = null;
         }
      }
      
      private function updateRangeCircle() : void
      {
         this.range_g.clear();
         if(this.range_visible)
         {
            this.range_g.lineStyle(1,this.range_line);
            this.range_g.beginFill(this.range_background,0.2);
            this.range_g.drawCircle(this.centerX,this.centerY,this.range);
         }
      }
      
      override public function update() : void
      {
         if(!this.placed)
         {
            this.placeLoop();
         }
         else
         {
            this.activeLoop();
         }
         this.updateRangeCircle();
         super.update();
      }
      
      public function canUpgrade() : Boolean
      {
         if(this.upgrade_to != null && Globals.score.money >= this.upgrade_cost && !this._upgraded)
         {
            return true;
         }
         return false;
      }
      
      public function upgrade(clicked:Boolean = false) : void
      {
         var t:TowerEntity = null;
         if(this.canUpgrade())
         {
            this._upgraded = true;
            SoundManager.playSound(Assets.SFX_UPGRADE);
            Globals.tracker.incrementData(Tracker.TOWERS_UPGRADED,1);
            Globals.tracker.incrementData(Tracker.MONEY_SPENT,this.upgrade_cost);
            Globals.score.money -= this.upgrade_cost;
            t = new this.upgrade_to();
            t.x = this.x;
            t.y = this.y;
            if(Boolean(t.turret) && Boolean(this.turret))
            {
               t.turret.angle = this.turret.angle;
            }
            t.target_state = this.target_state;
            t.kills = this.kills;
            Globals.removeTower(this);
            t.placed = true;
            t.tower_placed();
            t.shake(0.5);
            FP.world.add(t);
            if(Globals.selected_tower == this || clicked)
            {
               Globals.selected_tower = t;
               Globals.addTowerMenu(t);
            }
            FP.world.remove(this);
         }
      }
      
      public function setTargetState(t:String) : void
      {
         this.target_state = t;
         Globals.addTowerMenu(this);
      }
      
      public function sell() : void
      {
         if(!this.sold)
         {
            SoundManager.playSound(Assets.SFX_SELL);
            Globals.effects.emitSmoke(this.x,this.y,"bomb");
            this.sold = true;
            Globals.tracker.incrementData(Tracker.TOWERS_SOLD,1);
            if(Globals.rank <= Const.BRONZE)
               Globals.score.money += Math.floor(this.cost * 0.9);
            else if(Globals.rank <= Const.SILVER)
               Globals.score.money += Math.floor(this.cost * 0.85);
            else if(Globals.rank <= Const.GOLD)
               Globals.score.money += Math.floor(this.cost * 0.8);
            else if(Globals.rank <= Const.PLATINUM)
               Globals.score.money += Math.floor(this.cost * 0.75);
            else if(Globals.rank <= Const.DIAMOND)
               Globals.score.money += Math.floor(this.cost * 0.7);
            else
               Globals.score.money += Math.floor(this.cost * 0.65);
            Globals.map.pathGrid.getNode(this.toCol(x) + 1,this.toRow(y) + 1).hasTower = false;
            Globals.removeTower(this);
            Globals.removeTowerMenu(this);
            FP.world.remove(this);
         }
      }
      
      protected function shoot() : void
      {
         FP.world.add(Bullet.create(this.bullet,this,this.x,this.y));
      }
      
      protected function rotateTurret() : void
      {
         var dir:Number = NaN;
         var d:Number = NaN;
         var c:int = 0;
         switch(this.target_state)
         {
            case TARGET_FIRST:
               this.target = this.targetFirst();
               break;
            case TARGET_LAST:
               this.target = this.targetLast();
               break;
            case TARGET_WEAKEST:
               this.target = this.targetWeakest();
               break;
            case TARGET_STRONGEST:
               this.target = this.targetStrongest();
               break;
            case TARGET_AIR:
               this.target = this.targetAir();
         }
         if(!this.no_targetting)
         {
            if(this.target != null)
            {
               dir = Math.atan2(this.target.centerY - this.centerY,this.target.centerX - this.centerX) * 180 / Math.PI;
               this.turret.angle = -dir + 180;
               if(this.muzzle_flash != null)
               {
                  this.muzzle_flash.angle = -dir + 180;
               }
            }
            else
            {
               d = this.turret.angle;
               c = 0;
               while(d > 90)
               {
                  c++;
                  d -= 90;
               }
               if(d > 45)
               {
                  c++;
               }
               this.turret.angle = c * 90;
               if(this.muzzle_flash != null)
               {
                  this.muzzle_flash.angle = c * 90;
               }
            }
         }
      }
      
      private function targetAir() : ZombieEntity
      {
         var ground:Array = null;
         var air:Array = Globals.zombies.getFlying(this.centerX,this.centerY,this.range,false);
         if(air.length > 0)
         {
            return air[0];
         }
         if(this.ground == true)
         {
            ground = Globals.zombies.getGround(this.centerX,this.centerY,this.range,false);
            if(ground.length > 0)
            {
               return ground[0];
            }
         }
         return null;
      }
      
      private function targetFirst() : ZombieEntity
      {
         var z:ZombieEntity = null;
         var zombies:Array = Globals.zombies.getList();
         for each(z in zombies)
         {
            if(this.distance(z.centerX,z.centerY) - 10 <= this.range)
            {
               if(z.isvisible && (this.air && z.flying || this.ground && !z.flying))
               {
                  return z;
               }
            }
         }
         return null;
      }
      
      private function targetLast() : ZombieEntity
      {
         var zombies:Array = Globals.zombies.getList();
         for(var i:int = zombies.length - 1; i >= 0; i--)
         {
            if(this.distance(zombies[i].centerX,zombies[i].centerY) - 10 <= this.range)
            {
               if(Boolean(zombies[i].isvisible) && (this.air && zombies[i].flying || this.ground && !zombies[i].flying))
               {
                  return zombies[i];
               }
            }
         }
         return null;
      }
      
      private function targetWeakest() : ZombieEntity
      {
         var z:ZombieEntity = null;
         var zombies:Array = Globals.zombies.getList();
         var targ:ZombieEntity = null;
         for each(z in zombies)
         {
            if(this.distance(z.centerX,z.centerY) - 10 <= this.range)
            {
               if(z.isvisible && (this.air && z.flying || this.ground && !z.flying))
               {
                  if(targ == null || targ.health > z.health)
                  {
                     targ = z;
                  }
               }
            }
         }
         return targ;
      }
      
      private function targetStrongest() : ZombieEntity
      {
         var z:ZombieEntity = null;
         var zombies:Array = Globals.zombies.getList();
         var targ:ZombieEntity = null;
         for each(z in zombies)
         {
            if(this.distance(z.centerX,z.centerY) - 10 <= this.range)
            {
               if(z.isvisible && (this.air && z.flying || this.ground && !z.flying))
               {
                  if(targ == null || targ.health < z.health)
                  {
                     targ = z;
                  }
               }
            }
         }
         return targ;
      }
      
      protected function getZombiesInRange() : Array
      {
         return Globals.zombies.getZombies(this.centerX,this.centerY,this.range);
      }
      
      private function validLocation(x:Number, y:Number) : Boolean
      {
         var node:Node = null;
         try
         {
            node = Globals.map.pathGrid.getNode(this.toCol(x) + 1,this.toRow(y) + 1);
            if(!node.walkable && !node.hasTower)
            {
               return true;
            }
         }
         catch(e:Error)
         {
            return false;
         }
         return false;
      }
      
      private function toRow(y:Number) : int
      {
         if(this.y >= 0 && this.y <= 480)
         {
            return Math.floor(y / Const.TILE_HEIGHT);
         }
         return -1;
      }
      
      private function toCol(x:Number) : int
      {
         if(this.x >= 0 && this.x <= 480)
         {
            return Math.floor(x / Const.TILE_WIDTH);
         }
         return -1;
      }
      
      public function distance(tx:Number, ty:Number) : Number
      {
         var dx:Number = this.centerX - tx;
         var dy:Number = this.centerY - ty;
         return Math.sqrt(dx * dx + dy * dy);
      }
      
      public function hideRangeCircle() : void
      {
         this.range_visible = false;
      }
      
      public function showRangeCircle() : void
      {
         this.range_visible = true;
      }
      
      public function hideHoverWindow() : void
      {
         if(Boolean(this._hoverWindow))
         {
            FP.world.remove(this._hoverWindow);
         }
         this._hover_timer = 0;
         this._hovering = false;
      }
      
      public function setRangeRed() : void
      {
         this.range_line = 16711680;
         this.range_background = 16764108;
      }
      
      private function setRangeBlue() : void
      {
         this.range_line = 26367;
         this.range_background = 10092543;
      }
      
      public function getUID() : String
      {
         return UIDUtil.getUID(this);
      }
   }
}

