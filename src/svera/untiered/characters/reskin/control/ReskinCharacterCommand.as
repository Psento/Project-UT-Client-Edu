package svera.untiered.characters.reskin.control {
import svera.lib.net.api.MessageProvider;
import svera.lib.net.impl.SocketServer;
import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.messaging.impl.GameServerConnection;
import svera.untiered.messaging.impl.outgoing.Reskin;

public class ReskinCharacterCommand {


    [Inject]
    public var skin:CharacterSkin;

    [Inject]
    public var messages:MessageProvider;

    [Inject]
    public var server:SocketServer;

    public function ReskinCharacterCommand() {
        super();
    }

    public function execute():void {
        var reskin:Reskin = this.messages.require(GameServerConnection.RESKIN) as Reskin;
        reskin.skinID = this.skin.id;
        this.server.sendMessage(reskin);
    }
}
}
