import { LightningElement,api,wire,track } from 'lwc';
import getRecordPicker from '@salesforce/apex/RecordPickerController.getRecordPicker';
import {
    showAsyncErrorMessage,
} from 'c/compUtils';
export default class DynamicLightningRecordPicker extends LightningElement {

    @api recordPickerConfigurationName;
    @api label = 'Account';
    @api placeHolder = 'Select...';
    @api filterLogic = '';

    @track config;
    @track matchingInfo;
    @track displayInfo;
    @track filter;
    objectName = 'Account';

    // Fetching the recordPicker Configuration set by Parent Comp / Page.
    @wire(getRecordPicker, { metadataName : '$recordPickerConfigurationName'})
    wiredConfigs({error,data}) {
        if(data) {
            this.config = data;
            this.error = null;
            this.setCriteria();
            this.setFields();
        }
        else if(error) {
            showAsyncErrorMessage(this,error);
            return;
        }
    }

    // Setting Matching Info and Display Info Dynamically
    setFields() {
        if(this.config) {

            this.matchingInfo = {
                primaryField: { fieldPath: this.config.primaryField }
            }

            // if there are secondary fields split them and add it in additional fields 
            if(this.config.secondaryFields) { 
                let secondFields=this.config.secondaryFields.split(',');
                let dispFields=[];
                let fldsNames=[];
                for(let cg of secondFields){
                    dispFields.push({ fieldPath: cg});
                    fldsNames.push(cg);
                }
                this.matchingInfo.additionalFields=dispFields;
                this.displayInfo={additionalFields:fldsNames};
            }
            this.refs.recordPicker.objectApiName = this.config.objectName;
            this.refs.recordPicker.matchingInfo = {...this.matchingInfo};
            this.refs.recordPicker.displayInfo = {...this.displayInfo};

        }
    }

    // setting filterCriteria 
    setCriteria() {
        let fltrs = [];
        // if there are Conditions configured...  
        if(this.config.conditions) {
            for(let cg of this.config.conditions){
                fltrs.push(
                    {
                        fieldPath: cg.fieldName,
                        operator: cg.condition,
                        value: cg.conditionValue,
                    },
                );
            }
            if(fltrs.length>0){
                this.filter = {
                    criteria: fltrs
                };
            }
            this.refs.recordPicker.filter = {...this.filter}
        }
        console.log('FILTER JSON >> ' + JSON.stringify(this.filter));
    }

    handleChange(event) {
        const recordId = event.detail.recordId;
        console.log('RECORD ID SELECTED >> ' + recordId);
        this.dispatchEvent(new CustomEvent('select',{
            detail : {recordId}
        }));
    }


}