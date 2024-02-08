package svera.untiered.account.web.view
{
   import com.company.assembleegameclient.account.ui.Frame;
   import com.company.assembleegameclient.ui.ClickableText;
   import com.company.ui.SimpleText;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
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
