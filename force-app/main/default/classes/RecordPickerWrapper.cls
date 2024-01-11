/**
 * @description       : A wrapper class to store RecordPicker Configuration.
 * @author            : Vamsi Mudaliar
 * @group             : MTX Group Inc
 * @last modified on  : 01-10-2024
 * @last modified by  : Vamsi Mudaliar
**/
public with sharing class RecordPickerWrapper {
    public class ObjectInfo{
        @auraenabled
        public string objectName {get;set;}
        @auraenabled
        public string primaryField {get;set;}
        @auraenabled  
        public string secondaryFields {get;set;}
        @auraenabled
        public List<FieldCondition> conditions {get;set;}
    }
    public class FieldCondition{
        @auraenabled
        public string fieldName {get;set;}
        @auraenabled
        public string condition {get;set;}
        @auraenabled
        public string conditionValue {get;set;}
        @auraenabled
        public boolean isLiteral {get;set;}
        @auraenabled
        public boolean isDynamicValue {get;set;}        
    }
}