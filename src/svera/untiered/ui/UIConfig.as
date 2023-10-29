package svera.untiered.ui
{
   import com.company.assembleegameclient.mapeditor.MapEditor;
   import com.company.assembleegameclient.screens.AccountScreen;
   import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
   import com.company.assembleegameclient.screens.NewsLine;
   import com.company.assembleegameclient.screens.LoadingScreen;
   import com.company.assembleegameclient.screens.NewCharacterScreen;
   import com.company.assembleegameclient.screens.charrects.CharacterRectList;
   import com.company.assembleegameclient.screens.charrects.CurrentCharacterRect;
   import com.company.assembleegameclient.ui.dialogs.ErrorDialog;
   import com.company.assembleegameclient.ui.menu.PlayerGroupMenu;
   import com.company.assembleegameclient.ui.panels.InteractPanel;
   import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
   import com.company.assembleegameclient.ui.panels.mediators.InteractPanelMediator;
   import com.company.assembleegameclient.ui.panels.mediators.ItemGridMediator;
   import svera.untiered.account.core.services.GetCharListTask;
   import svera.untiered.account.core.services.LoadAccountTask;
   import svera.untiered.account.core.view.AccountInfoMediator;
   import svera.untiered.account.core.view.AccountInfoView;
   import svera.untiered.account.core.view.RegisterPromptDialog;
   import svera.untiered.account.core.view.RegisterPromptDialogMediator;
import svera.untiered.game.model.PotionInventoryModel;
import svera.untiered.startup.control.StartupSequence;
   import svera.untiered.ui.commands.EnterGameCommand;
   import svera.untiered.ui.commands.HUDInitCommand;
   import svera.untiered.ui.commands.ShowLoadingUICommand;
   import svera.untiered.ui.commands.ShowTitleUICommand;
   import svera.untiered.ui.model.HUDModel;
   import svera.untiered.ui.signals.EnterGameSignal;
   import svera.untiered.ui.signals.HUDModelInitialized;
   import svera.untiered.ui.signals.HUDSetupStarted;
   import svera.untiered.ui.signals.NameChangedSignal;
   import svera.untiered.ui.signals.ShowLoadingUISignal;
   import svera.untiered.ui.signals.ShowTitleUISignal;
import svera.untiered.ui.signals.StatsTabHotKeyInputSignal;
import svera.untiered.ui.signals.UpdateBackpackTabSignal;
import svera.untiered.ui.signals.UpdateHUDSignal;
import svera.untiered.ui.signals.UpdatePotionInventorySignal;
import svera.untiered.ui.view.AccountScreenMediator;
   import svera.untiered.ui.view.CharacterDetailsMediator;
   import svera.untiered.ui.view.CharacterDetailsView;
   import svera.untiered.ui.view.CharacterRectListMediator;
   import svera.untiered.ui.view.CharacterSlotNeedTsavoriteDialog;
   import svera.untiered.ui.view.CharacterSlotNeedTsavoriteMediator;
   import svera.untiered.ui.view.CharacterSlotRegisterDialog;
   import svera.untiered.ui.view.CharacterSlotRegisterMediator;
   import svera.untiered.ui.view.ChooseNameRegisterDialog;
   import svera.untiered.ui.view.ChooseNameRegisterMediator;
   import svera.untiered.ui.view.CurrentCharacterMediator;
   import svera.untiered.ui.view.CurrentCharacterRectMediator;
   import svera.untiered.ui.view.ErrorDialogMediator;
import svera.untiered.ui.view.MessageCloseDialog;
import svera.untiered.ui.view.MessageCloseMediator;
import svera.untiered.ui.view.HUDMediator;
   import svera.untiered.ui.view.HUDView;
   import svera.untiered.ui.view.LoadingMediator;
   import svera.untiered.ui.view.MapEditorMediator;
   import svera.untiered.ui.view.NewCharacterMediator;
   import svera.untiered.ui.view.NewsLineMediator;
   import svera.untiered.ui.view.NotEnoughTsavoriteDialog;
   import svera.untiered.ui.view.NotEnoughTsavoriteMediator;
   import svera.untiered.ui.view.StatMetersMediator;
   import svera.untiered.ui.view.StatMetersView;
   import svera.untiered.ui.view.TitleMediator;
   import svera.untiered.ui.view.TitleView;
import svera.untiered.ui.view.components.PotionSlotMediator;
import svera.untiered.ui.view.components.PotionSlotView;

import org.swiftsuspenders.Injector;
   import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
   import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
   import robotlegs.bender.framework.api.IConfig;
   
   public class UIConfig implements IConfig
   {
       
      
      [Inject]
      public var injector:Injector;
      
      [Inject]
      public var mediatorMap:IMediatorMap;
      
      [Inject]
      public var commandMap:ISignalCommandMap;
      
      [Inject]
      public var startup:StartupSequence;
      
      public function UIConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.injector.map(NameChangedSignal).asSingleton();
         this.injector.map(PotionInventoryModel).asSingleton();
         this.injector.map(UpdatePotionInventorySignal).asSingleton();
         this.injector.map(UpdateBackpackTabSignal).asSingleton();
         this.injector.map(StatsTabHotKeyInputSignal).asSingleton();
         this.commandMap.map(ShowLoadingUISignal).toCommand(ShowLoadingUICommand);
         this.commandMap.map(ShowTitleUISignal).toCommand(ShowTitleUICommand);
         this.commandMap.map(EnterGameSignal).toCommand(EnterGameCommand);
         this.mediatorMap.map(LoadingScreen).toMediator(LoadingMediator);
         this.mediatorMap.map(CharacterSelectionAndNewsScreen).toMediator(CurrentCharacterMediator);
         this.mediatorMap.map(AccountInfoView).toMediator(AccountInfoMediator);
         this.mediatorMap.map(AccountScreen).toMediator(AccountScreenMediator);
         this.mediatorMap.map(TitleView).toMediator(TitleMediator);
         this.mediatorMap.map(NewCharacterScreen).toMediator(NewCharacterMediator);
         this.mediatorMap.map(MapEditor).toMediator(MapEditorMediator);
         this.mediatorMap.map(CurrentCharacterRect).toMediator(CurrentCharacterRectMediator);
         this.mediatorMap.map(CharacterRectList).toMediator(CharacterRectListMediator);
         this.mediatorMap.map(ErrorDialog).toMediator(ErrorDialogMediator);
         this.mediatorMap.map(NewsLine).toMediator(NewsLineMediator);
         this.mediatorMap.map(NotEnoughTsavoriteDialog).toMediator(NotEnoughTsavoriteMediator);
         this.mediatorMap.map(MessageCloseDialog).toMediator(MessageCloseMediator);
         this.mediatorMap.map(InteractPanel).toMediator(InteractPanelMediator);
         this.mediatorMap.map(ItemGrid).toMediator(ItemGridMediator);
         this.mediatorMap.map(ChooseNameRegisterDialog).toMediator(ChooseNameRegisterMediator);
         this.mediatorMap.map(CharacterSlotRegisterDialog).toMediator(CharacterSlotRegisterMediator);
         this.mediatorMap.map(RegisterPromptDialog).toMediator(RegisterPromptDialogMediator);
         this.mediatorMap.map(CharacterSlotNeedTsavoriteDialog).toMediator(CharacterSlotNeedTsavoriteMediator);
         this.mediatorMap.map(PlayerGroupMenu).toMediator(PlayerGroupMenuMediator);
         this.mediatorMap.map(StatMetersView).toMediator(StatMetersMediator);
         this.mediatorMap.map(HUDView).toMediator(HUDMediator);
         this.mediatorMap.map(PotionSlotView).toMediator(PotionSlotMediator);
         this.setupCharacterWindow();
         this.startup.addSignal(ShowLoadingUISignal,-1);
         this.startup.addTask(LoadAccountTask);
         this.startup.addTask(GetCharListTask);
         this.startup.addSignal(ShowTitleUISignal,StartupSequence.LAST);
      }
      
      private function setupCharacterWindow() : void
      {
         this.injector.map(HUDModel).asSingleton();
         this.injector.map(UpdateHUDSignal).asSingleton();
         this.injector.map(HUDModelInitialized).asSingleton();
         this.commandMap.map(HUDSetupStarted).toCommand(HUDInitCommand);
         this.mediatorMap.map(CharacterDetailsView).toMediator(CharacterDetailsMediator);
      }
   }
}
