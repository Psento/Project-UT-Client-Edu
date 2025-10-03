/**
 * Created by cp-nilly on 6/9/2017.
 */
package svera.untiered.messaging.impl.incoming {
import flash.utils.IDataInput;

public class SetFocus extends IncomingMessage {
    public var objectId_:int;

    public function SetFocus(id:uint, callback:Function) {
        super(id, callback);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.objectId_ = _arg1.readInt();
    }

    override public function toString():String {
        return formatToString("SET_FOCUS", "objectId_");
    }


}
}

