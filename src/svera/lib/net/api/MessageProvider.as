package svera.lib.net.api
{
   import svera.lib.net.impl.Message;
   
   public interface MessageProvider
   {
       
      
      function require(param1:int) : Message;
   }
}
