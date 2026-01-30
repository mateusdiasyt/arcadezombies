package entities
{
   import bit101.AStar;
   import bit101.Grid;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Stamp;
   import net.flashpunk.masks.Grid;
   
   public class MapEntity extends Entity
   {
      
      private var name:String = "?";
      
      private var myGrid:net.flashpunk.masks.Grid;
      
      public var pathGrid:bit101.Grid;
      
      public var path:Array = null;
      
      private var start:Point;
      
      private var end:Point;
      
      private var map_image:Stamp = null;
      
      public function MapEntity()
      {
         super();
      }
      
      public function get Name() : String
      {
         return this.name;
      }
      
      public function Load(mapName:String) : void
      {
         if(!Const.maps.hasOwnProperty(mapName))
         {
            throw new Error("The map \"" + mapName + "\" is not valid. Doublt check your call to [MapEntity].");
         }
         this.name = mapName;
         var xml:XML = new XML(new Const.maps[this.name]());
         this.myGrid = new net.flashpunk.masks.Grid(xml.width,xml.height,Const.TILE_WIDTH,Const.TILE_HEIGHT,0,0);
         this.pathGrid = new bit101.Grid(xml.width / Const.TILE_WIDTH,xml.height / Const.TILE_WIDTH);
         this.LoadTileData(xml);
         this.LoadEndPointData(xml);
         type = "map";
         layer = 10000;
         this.findPath();
         switch(mapName)
         {
            case "EasyMap":
               this.map_image = new Stamp(Assets.GFX_EASY_MAP);
               break;
            case "NormalMap":
               this.map_image = new Stamp(Assets.GFX_NORMAL_MAP);
               break;
            case "HardMap":
               this.map_image = new Stamp(Assets.GFX_HARD_MAP);
               break;
            case "InsaneMap":
               this.map_image = new Stamp(Assets.GFX_INSANE_MAP);
         }
         graphic = this.map_image;
         mask = this.myGrid;
      }
      
      private function findPath() : void
      {
         var astar:AStar = new AStar();
         this.pathGrid.setStartNode(this.start.x / Const.TILE_WIDTH,this.start.y / Const.TILE_HEIGHT);
         this.pathGrid.setEndNode(this.end.x / Const.TILE_WIDTH,this.end.y / Const.TILE_HEIGHT);
         astar.findPath(this.pathGrid);
         this.path = astar.path;
      }
      
      private function LoadTileData(xml:XML) : void
      {
         var t:XML = null;
         var column:int = 0;
         var row:int = 0;
         for each(t in xml.tiles.tile)
         {
            column = Math.floor(t.@x / Const.TILE_WIDTH);
            row = Math.floor(t.@y / Const.TILE_HEIGHT);
            this.pathGrid.setWalkable(column,row,true);
            if(!this.IsFloor(t.@id))
            {
               this.pathGrid.setWalkable(column,row,false);
            }
            if(t.@id == "2")
            {
               this.pathGrid.setTower(column,row,true);
            }
         }
      }
      
      private function LoadEndPointData(xml:XML) : void
      {
         this.start = new Point(xml.objects[0].start.@x,xml.objects[0].start.@y);
         this.end = new Point(xml.objects[0].end.@x,xml.objects[0].end.@y);
      }
      
      private function IsFloor(t:Number) : Boolean
      {
         return this.Find(t.toString(),Globals.floorTiles.split(","));
      }
      
      private function Find(searchTerm:String, list:Array) : Boolean
      {
         var item:String = null;
         for each(item in list)
         {
            if(item == searchTerm)
            {
               return true;
            }
         }
         return false;
      }
   }
}

