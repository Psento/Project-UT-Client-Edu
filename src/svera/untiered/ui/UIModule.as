package svera.untiered.ui {
import com.company.assembleegameclient.account.ui.unboxing.UnboxResultBox;
import com.company.assembleegameclient.account.ui.unboxing.UnboxResultBoxMediator;
import com.company.assembleegameclient.mapeditor.MapEditor;
import com.company.assembleegameclient.screens.AccountScreen;
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
import com.company.assembleegameclient.screens.LoadingScreen;
import com.company.assembleegameclient.screens.NewCharacterScreen;
import com.company.assembleegameclient.screens.NewsLine;
import com.company.assembleegameclient.screens.charrects.CharacterRectList;
import com.company.assembleegameclient.screens.charrects.CurrentCharacterRect;
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;
import com.company.assembleegameclient.ui.menu.PlayerGroupMenu;
import com.company.assembleegameclient.ui.panels.InteractPanel;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.assembleegameclient.ui.panels.mediators.InteractPanelMediator;
import com.company.assembleegameclient.ui.panels.mediators.ItemGridMediator;

import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;

import svera.lib.framework.IModule;

import svera.untiered.account.core.services.GetCharListTask;
import svera.untiered.account.core.services.LoadAccountTask;
import svera.untiered.account.core.view.AccountInfoMediator;
import svera.untiered.account.core.view.AccountInfoView;
import svera.untiered.account.core.view.RegisterPromptDialog;
import svera.untiered.account.core.view.RegisterPromptDialogMediator;
import svera.untiered.game.model.PotionInventoryModel;
import svera.untiered.startup.control.StartupSequence;
import svera.untiered.storage.VaultWindow;
import svera.untiered.storage.mediator.VaultWindowMediator;
import svera.untiered.storage.signals.VaultSlotUpdateSignal;
import svera.untiered.storage.signals.VaultUpdateSignal;
import svera.untiered.ui.commands.EnterGameCommand;
import svera.untiered.ui.commands.HUDInitCommand;
import svera.untiered.ui.commands.ShowLoadingUICommand;
import svera.untiered.ui.commands.ShowTitleUICommand;
import svera.untiered.ui.commands.ShowSplashUICommand;
import svera.untiered.ui.model.HUDModel;
import svera.untiered.ui.signals.EnterGameSignal;
import svera.untiered.ui.signals.HUDModelInitialized;
import svera.untiered.ui.signals.HUDSetupStarted;
import svera.untiered.ui.signals.NameChangedSignal;
import svera.untiered.ui.signals.ShowLoadingUISignal;
import svera.untiered.ui.signals.ShowTitleUISignal;
import svera.untiered.ui.signals.ShowSplashUISignal;
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
import svera.untiered.ui.view.HUDMediator;
import svera.untiered.ui.view.HUDView;
import svera.untiered.ui.view.LoadingMediator;
import svera.untiered.ui.view.MapEditorMediator;
import svera.untiered.ui.view.MessageCloseDialog;
import svera.untiered.ui.view.MessageCloseMediator;
import svera.untiered.ui.view.NewCharacterMediator;
import svera.untiered.ui.view.NewsLineMediator;
import svera.untiered.ui.view.NotEnoughTsavoriteDialog;
import svera.untiered.ui.view.NotEnoughTsavoriteMediator;
import svera.untiered.ui.view.SplashMediator;
import svera.untiered.ui.view.SplashView;
import svera.untiered.ui.view.StatMetersMediator;
import svera.untiered.ui.view.StatMetersView;
import svera.untiered.ui.view.TitleMediator;
import svera.untiered.ui.view.TitleView;
import svera.untiered.ui.view.components.PotionSlotMediator;
import svera.untiered.ui.view.components.PotionSlotView;

public class UIModule implements IModule {

    public function UIModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.injector.map(ShowSplashUISignal).asSingleton();
        context.injector.map(ShowLoadingUISignal).asSingleton();
        context.injector.map(ShowTitleUISignal).asSingleton();
        context.injector.map(EnterGameSignal).asSingleton();
        context.injector.map(HUDSetupStarted).asSingleton();
        context.injector.map(NameChangedSignal).asSingleton();
        context.injector.map(PotionInventoryModel).asSingleton();
        context.injector.map(UpdatePotionInventorySignal).asSingleton();
        context.injector.map(VaultUpdateSignal).asSingleton();
        context.injector.map(VaultSlotUpdateSignal).asSingleton();
        context.commands.map(ShowSplashUISignal).toCommand(ShowSplashUICommand);
        context.commands.map(ShowLoadingUISignal).toCommand(ShowLoadingUICommand);
        context.commands.map(ShowTitleUISignal).toCommand(ShowTitleUICommand);
        context.commands.map(EnterGameSignal).toCommand(EnterGameCommand);
        context.mediators.map(SplashView, SplashMediator);
        context.mediators.map(LoadingScreen, LoadingMediator);
        context.mediators.map(CharacterSelectionAndNewsScreen, CurrentCharacterMediator);
        context.mediators.map(AccountInfoView, AccountInfoMediator);
        context.mediators.map(AccountScreen, AccountScreenMediator);
        context.mediators.map(TitleView, TitleMediator);
        context.mediators.map(NewCharacterScreen, NewCharacterMediator);
        context.mediators.map(MapEditor, MapEditorMediator);
        context.mediators.map(CurrentCharacterRect, CurrentCharacterRectMediator);
        context.mediators.map(CharacterRectList, CharacterRectListMediator);
        context.mediators.map(ErrorDialog, ErrorDialogMediator);
        context.mediators.map(NewsLine, NewsLineMediator);
        context.mediators.map(NotEnoughTsavoriteDialog, NotEnoughTsavoriteMediator);
        context.mediators.map(MessageCloseDialog, MessageCloseMediator);
        context.mediators.map(InteractPanel, InteractPanelMediator);
        context.mediators.map(ItemGrid, ItemGridMediator);
        context.mediators.map(ChooseNameRegisterDialog, ChooseNameRegisterMediator);
        context.mediators.map(CharacterSlotRegisterDialog, CharacterSlotRegisterMediator);
        context.mediators.map(RegisterPromptDialog, RegisterPromptDialogMediator);
        context.mediators.map(CharacterSlotNeedTsavoriteDialog, CharacterSlotNeedTsavoriteMediator);
        context.mediators.map(PlayerGroupMenu, PlayerGroupMenuMediator);
        context.mediators.map(StatMetersView, StatMetersMediator);
        context.mediators.map(HUDView, HUDMediator);
        context.mediators.map(PotionSlotView, PotionSlotMediator);
        context.mediators.map(VaultWindow, VaultWindowMediator);
        context.mediators.map(UnboxResultBox, UnboxResultBoxMediator);

        this.setupCharacterWindow(context);
        var startup:StartupSequence = context.injector.getInstance(StartupSequence);
        //this.startup.addSignal(ShowLoadingUISignal, -1);
        startup.addTask(LoadAccountTask);
        startup.addTask(GetCharListTask);
        startup.addSignal(ShowTitleUISignal, StartupSequence.LAST);
    }

    private function setupCharacterWindow(context:AppContext):void {
        context.injector.map(HUDModel).asSingleton();
        context.injector.map(UpdateHUDSignal).asSingleton();
        context.injector.map(HUDModelInitialized).asSingleton();
        context.commands.map(HUDSetupStarted).toCommand(HUDInitCommand);
        context.mediators.map(CharacterDetailsView, CharacterDetailsMediator);
    }
}
}
