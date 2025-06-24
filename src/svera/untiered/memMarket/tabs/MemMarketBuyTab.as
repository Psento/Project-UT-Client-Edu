package svera.untiered.memMarket.tabs {
import com.company.assembleegameclient.account.ui.MarketInput;
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.assembleegameclient.ui.dropdown.DropDown;
import com.company.util.KeyCodes;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.utils.Dictionary;

import svera.untiered.memMarket.content.MemMarketBuyItem;
import svera.untiered.memMarket.content.MemMarketItem;
import svera.untiered.memMarket.signals.MemMarketBuySignal;
import svera.untiered.memMarket.signals.MemMarketSearchSignal;
import svera.untiered.memMarket.utils.DialogUtils;
import svera.untiered.memMarket.utils.ItemUtils;
import svera.untiered.memMarket.utils.SortUtils;
import svera.untiered.messaging.impl.GameServerConnection;
import svera.untiered.messaging.impl.data.MarketData;
import svera.untiered.messaging.impl.incoming.market.MarketBuyResult;
import svera.untiered.messaging.impl.incoming.market.MarketSearchResult;

import mx.utils.StringUtil;

///TODO fix these
///Listing counter gets reset when search items get removed

public class MemMarketBuyTab extends MemMarketTab
{
    private static const SEARCH_X_OFFSET:int = 4;
    private static const SEARCH_Y_OFFSET:int = 170;
    private static const SEARCH_ITEM_SIZE:int = 50;

    private static const RESULT_X_OFFSET:int = 270;
    private static const RESULT_Y_OFFSET:int = 105;

    /* Signals */
    public const buySignal_:MemMarketBuySignal = new MemMarketBuySignal();
    public const searchSignal_:MemMarketSearchSignal = new MemMarketSearchSignal();

    private var searchField_:MarketInput;
    private var shape_:Shape;
    private var searchMask_:Sprite;
    private var searchBackground:Sprite;
    private var searchItems:Vector.<MemMarketItem>;
    private var searchScroll:Scrollbar;

    private var resultMask_:Sprite;
    private var resultBackground_:Sprite;
    private var resultItems_:Vector.<MemMarketBuyItem>;
    private var resultScroll_:Scrollbar;

    private var sortChoices_:DropDown;
    private var tierSortChoices_:DropDown;
    private var statSortChoices_:DropDown;
    private var itemTypeSortChoices_:DropDown;

    private var first_:Boolean = true;

    public function MemMarketBuyTab(gameSprite:GameSprite)
    {
        super(gameSprite);

        /* Initialize signals */
        this.buySignal_.add(this.onBuy);
        this.searchSignal_.add(this.onSearch);

        this.searchField_ = new MarketInput("Search", false, "");
        this.searchField_.x = SEARCH_X_OFFSET + 9;
        this.searchField_.y = 101;
        this.searchField_.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        addChild(this.searchField_);

        this.shape_ = new Shape();
        this.shape_.graphics.beginFill(0);
        this.shape_.graphics.drawRect(SEARCH_X_OFFSET, SEARCH_Y_OFFSET, 250, 350);
        this.shape_.graphics.endFill();
        this.searchMask_ = new Sprite();
        this.searchMask_.addChild(this.shape_);
        this.searchMask_.mask = this.shape_;
        addChild(this.searchMask_);
        this.searchBackground = new Sprite();
        this.searchMask_.addChild(this.searchBackground);

        this.searchItems = new Vector.<MemMarketItem>();

        this.shape_ = new Shape();
        this.shape_.graphics.beginFill(0);
        this.shape_.graphics.drawRect(RESULT_X_OFFSET, RESULT_Y_OFFSET, 500, 415);
        this.shape_.graphics.endFill();
        this.resultMask_ = new Sprite();
        this.resultMask_.addChild(this.shape_);
        this.resultMask_.mask = this.shape_;
        addChild(this.resultMask_);
        this.resultBackground_ = new Sprite();
        this.resultMask_.addChild(this.resultBackground_);

        this.resultItems_ = new Vector.<MemMarketBuyItem>();

        this.sortChoices_ = new DropDown(SortUtils.SORT_CHOICES, 200, 26);
        this.sortChoices_.x = 597;
        this.sortChoices_.y = 71;
        this.sortChoices_.setValue(SortUtils.LOWEST_TO_HIGHEST);
        this.sortChoices_.addEventListener(Event.CHANGE, this.onSortChoicesChanged);
        addChild(this.sortChoices_);

        this.tierSortChoices_ = new DropDown(SortUtils.TIER_SORT_CHOICES, 100, 26);
        this.tierSortChoices_.x = 500;
        this.tierSortChoices_.y = 71;
        this.tierSortChoices_.setValue(SortUtils.ALLTIERS);
        this.tierSortChoices_.addEventListener(Event.CHANGE, this.onTierChoice);
        addChild(this.tierSortChoices_);

        this.statSortChoices_ = new DropDown(SortUtils.STAT_SORT_CHOICES, 100, 26);
        this.statSortChoices_.x = 403;
        this.statSortChoices_.y = 71;
        this.statSortChoices_.setValue(SortUtils.ALLSTATS);
        this.statSortChoices_.addEventListener(Event.CHANGE, this.onStatChoice);
        addChild(this.statSortChoices_);

        this.itemTypeSortChoices_ = new DropDown(SortUtils.ITEMTYPE_SORT_CHOICES, 100, 26);
        this.itemTypeSortChoices_.x = 306;
        this.itemTypeSortChoices_.y = 71;
        this.itemTypeSortChoices_.setValue(SortUtils.ALLITEMTYPES);
        this.itemTypeSortChoices_.addEventListener(Event.CHANGE, this.onItemTypeChoice);
        addChild(this.itemTypeSortChoices_);

        this.searchItemsFunc(true);

        this.gameSprite_.gsc_.marketAll();
    }

    private function onSortChoicesChanged(event:Event) : void
    {
        this.sortOffers();
    }

    private function onKeyUp(event:KeyboardEvent) : void
    {
        if (event.keyCode == KeyCodes.ENTER)
        {
            this.searchItemsFunc();
        }
    }


    private function onSearchClick(event:MouseEvent) : void
    {
        var item:MemMarketItem = event.currentTarget as MemMarketItem;
        this.gameSprite_.gsc_.marketSearch(item.itemType_);
    }

    private function onSearchScrollChanged(event:Event) : void
    {
        this.searchBackground.y = -this.searchScroll.pos() * (this.searchBackground.height - 356);
    }

    /* Clear previous results */
    private function clearPreviousResults(result:Boolean) : void
    {
        if (result)
        {
            for each (var i:MemMarketBuyItem in this.resultItems_)
            {
                i.dispose();
                this.resultBackground_.removeChild(i);
                i = null;
            }
            this.resultItems_.length = 0;
        }
        else
        {
            for each (var o:MemMarketItem in this.searchItems)
            {
                o.removeEventListener(MouseEvent.CLICK, this.onSearchClick);
                o.dispose();
                this.searchBackground.removeChild(o);
                o = null;
            }
            this.searchItems.length = 0;
        }
    }

    /* Removes an offer from resultItems and sorts */
    private function removeOffer(id:int) : void
    {
        var index:int = 0;
        for each (var o:MemMarketBuyItem in this.resultItems_)
        {
            if (o.id_ == id) /* Item matched, remove */
            {
                this.resultItems_.splice(index, 1);
                o.dispose();
                o.parent.removeChild(o);
                o = null;
                break; /* No need to continue the loop after we got what we looked for */
            }
            index++;
        }

        this.sortOffers();
    }

    /* Sorts and positions offers */
    private function sortOffers() : void
    {
        switch (SortUtils.SORT_CHOICES[this.sortChoices_.getIndex()])
        {
            case SortUtils.LOWEST_TO_HIGHEST:
                this.resultItems_.sort(SortUtils.lowestToHighest);
                break;
            case SortUtils.HIGHEST_TO_LOWEST:
                this.resultItems_.sort(SortUtils.highestToLowest);
                break;
            /*case SortUtils.FAME_TO_GOLD:
                this.resultItems_.sort(SortUtils.honorToGold);
                break;
            case SortUtils.GOLD_TO_FAME:
                this.resultItems_.sort(SortUtils.goldToHonor);
                break; */
            case SortUtils.JUST_ADDED:
                this.resultItems_.sort(SortUtils.justAdded);
                break;
            case SortUtils.ENDING_SOON:
                this.resultItems_.sort(SortUtils.endingSoon);
                break;
        }

        var index:int = 0;
        for each (var i:MemMarketBuyItem in this.resultItems_)
        {
            i.x = MemMarketItem.OFFER_WIDTH * int(index % 5) + RESULT_X_OFFSET;
            i.y = MemMarketItem.OFFER_HEIGHT * int(index / 5) + RESULT_Y_OFFSET;
            index++;
        }
    }
    private function searchItemsFunc(first:Boolean = false) : void
    {
        /* Remove old scrollbar */
        if (this.searchScroll != null)
        {
            this.searchScroll.removeEventListener(Event.CHANGE, this.onSearchScrollChanged);
            removeChild(this.searchScroll);
            this.searchScroll = null;
        }

        if (!StringUtil.trim(this.searchField_.text()) && !first && !StringUtil.trim(this.searchField_.text()) == "") /* Clear results if empty */
        {
            this.clearPreviousResults(false);
            return;
        }

        this.clearPreviousResults(false);

        var index:int = 0;
        var itemType:int
        if (first)
        {
            for each (var w:String in ObjectLibrary.preloadedCustom_)
            {
                itemType = ObjectLibrary.idToTypeItems_[w];

                if (ItemUtils.isBanned(itemType) || ObjectLibrary.xmlLibrary_[itemType].TierType == "Stat") /* Skip on banned items */
                {
                    continue;
                }

                if(!TierSort(ObjectLibrary.xmlLibrary_[itemType]))
                {
                    continue;
                }

                if (!StatSort(ObjectLibrary.xmlLibrary_[itemType])) {
                    continue;
                }

                if(!ItemTypeSort(ObjectLibrary.xmlLibrary_[itemType]))
                {
                    continue;
                }
                var preloaded:MemMarketItem = new MemMarketItem(this.gameSprite_, SEARCH_ITEM_SIZE, SEARCH_ITEM_SIZE, 80, ObjectLibrary.idToTypeItems_[w], null);
                preloaded.x = SEARCH_ITEM_SIZE * int(index % 5) + SEARCH_X_OFFSET;
                preloaded.y = SEARCH_ITEM_SIZE * int(index / 5) + SEARCH_Y_OFFSET;
                preloaded.addEventListener(MouseEvent.CLICK, this.onSearchClick);
                preloaded.CreateLabel();
                this.searchItems.push(preloaded);
                index++;
            }
        }
        else
        {
            for each (var i:String in ObjectLibrary.typeToIdItems_)
            {
                if (i.indexOf(this.searchField_.text().toLowerCase()) >= 0)
                {
                    itemType = ObjectLibrary.idToTypeItems_[i];

                    if (ItemUtils.isBanned(itemType) || ObjectLibrary.xmlLibrary_[itemType].TierType == "Stat") /* Skip on banned items */
                    {
                        continue;
                    }

                    if(!TierSort(ObjectLibrary.xmlLibrary_[itemType]))
                    {
                        continue;
                    }
                    if (!StatSort(ObjectLibrary.xmlLibrary_[itemType])) {
                        continue;
                    }

                    if(!ItemTypeSort(ObjectLibrary.xmlLibrary_[itemType]))
                    {
                        continue;
                    }

                    var item:MemMarketItem = new MemMarketItem(this.gameSprite_, SEARCH_ITEM_SIZE, SEARCH_ITEM_SIZE, 80, ObjectLibrary.idToTypeItems_[i], null);
                    item.x = SEARCH_ITEM_SIZE * int(index % 5) + SEARCH_X_OFFSET;
                    item.y = SEARCH_ITEM_SIZE * int(index / 5) + SEARCH_Y_OFFSET;
                    item.addEventListener(MouseEvent.CLICK, this.onSearchClick);
                    item.CreateLabel();
                    this.searchItems.push(item);
                    index++;
                }
            }
        }

        for each (var x:MemMarketItem in this.searchItems) /* Draw our results */
        {
            this.searchBackground.addChild(x);
        }

        this.searchBackground.y = 0; /* Reset height */
        if (this.searchBackground.height > 350)
        {
            this.searchScroll = new Scrollbar(6, 350);
            this.searchScroll.x = 258;
            this.searchScroll.y = SEARCH_Y_OFFSET;
            this.searchScroll.setIndicatorSize(350, this.searchBackground.height);
            this.searchScroll.addEventListener(Event.CHANGE, this.onSearchScrollChanged);
            addChild(this.searchScroll);
        }
    }

    private function TierSort(xml:XML): Boolean
    {
        if(xml.hasOwnProperty("TierType")) {
            switch (SortUtils.TIER_SORT_CHOICES[this.tierSortChoices_.getIndex()]) {
                case SortUtils.ALLTIERS:
                    return true;
                case SortUtils.TARNISHED:
                    if (String(xml.TierType).match(/Tarnished$/i)) {
                        return true;
                    }
                    break;
                case SortUtils.ARTIFACT:
                    if (String(xml.TierType).match(/Artifact$/i)) {
                        return true;
                    }
                    break;
                case SortUtils.VALIANT:
                    if (String(xml.TierType).match(/Valiant$/i)) {
                        return true;
                    }
                    break;
                case SortUtils.RELIC:
                    if (String(xml.TierType).match(/Relic$/i)) {
                        return true;
                    }
                    break;
                case SortUtils.EXILED:
                    if (String(xml.TierType).match(/Exiled$/i)) {
                        return true;
                    }
                    break;
            }
        }
        return false;
    }

    private function StatSort(xml:XML): Boolean
    {
        var value:String = "";
        if(!xml.hasOwnProperty("ActivateOnEquip"))
        {
            switch (SortUtils.STAT_SORT_CHOICES[this.statSortChoices_.getIndex()]) {
                case SortUtils.ALLSTATS:
                    return true;
            }
        }
        for each (value in xml.ActivateOnEquip.@stat) {
            switch (SortUtils.STAT_SORT_CHOICES[this.statSortChoices_.getIndex()]) {
                case SortUtils.ALLSTATS:
                    return true;
                case SortUtils.HP:
                    if (int(value) == 0) {
                        return true;
                    }
                    break;
                case SortUtils.MP:
                    if (int(value) == 3) {
                        return true;
                    }
                    break;
                case SortUtils.ATK:
                    if (int(value) == 20) {
                        return true;
                    }
                    break;
                case SortUtils.DEF:
                    if (int(value) == 21) {
                        return true;
                    }
                    break;
                case SortUtils.SPD:
                    if (int(value) == 22) {
                        return true;
                    }
                    break;
                case SortUtils.VIT:
                    if (int(value) == 26) {
                        return true;
                    }
                    break;
                case SortUtils.WIS:
                    if (int(value) == 27) {
                        return true;
                    }
                    break;
                case SortUtils.DEX:
                    if (int(value) == 28) {
                        return true;
                    }
                    break;
                case SortUtils.FRT:
                    if (int(value) == 102) {
                        return true;
                    }
                    break;
                case SortUtils.MGT:
                    if (int(value) == 112) {
                        return true;
                    }
                    break;
                case SortUtils.LCK:
                    if (int(value) == 114) {
                        return true;
                    }
                    break;
                case SortUtils.RES:
                    if (int(value) == 121) {
                        return true;
                    }
                    break;
                case SortUtils.PRT:
                    if (int(value) == 122) {
                        return true;
                    }
                    break;
            }
        }
        return false;
    }

    private function ItemTypeSort(xml:XML): Boolean
    {
        var value:String = "";
        for each (value in xml.SlotType) {
            switch (SortUtils.ITEMTYPE_SORT_CHOICES[this.itemTypeSortChoices_.getIndex()]) {
                case SortUtils.ALLITEMTYPES:
                    return true;
                case SortUtils.SWORD:
                    if (int(value) == 1) {
                        return true;
                    }
                    break;
                case SortUtils.DAGGER:
                    if (int(value) == 2) {
                        return true;
                    }
                    break;
                case SortUtils.BOW:
                    if (int(value) == 3) {
                        return true;
                    }
                    break;
                case SortUtils.WAND:
                    if (int(value) == 8) {
                        return true;
                    }
                    break;
                case SortUtils.STAFF:
                    if (int(value) == 17) {
                        return true;
                    }
                    break;
                case SortUtils.KATANA:
                    if (int(value) == 24) {
                        return true;
                    }
                    break;
                case SortUtils.LANCE:
                    if (int(value) == 29) {
                        return true;
                    }
                    break;
                case SortUtils.BLADES:
                    if (int(value) == 34) {
                        return true;
                    }
                    break;
                case SortUtils.LIGHTARMOR:
                    if (int(value) == 14) {
                        return true;
                    }
                    break;
                case SortUtils.MEDIUMARMOR:
                    if (int(value) == 6) {
                        return true;
                    }
                    break;
                case SortUtils.HEAVYARMOR:
                    if (int(value) == 7) {
                        return true;
                    }
                    break;
                case SortUtils.TOME:
                    if (int(value) == 4) {
                        return true;
                    }
                    break;
                case SortUtils.SHIELD:
                    if (int(value) == 5) {
                        return true;
                    }
                    break;
                case SortUtils.SPELL:
                    if (int(value) == 11) {
                        return true;
                    }
                    break;
                case SortUtils.SEAL:
                    if (int(value) == 12) {
                        return true;
                    }
                    break;
                case SortUtils.CLOAK:
                    if (int(value) == 13) {
                        return true;
                    }
                    break;
                case SortUtils.QUIVER:
                    if (int(value) == 15) {
                        return true;
                    }
                    break;
                case SortUtils.HELMET:
                    if (int(value) == 16) {
                        return true;
                    }
                    break;
                case SortUtils.POISON:
                    if (int(value) == 18) {
                        return true;
                    }
                    break;
                case SortUtils.SKULL:
                    if (int(value) == 19) {
                        return true;
                    }
                    break;
                case SortUtils.TRAP:
                    if (int(value) == 20) {
                        return true;
                    }
                    break;
                case SortUtils.ORB:
                    if (int(value) == 21) {
                        return true;
                    }
                    break;
                case SortUtils.PRISM:
                    if (int(value) == 22) {
                        return true;
                    }
                    break;
                case SortUtils.SCEPTER:
                    if (int(value) == 23) {
                        return true;
                    }
                    break;
                case SortUtils.SHURIKEN:
                    if (int(value) == 25) {
                        return true;
                    }
                    break;
                case SortUtils.SHEATH:
                    if (int(value) == 27) {
                        return true;
                    }
                    break;
                case SortUtils.BANNER:
                    if (int(value) == 28) {
                        return true;
                    }
                    break;
                case SortUtils.SIPHON:
                    if (int(value) == 30) {
                        return true;
                    }
                    break;
                case SortUtils.CHARM:
                    if (int(value) == 32) {
                        return true;
                    }
                    break;
                case SortUtils.DICE:
                    if (int(value) == 33) {
                        return true;
                    }
                    break;
                case SortUtils.JACKET:
                    if (int(value) == 35) {
                        return true;
                    }
                    break;
                case SortUtils.TALISMAN:
                    if (int(value) == 36) {
                        return true;
                    }
                    break;
                case SortUtils.ACCESSORY:
                    if (int(value) == 9) {
                        return true;
                    }
                    break;
                case SortUtils.INGREDIENT:
                    if (int(value) == 37) {
                        return true;
                    }
                    break;
                case SortUtils.UTILITY:
                    if (int(value) == 38) {
                        return true;
                    }
                    break;
                case SortUtils.CAPSULE:
                    if (int(value) == 39) {
                        return true;
                    }
                    break;
            }
        }
        return false;
    }

    private function refreshOffers() : void
    {
        for each (var o:MemMarketBuyItem in this.resultItems_)
        {
            o.updateButton();
        }
    }
    /* Buy and refresh offers */
    private function onBuy(result:MarketBuyResult) : void
    {
        if (result.code_ != -1)
        {
            DialogUtils.makeSimpleDialog(this.gameSprite_, "Error", result.description_);
            return;
        }

        this.removeOffer(result.offerId_);
        this.refreshOffers();

        DialogUtils.makeSimpleDialog(this.gameSprite_, "Success", result.description_);
    }

    /* Refresh and add found offers */
    private function onSearch(result:MarketSearchResult) : void
    {
        if (result.description_ != "")
        {
            this.clearPreviousResults(true);
            DialogUtils.makeSimpleDialog(this.gameSprite_, "Error", result.description_);
            return;
        }

        /* Remove old scrollbar */
        if (this.resultScroll_ != null)
        {
            this.resultScroll_.removeEventListener(Event.CHANGE, this.onResultScrollChanged);
            removeChild(this.resultScroll_);
            this.resultScroll_ = null;
        }

        this.clearPreviousResults(true);

        for each (var i:MarketData in result.results_)
        {
            var item:MemMarketBuyItem = new MemMarketBuyItem(this.gameSprite_, i);
            this.resultItems_.push(item);

            //could be pretty slow when theres lots of items to loop through
            if(this.first_)
            {
                for each(var marketItem:MemMarketItem in this.searchItems)
                {
                    if(marketItem.itemType_ == i.itemType_)
                    {
                        marketItem.UpdateCounter();
                    }
                }
            }
        }
        this.first_ = false;

        this.sortOffers();


        for each (var o:MemMarketBuyItem in this.resultItems_)
        {
            this.resultBackground_.addChild(o);
        }

        this.resultBackground_.y = 0; /* Reset height */
        if (this.resultBackground_.height > 436)
        {
            this.resultScroll_ = new Scrollbar(22, 415);
            this.resultScroll_.x = 774;
            this.resultScroll_.y = RESULT_Y_OFFSET;
            this.resultScroll_.setIndicatorSize(415, this.resultBackground_.height);
            this.resultScroll_.addEventListener(Event.CHANGE, this.onResultScrollChanged);
            addChild(this.resultScroll_);
        }
    }

    private function onResultScrollChanged(event:Event) : void
    {
        this.resultBackground_.y = -this.resultScroll_.pos() * (this.resultBackground_.height - 418);
    }

    /* Clear */
    public override function dispose() : void
    {
        this.buySignal_.remove(this.onBuy);
        this.searchSignal_.remove(this.onSearch);

        this.searchField_.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        this.searchField_ = null;

        this.shape_.parent.removeChild(this.shape_);
        this.shape_ = null;

        this.clearPreviousResults(false);
        this.searchItems = null;
        this.searchMask_.removeChild(this.searchBackground);
        this.searchMask_ = null;
        this.searchBackground = null;

        if (this.searchScroll != null)
        {
            this.searchScroll.removeEventListener(Event.CHANGE, this.onSearchScrollChanged);
            this.searchScroll = null;
        }

        this.clearPreviousResults(true);
        this.resultItems_ = null;

        this.resultMask_.removeChild(this.resultBackground_);
        this.resultMask_ = null;
        this.resultBackground_ = null;

        if (this.resultScroll_ != null)
        {
            this.resultScroll_.removeEventListener(Event.CHANGE, this.onResultScrollChanged);
            this.resultScroll_ = null;
        }

        this.sortChoices_.removeEventListener(Event.CHANGE, this.onSortChoicesChanged);
        this.sortChoices_ = null;

        this.tierSortChoices_.removeEventListener(Event.CHANGE, this.onTierChoice);
        this.tierSortChoices_ = null;

        this.statSortChoices_.removeEventListener(Event.CHANGE, this.onStatChoice);
        this.statSortChoices_ = null;

        this.itemTypeSortChoices_.removeEventListener(Event.CHANGE, this.onItemTypeChoice);
        this.itemTypeSortChoices_ = null;

        super.dispose();
    }

    private function onTierChoice(event:Event):void
    {
        this.searchItemsFunc();
        //searchItemsFunc(false);
        //tierSort();
    }

    private function onStatChoice(event:Event):void
    {
        this.searchItemsFunc();
        //searchItemsFunc(false);
        //tierSort();
    }

    private function onItemTypeChoice(event:Event):void
    {
        this.searchItemsFunc();
        //searchItemsFunc(false);
        //tierSort();
    }

}
}
