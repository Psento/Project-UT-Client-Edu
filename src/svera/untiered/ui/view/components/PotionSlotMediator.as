package svera.untiered.ui.view.components {
import com.company.assembleegameclient.objects.Player;

import svera.lib.framework.Mediator;

import svera.untiered.game.model.PotionInventoryModel;
import svera.untiered.game.model.UsePotionVO;
import svera.untiered.game.signals.UsePotionSignal;
import svera.untiered.ui.model.HUDModel;
import svera.untiered.ui.model.PotionModel;
import svera.untiered.ui.signals.UpdateHUDSignal;

public class PotionSlotMediator extends Mediator {


    [Inject]
    public var view:PotionSlotView;

    [Inject]
    public var hudModel:HUDModel;

    [Inject]
    public var updateHUD:UpdateHUDSignal;

    [Inject]
    public var potionInventoryModel:PotionInventoryModel;

    [Inject]
    public var usePotionSignal:UsePotionSignal;

    public function PotionSlotMediator() {
        super();
    }

    override public function initialize():void {
        this.updateHUD.addOnce(this.initializeData);
        //this.view.drop.add(this.onDrop);
        this.view.buyUse.add(this.onBuyUse);
        this.updateHUD.add(this.update);
    }

    override public function destroy():void {
        //this.view.drop.remove(this.onDrop);
        this.view.buyUse.remove(this.onBuyUse);
        this.updateHUD.remove(this.update);
    }

    private function initializeData(player:Player):void {
        var potionModel:PotionModel = this.potionInventoryModel.potionModels[this.view.position];
        var count:int = player.getPotionCount(potionModel.objectId);
        this.view.setData(count, potionModel.available, potionModel.objectId);
    }

    private function update(player:Player):void {
        var potModel:PotionModel = null;
        var count:int = 0;
        if (this.view.objectType == PotionInventoryModel.HEALTH_POTION_ID || this.view.objectType == PotionInventoryModel.MAGIC_POTION_ID) {
            potModel = this.potionInventoryModel.getPotionModel(this.view.objectType);
            count = player.getPotionCount(potModel.objectId);
            this.view.setData(count, potModel.available);
        }
    }

    /*private function onDrop(targetDO:DisplayObject) : void
    {
       var tile:InteractiveItemTile = null;
       var player:Player = this.hudModel.gameSprite.map.player_;
       var target:* = DisplayHierarchy.getParentWithTypeArray(targetDO,InteractiveItemTile,Map);
       if(target is Map || Parameters.GPURenderFrame && target == null)
       {
          GameServerConnection.instance.invDrop(player,PotionInventoryModel.getPotionSlot(this.view.objectType),this.view.objectType);
       }
       else if(target is InteractiveItemTile)
       {
          tile = target as InteractiveItemTile;
          if(tile.getItemId() == ItemConstants.NO_ITEM && tile.ownerGrid.owner != player)
          {
             GameServerConnection.instance.invSwapPotion(player,player,PotionInventoryModel.getPotionSlot(this.view.objectType),this.view.objectType,tile.ownerGrid.owner,tile.tileId,ItemConstants.NO_ITEM);
          }
       }
    }*/

    private function onBuyUse():void {
        var vo:UsePotionVO = null;
        var potModel:PotionModel = this.potionInventoryModel.potionModels[this.view.position];
        if (potModel.available) {
            vo = new UsePotionVO(potModel.objectId, UsePotionVO.SHIFTCLICK);
            this.usePotionSignal.dispatch(vo);
        }
    }
}
}
