package com.flashdynamix.utils
{
   import flash.utils.Dictionary;
   
   public class MultiTypeObjectPool
   {
       
      
      public var pools:Dictionary;
      
      private var disposed:Boolean = false;
      
      public function MultiTypeObjectPool(... rest)
      {
         super();
         this.pools = new Dictionary(true);
         var _loc2_:int = rest.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.add(rest[_loc3_]);
            _loc3_++;
         }
      }
      
      public function add(param1:Class) : void
      {
         this.pools[param1] = new ObjectPool(param1);
      }
      
      public function checkOut(param1:Class) : *
      {
         return ObjectPool(this.pools[param1]).checkOut();
      }
      
      public function checkIn(param1:Object) : void
      {
         ObjectPool(this.pools[param1.constructor]).checkIn(param1);
      }
      
      public function empty() : void
      {
         var _loc1_:ObjectPool = null;
         for each(_loc1_ in this.pools)
         {
            _loc1_.empty();
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:ObjectPool = null;
         if(this.disposed)
         {
            return;
         }
         this.disposed = true;
         for each(_loc1_ in this.pools)
         {
            _loc1_.dispose();
            delete this.pools[_loc1_];
         }
         this.pools = null;
      }
   }
}
