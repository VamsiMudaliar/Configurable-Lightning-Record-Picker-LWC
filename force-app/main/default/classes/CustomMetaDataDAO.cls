/**
 * @description       : DAO Class for Fetch Metadata Config
 * @author            : Vamsi Mudaliar
 * @group             : MTX Group Inc
 * @last modified on  : 01-10-2024
 * @last modified by  : Vamsi Mudaliar
**/
public with sharing class CustomMetaDataDAO {

    
    public static List<RecordPickerConfig__mdt> getMetadataConfig(string metadataName) {
        return [SELECT Id, ObjectAPI__c, DisplayFieldName__c, DisplaySecondaryFields__c, 
               (SELECT Id, RecordPickerConfig__c, ConditionFieldAPI__c, Condition__c, ConditionValue__c, IsLiteral__c, IsDynamic__c 
                FROM RecordPickerConditionConfigs__r)
                                    FROM RecordPickerConfig__mdt where DeveloperName=:metadataName];   
    }
}