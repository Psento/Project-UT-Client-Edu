package svera.untiered.account.web.view
{
import com.company.assembleegameclient.account.ui.Frame;

import flash.events.MouseEvent;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class WebQuitDialog extends Frame
   {
      public var cancel:Signal;
      public var quit:Signal;
      
      public function WebQuitDialog()
      {
         super("Would you like to quit?","Yes","No");
         this.cancel = new NativeMappedSignal(rightButton_,MouseEvent.CLICK);
         this.quit = new NativeMappedSignal(leftButton_,MouseEvent.CLICK);
      }
   }
}
