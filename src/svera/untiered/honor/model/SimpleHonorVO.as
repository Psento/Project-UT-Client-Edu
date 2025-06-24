package svera.untiered.honor.model {
public class SimpleHonorVO implements HonorVO {


    private var accountId:int;

    private var characterId:int;

    public function SimpleHonorVO(accountId:int, characterId:int) {
        super();
        this.accountId = accountId;
        this.characterId = characterId;
    }

    public function getAccountId():int {
        return this.accountId;
    }

    public function getCharacterId():int {
        return this.characterId;
    }
}
}
