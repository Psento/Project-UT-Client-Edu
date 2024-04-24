package svera.untiered.storage {
import svera.untiered.storage.components.StorageSortTab;

public class StorageUtil {

    public static const VAULT:int = 0;
    public static const GIFT:int = 1;

    public static const WINDOW_SIZE:int = 500;

    public static const CONTENT_WIDTH:int = 380;
    public static const CONTENT_HEIGHT:int = 400;
    public static const LEFT_PAD:int = 60;
    public static const TOP_PAD:int = 10;

    public static function makeStorageSortCategories() : Vector.<StorageSortTab> {
        var categories:Vector.<StorageSortTab> = new Vector.<StorageSortTab>();

        categories[0] = new StorageSortTab(StorageSortTab.ALL);
        categories[1] = new StorageSortTab(StorageSortTab.WEAPON);
        categories[2] = new StorageSortTab(StorageSortTab.ABILITY);
        categories[3] = new StorageSortTab(StorageSortTab.ARMOR);
        categories[4] = new StorageSortTab(StorageSortTab.MISC);

        return categories;
    }
}
}
