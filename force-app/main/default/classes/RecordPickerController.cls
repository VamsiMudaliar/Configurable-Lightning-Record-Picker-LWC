/**
 * @description       : This class exposes the getRecordPicker method to LWC.
 * @author            : Vamsi Mudaliar
 * @group             : MTX Group Inc
 * @last modified on  : 01-10-2024
 * @last modified by  : Vamsi Mudaliar
**/
public with sharing class RecordPickerController {
    @AuraEnabled(cacheable=true)
    public static RecordPickerWrapper.ObjectInfo getRecordPicker(string metadataName){
        return RecordPickerService.getRecordPicker(metadataName);
    }
}