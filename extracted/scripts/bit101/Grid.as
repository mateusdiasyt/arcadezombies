package bit101
{
   public class Grid
   {
      
      private var _startNode:Node;
      
      private var _endNode:Node;
      
      private var _nodes:Array;
      
      private var _numCols:int;
      
      private var _numRows:int;
      
      public function Grid(numCols:int, numRows:int)
      {
         var j:int = 0;
         super();
         this._numCols = numCols;
         this._numRows = numRows;
         this._nodes = new Array();
         for(var i:int = 0; i < this._numCols; i++)
         {
            this._nodes[i] = new Array();
            for(j = 0; j < this._numRows; j++)
            {
               this._nodes[i][j] = new Node(i,j);
            }
         }
      }
      
      public function getNode(x:int, y:int) : Node
      {
         return this._nodes[x][y] as Node;
      }
      
      public function setEndNode(x:int, y:int) : void
      {
         this._endNode = this._nodes[x][y] as Node;
      }
      
      public function setStartNode(x:int, y:int) : void
      {
         this._startNode = this._nodes[x][y] as Node;
      }
      
      public function setWalkable(x:int, y:int, value:Boolean) : void
      {
         this._nodes[x][y].walkable = value;
      }
      
      public function setTower(x:int, y:int, value:Boolean) : void
      {
         this._nodes[x][y].hasTower = value;
      }
      
      public function get endNode() : Node
      {
         return this._endNode;
      }
      
      public function get numCols() : int
      {
         return this._numCols;
      }
      
      public function get numRows() : int
      {
         return this._numRows;
      }
      
      public function get startNode() : Node
      {
         return this._startNode;
      }
   }
}

