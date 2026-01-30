package bit101
{
   public class AStar
   {
      
      private var _open:Array;
      
      private var _closed:Array;
      
      private var _grid:Grid;
      
      private var _endNode:Node;
      
      private var _startNode:Node;
      
      private var _path:Array;
      
      private var _heuristic:Function;
      
      private var _straightCost:Number = 1;
      
      private var _diagCost:Number = 1.4142135623730951;
      
      public function AStar()
      {
         this._heuristic = this.diagonal;
         super();
      }
      
      public function findPath(grid:Grid) : Boolean
      {
         this._grid = grid;
         this._open = new Array();
         this._closed = new Array();
         this._startNode = this._grid.startNode;
         this._endNode = this._grid.endNode;
         this._startNode.g = 0;
         this._startNode.h = this._heuristic(this._startNode);
         this._startNode.f = this._startNode.g + this._startNode.h;
         return this.search();
      }
      
      public function search() : Boolean
      {
         var startX:int = 0;
         var endX:int = 0;
         var startY:int = 0;
         var endY:int = 0;
         var i:int = 0;
         var o:int = 0;
         var j:int = 0;
         var test:Node = null;
         var cost:Number = NaN;
         var g:Number = NaN;
         var h:Number = NaN;
         var f:Number = NaN;
         var node:Node = this._startNode;
         while(node != this._endNode)
         {
            startX = Math.max(0,node.x - 1);
            endX = Math.min(this._grid.numCols - 1,node.x + 1);
            startY = Math.max(0,node.y - 1);
            endY = Math.min(this._grid.numRows - 1,node.y + 1);
            for(i = startX; i <= endX; i++)
            {
               for(j = startY; j <= endY; j++)
               {
                  test = this._grid.getNode(i,j);
                  if(!(test == node || !test.walkable || !this._grid.getNode(node.x,test.y).walkable || !this._grid.getNode(test.x,node.y).walkable))
                  {
                     cost = this._straightCost;
                     if(!(node.x == test.x || node.y == test.y))
                     {
                        cost = this._diagCost;
                     }
                     g = node.g + cost * test.costMultiplier;
                     h = this._heuristic(test);
                     f = g + h;
                     if(this.isOpen(test) || this.isClosed(test))
                     {
                        if(test.f > f)
                        {
                           test.f = f;
                           test.g = g;
                           test.h = h;
                           test.parent = node;
                        }
                     }
                     else
                     {
                        test.f = f;
                        test.g = g;
                        test.h = h;
                        test.parent = node;
                        this._open.push(test);
                     }
                  }
               }
            }
            for(o = 0; o < this._open.length; o++)
            {
            }
            this._closed.push(node);
            if(this._open.length == 0)
            {
               trace("no path found");
               return false;
            }
            this._open.sortOn("f",Array.NUMERIC);
            node = this._open.shift() as Node;
         }
         this.buildPath();
         return true;
      }
      
      private function buildPath() : void
      {
         this._path = new Array();
         var node:Node = this._endNode;
         this._path.push(node);
         while(node != this._startNode)
         {
            node = node.parent;
            this._path.unshift(node);
         }
      }
      
      public function get path() : Array
      {
         return this._path;
      }
      
      private function isOpen(node:Node) : Boolean
      {
         for(var i:int = 0; i < this._open.length; i++)
         {
            if(this._open[i] == node)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isClosed(node:Node) : Boolean
      {
         for(var i:int = 0; i < this._closed.length; i++)
         {
            if(this._closed[i] == node)
            {
               return true;
            }
         }
         return false;
      }
      
      private function manhattan(node:Node) : Number
      {
         return Math.abs(node.x - this._endNode.x) * this._straightCost + Math.abs(node.y + this._endNode.y) * this._straightCost;
      }
      
      private function euclidian(node:Node) : Number
      {
         var dx:Number = node.x - this._endNode.x;
         var dy:Number = node.y - this._endNode.y;
         return Math.sqrt(dx * dx + dy * dy) * this._straightCost;
      }
      
      private function diagonal(node:Node) : Number
      {
         var dx:Number = Math.abs(node.x - this._endNode.x);
         var dy:Number = Math.abs(node.y - this._endNode.y);
         var diag:Number = Math.min(dx,dy);
         var straight:Number = dx + dy;
         return this._diagCost * diag + this._straightCost * (straight - 2 * diag);
      }
      
      public function get visited() : Array
      {
         return this._closed.concat(this._open);
      }
   }
}

