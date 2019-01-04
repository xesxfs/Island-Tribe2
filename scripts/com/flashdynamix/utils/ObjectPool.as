package com.flashdynamix.utils
{
   public class ObjectPool
   {
       
      
      public var minSize:int;
      
      public var size:int = 0;
      
      public var Create:Class;
      
      public var length:int = 0;
      
      private var list:Array;
      
      private var disposed:Boolean = false;
      
      public function ObjectPool(param1:Class, param2:int = 10)
      {
         this.list = [];
         super();
         this.Create = param1;
         this.minSize = param2;
         var _loc3_:int = 0;
         while(_loc3_ < param2)
         {
            this.add();
            _loc3_++;
         }
      }
      
      public function add() : void
      {
         var _loc1_:* = this.length++;
         this.list[_loc1_] = new this.Create();
         this.size++;
      }
      
      public function checkOut() : *
      {
         if(this.length == 0)
         {
            this.size++;
            return new this.Create();
         }
         return this.list[--this.length];
      }
      
      public function checkIn(param1:*) : void
      {
         var _loc2_:* = this.length++;
         this.list[_loc2_] = param1;
      }
      
      public function empty() : void
      {
         this.size = this.length = this.list.length = 0;
      }
      
      public function dispose() : void
      {
         if(this.disposed)
         {
            return;
         }
         this.disposed = true;
         this.Create = null;
         this.list = null;
      }
   }
}
