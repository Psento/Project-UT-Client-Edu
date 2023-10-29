package svera.untiered.legends.service
{
   import svera.lib.tasks.BaseTask;
   import svera.untiered.appengine.api.AppEngineClient;
   import svera.untiered.core.model.PlayerModel;
   import svera.untiered.legends.model.Legend;
   import svera.untiered.legends.model.LegendFactory;
   import svera.untiered.legends.model.LegendsModel;
   import svera.untiered.legends.model.Timespan;
   
   public class GetLegendsListTask extends BaseTask
   {
       
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var player:PlayerModel;
      
      [Inject]
      public var model:LegendsModel;
      
      [Inject]
      public var factory:LegendFactory;
      
      [Inject]
      public var timespan:Timespan;
      
      public var charId:int;
      
      public function GetLegendsListTask()
      {
         super();
      }
      
      override protected function startTask() : void
      {
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/fame/list",this.makeRequestObject());
      }
      
      private function onComplete(isOK:Boolean, data:*) : void
      {
         isOK && this.updateFameListData(data);
         completeTask(isOK,data);
      }
      
      private function updateFameListData(data:String) : void
      {
         var legends:Vector.<Legend> = this.factory.makeLegends(XML(data));
         this.model.setLegendList(legends);
      }
      
      private function makeRequestObject() : Object
      {
         var request:Object = {};
         request.timespan = this.timespan.getId();
         request.accountId = this.player.getAccountId();
         request.charId = this.charId;
         return request;
      }
   }
}
