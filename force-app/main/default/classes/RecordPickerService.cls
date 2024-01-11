/**
 * @description       : This Class handles the Fetching Record Picker Configuration
 * @author            : Vamsi Mudaliar
 * @group             : 
 * @last modified on  : 01-11-2024
 * @last modified by  : Vamsi Mudaliar
**/
public with sharing class RecordPickerService {

    //Get Record Picker Setting for provided configuration
	public static RecordPickerWrapper.ObjectInfo getRecordPicker(string metadataName){
        try {
            List<RecordPickerConfig__mdt> mdt = CustomMetaDataDAO.getMetadataConfig(metadataName);
            if(mdt == null || mdt.isEmpty()) {
                // throw new CustomException('No Suitable Configuration Found');
                return null;
            }
            
            RecordPickerWrapper.ObjectInfo objDto = new RecordPickerWrapper.ObjectInfo();
            objDto.objectName = mdt[0].ObjectAPI__c;
            objDto.primaryField = mdt[0].DisplayFieldName__c;
            objDto.secondaryFields = mdt[0].DisplaySecondaryFields__c;

            //Loop all condition for record picker
            List<RecordPickerWrapper.FieldCondition> fields = new List<RecordPickerWrapper.FieldCondition>();
            for(RecordPickerConditionConfig__mdt cm : mdt[0].getSObjects('RecordPickerConditionConfigs__r')) {

                RecordPickerWrapper.FieldCondition fCondition = new RecordPickerWrapper.FieldCondition();
                fCondition.fieldName = String.valueOf(cm.get('ConditionFieldAPI__c'));
                fCondition.condition = String.valueOf(cm.get('Condition__c'));
                fCondition.conditionValue = String.valueOf(cm.get('ConditionValue__c'));
                fCondition.isLiteral = Boolean.valueOf(cm.get('IsLiteral__c'));
                fCondition.isDynamicValue = Boolean.valueOf(cm.get('IsDynamic__c'));
                fields.add(fCondition);
            }
            objDto.conditions = fields;
            return objDto;
        }
        catch(Exception ex) {
            throw new CustomException('Something went Wrong, While fetching Details');
        }
    }


}