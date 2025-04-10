package svera.untiered.messaging.impl.data
{
   import flash.utils.ByteArray;
import flash.utils.IDataInput;

public class MarketData
   {
      public var id_:int;
      public var itemType_:Number;
      public var itemData_:ByteArray;
      public var sellerName_:String;
      public var sellerId_:int;
      public var currency_:int;
      public var price_:int;
      public var startTime_:int;
      public var timeLeft_:int;

      public function MarketData()
      {
         super();
         itemData_ = new ByteArray();
         itemData_.endian = "littleEndian";
      }
      
      public function parseFromInput(data:IDataInput) : void
      {
         itemData_.length = itemData_.position = 0;
         this.id_ = data.readInt();
         this.itemType_ = data.readUnsignedShort();
         this.sellerName_ = data.readUTF();
         this.sellerId_ = data.readInt();
         this.currency_ = data.readInt();
         this.price_ = data.readInt();
         this.startTime_ = data.readInt();
         this.timeLeft_ = data.readInt();
         var len:int = data.readUnsignedShort();
         data.readBytes(itemData_, 0, len);
      }
   }
}
