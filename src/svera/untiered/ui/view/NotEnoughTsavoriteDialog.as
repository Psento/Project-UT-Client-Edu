package svera.untiered.ui.view
{
import com.company.assembleegameclient.ui.dialogs.Dialog;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class NotEnoughTsavoriteDialog extends Dialog
   {
      
      private static const TEXT:String = "You do not have enough Tsavorite for this item.";
      
      private static const TITLE:String = "Not Enough Tsavorite";
      
      private static const CANCEL:String = "Cancel";
       
      
      public var cancel:Signal;
      
      public function NotEnoughTsavoriteDialog(message:String = "")
      {
         var text:String = message == ""?TEXT:message;
         super(text,TITLE,CANCEL, null);
         this.cancel = new NativeMappedSignal(this,BUTTON1_EVENT);
      }
   }
}
