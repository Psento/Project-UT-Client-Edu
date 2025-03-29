package svera.untiered.raidLauncher {

import flash.events.MouseEvent;

import org.swiftsuspenders.Injector;

import robotlegs.bender.bundles.mvcs.Mediator;

import svera.lib.net.api.MessageProvider;
import svera.lib.net.impl.SocketServer;
import svera.untiered.dialogs.control.CloseDialogsSignal;
import svera.untiered.dialogs.control.OpenDialogSignal;
import svera.untiered.game.signals.AddTextLineSignal;
import svera.untiered.messaging.impl.GameServerConnection;
import svera.untiered.messaging.impl.outgoing.LaunchRaid;

public class RaidLauncherMediator extends Mediator {


    [Inject]
    public var injector:Injector;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var socketServer:SocketServer;
    [Inject]
    public var messages:MessageProvider;
    [Inject]
    public var view:RaidLauncherModal;
    [Inject]
    public var openNoModalDialog:OpenDialogSignal;
    [Inject]
    public var addTextLine:AddTextLineSignal;


    override public function initialize():void {
        this.view.launchButton.addEventListener(MouseEvent.CLICK, this.onButtonLaunch);
        this.view.launchButton2.addEventListener(MouseEvent.CLICK, this.onButtonLaunch2);
        this.view.launchButton3.addEventListener(MouseEvent.CLICK, this.onButtonLaunch3);
    }

    override public function destroy():void {
        super.destroy();
    }

    protected function onButtonLaunch(_arg_1:MouseEvent):void {
        var _local_1:LaunchRaid;
        _local_1 = (this.messages.require(GameServerConnection.LAUNCH_RAID) as LaunchRaid);
        _local_1.raidId_ = 1;
        this.socketServer.sendMessage(_local_1);
        this.closeDialogs.dispatch()
    }

    protected function onButtonLaunch2(_arg_1:MouseEvent):void {
        var _local_1:LaunchRaid;
        _local_1 = (this.messages.require(GameServerConnection.LAUNCH_RAID) as LaunchRaid);
        _local_1.raidId_ = 2;
        this.socketServer.sendMessage(_local_1);
        this.closeDialogs.dispatch()
    }

    protected function onButtonLaunch3(_arg_1:MouseEvent):void {
        var _local_1:LaunchRaid;
        _local_1 = (this.messages.require(GameServerConnection.LAUNCH_RAID) as LaunchRaid);
        _local_1.raidId_ = 3;
        this.socketServer.sendMessage(_local_1);
        this.closeDialogs.dispatch()
    }


}
}//package kabam.rotmg.pets.view.components
