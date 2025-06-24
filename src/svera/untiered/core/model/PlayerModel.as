package svera.untiered.core.model {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.appengine.SavedCharactersList;
import com.company.assembleegameclient.appengine.SavedNewsItem;

import org.osflash.signals.Signal;

import svera.untiered.account.core.Account;

public class PlayerModel {
    public const tsavoriteChanged:Signal = new Signal(int);
    public const medallionsChanged:Signal = new Signal(int);
    public const honorChanged:Signal = new Signal(int);
    public var charList:SavedCharactersList;
    public var isInvalidated:Boolean;
    public var currentCharId:int;

    [Inject]
    public var account:Account;

    public function PlayerModel() {
        super();
        this.isInvalidated = true;
    }

    public function getMaxCharacters():int {
        return this.charList.maxNumChars_;
    }

    public function setMaxCharacters(value:int):void {
        this.charList.maxNumChars_ = value;
    }

    public function getTraits():Array {
        return [this.charList.traitOne_, this.charList.traitTwo_, this.charList.traitThree_];
    }

    public function getTsavorite():int {
        return this.charList.tsavorite_;
    }

    public function changeTsavorite(tsavorite:int):void {
        this.charList.tsavorite_ = this.charList.tsavorite_ + tsavorite;
        this.tsavoriteChanged.dispatch(this.charList.tsavorite_);
    }

    public function setTsavorite(tsavorite:int):void {
        if (this.charList.tsavorite_ != tsavorite) {
            this.charList.tsavorite_ = tsavorite;
            this.tsavoriteChanged.dispatch(tsavorite);
        }
    }

    public function getMedallions():int {
        return this.charList.medallions_;
    }

    public function changeMedallions(medallions:int):void {
        this.charList.medallions_ = this.charList.medallions_ + medallions;
        this.medallionsChanged.dispatch(this.charList.medallions_);
    }

    public function setMedallions(medallions:int):void {
        if (this.charList.medallions_ != medallions) {
            this.charList.medallions_ = medallions;
            this.medallionsChanged.dispatch(medallions);
        }
    }

    public function getHonor():int {
        return this.charList.honor_;
    }

    public function changeHonor(honor:int):void {
        this.charList.honor_ = this.charList.honor_ + honor;
        this.honorChanged.dispatch(this.charList.honor_);
    }

    public function setHonor(honor:int):void {
        if (this.charList.honor_ != honor) {
            this.charList.honor_ = honor;
            this.honorChanged.dispatch(honor);
        }
    }

    public function getCharacterCount():int {
        return this.charList.numChars_;
    }

    public function getCharById(characterId:int):SavedCharacter {
        return this.charList.getCharById(characterId);
    }

    public function deleteCharacter(characterId:int):void {
        var char:SavedCharacter = this.charList.getCharById(characterId);
        var i:int = this.charList.savedChars_.indexOf(char);
        if (i != -1) {
            this.charList.savedChars_.splice(i, 1);
            this.charList.numChars_--;
        }
    }

    public function getAccountId():int {
        return this.charList.accountId_;
    }

    public function hasAccount():Boolean {
        return this.charList.accountId_ != -1;
    }

    public function getNumStars():int {
        return this.charList.numStars_;
    }

    public function getGuildName():String {
        return this.charList.guildName_;
    }

    public function getGuildRank():int {
        return this.charList.guildRank_;
    }

    public function getNextCharId():int {
        return this.charList.nextCharId_;
    }

    public function getCharacterById(id:int):SavedCharacter {
        var savedChar:SavedCharacter = null;
        for each(savedChar in this.charList.savedChars_) {
            if (savedChar.charId() == id) {
                return savedChar;
            }
        }
        return null;
    }

    public function getCharacterByIndex(i:int):SavedCharacter {
        return this.charList.savedChars_[i];
    }

    public function getNews():Vector.<SavedNewsItem> {
        return this.charList.news_;
    }

    public function getName():String {
        return this.charList.name_;
    }

    public function setName(value:String):void {
        this.charList.name_ = value;
    }

    public function hasAvailableCharSlot():Boolean {
        return this.charList.hasAvailableCharSlot();
    }

    public function getAvailableCharSlots():int {
        return this.charList.availableCharSlots();
    }

    public function getSavedCharacters():Vector.<SavedCharacter> {
        return this.charList.savedChars_;
    }

    public function getCharStats():Object {
        return this.charList.charStats_;
    }

    public function getBestHonor(objectType:int):int {
        return this.charList.bestHonor(objectType);
    }

    public function getBestLevel(unlockType:int):int {
        return this.charList.bestLevel(unlockType);
    }

    public function setCharacterList(savedCharactersList:SavedCharactersList):void {
        this.charList = savedCharactersList;
    }
}
}
