package svera.untiered.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   import svera.untiered.messaging.impl.data.SlotObjectData;
   
   public class InvDrop extends OutgoingMessage
   {
       
      
      public var slotId_:uint;
      
      public function InvDrop(id:uint, callback:Function)
      {
         super(id,callback);
      }
      
      override public function writeToOutput(data:IDataOutput) : void
      {
         data.writeByte(slotId_);
      }
      
      override public function toString() : String
      {
         return formatToString("INVDROP","slotObject_");
      }
   }
}
