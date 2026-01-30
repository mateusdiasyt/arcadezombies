package entities
{
   import achievements.Tracker;
   import bit101.Node;
   import entities.effects.Effect;
   import entities.effects.Flame;
   import entities.effects.SnowFlake;
   import entities.menu.ZombieInfoMenu;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Graphiclist;
   import net.flashpunk.graphics.Image;
   import net.flashpunk.graphics.Spritemap;
   
   public class ZombieEntity extends Button
   {
      
      private var HIT_TIMER:Number = 0.4;
      
      private var path:Array = null;
      
      private var next_wp:Node = null;
      
      public var image:Spritemap = new Spritemap(Assets.GFX_ZOMBIES,30,30);
      
      public var portrait_index:int = 0;
      
      public var name:String = "Average Joe Zombie";
      
      public var health:Number = 10;
      
      public var total_health:Number = 10;
      
      public var speed:Number = 1;
      
      public var armor:Number = 0;
      
      public var flying:Boolean = false;
      
      public var invisible:Boolean = false;
      
      public var score:int = 5;
      
      public var bounty:int = 1;
      
      public var effects:Array = new Array();
      
      private var slow_percent:Number = 0;
      
      public var dead:Boolean = false;
      
      private var health_bar:Sprite = new Sprite();
      
      private var hb_g:Graphics;
      
      public var halo:Image = new Image(Assets.GFX_HALO);
      
      private var hitTimer:Number = 10;
      
      protected var hittable:Boolean = false;
      
      private var playing_hit:Boolean = false;
      
      protected var gl:Graphiclist = new Graphiclist();
      
      public var called_early:Number = 1;
      
      public var flake:SnowFlake = null;
      
      public var burn:Flame = null;
      
      public var frozen:Boolean = false;
      
      protected var level:Number = 1;
      
      public function ZombieEntity()
      {
         super();
         this.layer = Const.ZOMBIE_LAYER;
         this.type = "Zombie";
         this.gl.add(this.halo);
         this.halo.x = -2.5;
         this.halo.y = -2.5;
         this.halo.alpha = 0;
         this.path = Globals.map.path.concat().reverse();
         this.next_wp = this.path.pop();
         this.x = this.next_wp.x * Const.TILE_WIDTH - Const.TILE_WIDTH;
         this.y = this.next_wp.y * Const.TILE_HEIGHT - Const.TILE_HEIGHT;
         this.next_wp = this.path.pop();
         this.setHitbox(30,30);
         this.hb_g = this.health_bar.graphics;
         Globals.health_bars.add(this.health_bar);
      }
      
      protected function checkEffects() : void
      {
         var e:Effect = null;
         for(var i:int = this.effects.length - 1; i >= 0; i--)
         {
            e = this.effects[i] as Effect;
            if(e.slow_percent > this.slow_percent)
            {
               this.slow_percent = e.slow_percent;
            }
            if(e.checkTick(FP.elapsed * Globals.speed))
            {
               if(!e.damage_at_end && e.damage > 0)
               {
                  this.hit(e.damage,e.tower,false,e.ignoreArmor);
               }
            }
            if(e.expired())
            {
               if(e.damage_at_end && e.damage > 0)
               {
                  this.hit(e.damage,e.tower,true,e.ignoreArmor);
               }
               this.effects.splice(i,1);
               if(e.type != Effect.ICE)
               {
                  if(e.type == Effect.FIRE)
                  {
                     this.removeFlame();
                  }
               }
            }
         }
      }
      
      override public function update() : void
      {
         if(this.hitTimer <= this.HIT_TIMER)
         {
            this.hitTimer += FP.elapsed;
         }
         this.slow_percent = 0;
         this.checkEffects();
         if(this.hitTimer < this.HIT_TIMER && this.hittable && !this.playing_hit)
         {
            this.playing_hit = true;
            if(Math.random() < 0.5)
            {
               if(this.frozen)
               {
                  this.image.play(Const.FROZEN_HIT1);
               }
               else
               {
                  this.image.play(Const.HIT1);
               }
            }
            else if(this.frozen)
            {
               this.image.play(Const.FROZEN_HIT2);
            }
            else
            {
               this.image.play(Const.HIT2);
            }
         }
         else if(this.hitTimer > this.HIT_TIMER && this.playing_hit)
         {
            this.playing_hit = false;
            if(this.frozen)
            {
               this.image.play(Const.FROZEN_WALK);
            }
            else
            {
               this.image.play(Const.WALK);
            }
         }
         var rads:Number = Math.atan2(this.next_wp.y * Const.TILE_HEIGHT - this.y - Const.TILE_HEIGHT,this.next_wp.x * Const.TILE_WIDTH - this.x - Const.TILE_WIDTH);
         var degr:Number = rads * 180 / Math.PI;
         this.image.angle = -degr;
         var move_amount:Number = this.speed * Globals.speed * FP.elapsed;
         this.x += Math.cos(rads) * move_amount * (1 - this.slow_percent);
         this.y += Math.sin(rads) * move_amount * (1 - this.slow_percent);
         if(this.distanceToWP() < move_amount)
         {
            if(this.path.length > 0)
            {
               this.next_wp = this.path.pop();
            }
            else
            {
               this.reachedEnd();
            }
         }
         this.updateHealthBar();
         if(this.halo.alpha != 0 && Globals.zombie_info.target != this)
         {
            this.halo.alpha = 0;
         }
         super.update();
      }
      
      private function updateHealthBar() : void
      {
         var w:Number = NaN;
         if(this.health < this.total_health)
         {
            this.hb_g.clear();
            w = this.health / this.total_health * 30;
            if(this.health / this.total_health > 0.5)
            {
               this.hb_g.beginFill(65280);
            }
            else if(this.health / this.total_health > 0.25)
            {
               this.hb_g.beginFill(16776960);
            }
            else
            {
               this.hb_g.beginFill(16711680);
            }
            this.hb_g.drawRect(this.x,this.y + 30,w,3);
            this.hb_g.endFill();
         }
      }
      
      override public function clickAction() : void
      {
         if(Globals.zombie_info == null)
         {
            Globals.zombie_info = new ZombieInfoMenu(this);
         }
         else
         {
            Globals.zombie_info.reset(this);
         }
         FP.world.add(Globals.zombie_info);
         this.halo.alpha = 1;
      }
      
      public function addEffect(e:Effect) : void
      {
         var eff:Effect = null;
         var add_effect:Boolean = true;
         for each(eff in this.effects)
         {
            if(e.type == eff.type)
            {
               eff.resolve(e);
               e = eff;
               add_effect = false;
               break;
            }
         }
         switch(e.type)
         {
            case Effect.FIRE:
               this.addFlame(e.duration);
               Globals.tracker.incrementData(Tracker.ZOMBIES_BURNED,1);
               break;
            case Effect.ICE:
               this.addFlake(e.duration);
               Globals.tracker.incrementData(Tracker.ZOMBIES_FROZEN,1);
               break;
            case Effect.STUN:
               Globals.tracker.incrementData(Tracker.ZOMBIES_STUNNED,1);
         }
         if(add_effect && Boolean(this.effects))
         {
            this.effects.push(e);
         }
      }
      
      public function hit(damage:Number, tower:TowerEntity, causesHit:Boolean = true, ignoreArmor:Boolean = false) : void
      {
         if(!this.dead)
         {
            if(!ignoreArmor)
            {
               damage -= this.armor;
               if(damage < 1)
               {
                  damage = 1;
               }
            }
            this.health -= damage;
            if(causesHit && this.health > 0)
            {
               this.hitTimer = 0;
               Globals.effects.emitSplatter(this.centerX - 15,this.centerY - 15);
               switch(int(Math.random() * 2))
               {
                  case 0:
                     SoundManager.playSound(Assets.SFX_HIT_1);
                     break;
                  case 1:
                     SoundManager.playSound(Assets.SFX_HIT_2);
               }
            }
            else if(causesHit)
            {
               Globals.effects.emitSplatter(this.centerX - 15,this.centerY - 15);
            }
            if(this.health <= 0)
            {
               ++tower.kills;
               this.killed();
            }
         }
      }
      
      override public function removed() : void
      {
         Globals.health_bars.remove(this.health_bar);
         if(Boolean(Globals.zombie_info) && Globals.zombie_info.target == this)
         {
            FP.world.remove(Globals.zombie_info);
            Globals.zombie_info.target = null;
         }
         Globals.zombies.remove(this);
         this.image = null;
         this.halo = null;
         this.effects = null;
         this.flake = null;
         this.burn = null;
         this.gl = null;
         this.graphic = null;
         super.removed();
      }
      
      public function killed() : void
      {
         this.dead = true;
         this.playDeathSound();
         Globals.score.score += this.score * this.called_early;
         Globals.score.money += this.bounty;
         FP.world.add(ValuePopEntity.create(this.bounty,centerX,centerY));
         Globals.splatter.splat(centerX,centerY);
         Globals.tracker.incrementData(Tracker.ZOMBIES_KILLED,1);
         Globals.tracker.incrementData(Tracker.MONEY_EARNED,this.bounty);
         FP.world.remove(this);
      }
      
      public function playDeathSound() : void
      {
         SoundManager.playSound(Assets.SFX_GROWL_MALE);
      }
      
      private function reachedEnd() : void
      {
         this.dead = true;
         SoundManager.playSound(Assets.SFX_LOST_LIFE);
         --Globals.score.lives;
         if(Globals.score.lives < 0)
         {
            Globals.score.lives = 0;
         }
         FP.world.remove(this);
         if(Globals.score.lives <= 0)
         {
            Globals.lose();
         }
      }
      
      public function get isvisible() : Boolean
      {
         return true;
      }
      
      public function addFlame(duration:Number) : void
      {
         if(this.burn != null)
         {
            this.burn.refresh(duration);
         }
         else
         {
            this.burn = new Flame(this,duration);
            FP.world.add(this.burn);
         }
      }
      
      public function removeFlame() : void
      {
         if(Boolean(this.burn))
         {
            FP.world.remove(this.burn);
            this.burn = null;
         }
      }
      
      public function addFlake(duration:Number) : void
      {
         if(this.flake != null)
         {
            this.flake.refresh(duration);
         }
         else
         {
            this.flake = new SnowFlake(this,duration);
            FP.world.add(this.flake);
         }
         if(Boolean(this.image))
         {
            this.image.play(Const.FROZEN_WALK);
         }
         this.frozen = true;
      }
      
      public function removeFlake() : void
      {
         if(Boolean(this.flake))
         {
            FP.world.remove(this.flake);
            this.flake = null;
         }
         if(Boolean(this.image))
         {
            this.image.play(Const.WALK);
         }
         this.frozen = false;
      }
      
      public function get burning() : Boolean
      {
         var e:Effect = null;
         for each(e in this.effects)
         {
            if(e.type == Effect.FIRE)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get stunned() : Boolean
      {
         var e:Effect = null;
         for each(e in this.effects)
         {
            if(e.type == Effect.STUN)
            {
               return true;
            }
         }
         return false;
      }
      
      private function distanceToWP() : Number
      {
         var dx:Number = this.next_wp.x * Const.TILE_WIDTH - this.x - Const.TILE_WIDTH;
         var dy:Number = this.next_wp.y * Const.TILE_HEIGHT - this.y - Const.TILE_HEIGHT;
         return Math.sqrt(dx * dx + dy * dy);
      }
      
      public function get distanceToEnd() : Number
      {
         return this.distanceToWP() + this.path.length * Const.TILE_WIDTH;
      }
      
      override public function toString() : String
      {
         return "ZombieEntity : " + this.distanceToEnd;
      }
      
      public function getClass() : Class
      {
         return Class(getDefinitionByName(getQualifiedClassName(this)));
      }
   }
}

